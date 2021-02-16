resource "google_kms_key_ring" "sample_key_ring_v2" {
  name = "sample_key_ring_v2"
  # GKEクラスタと同じリージョンに作成する必要がある
  location = var.gcp_regions["tokyo"]
}

resource "google_kms_crypto_key" "sample_crypto_key" {
  name     = "sample_crypto_key"
  key_ring = google_kms_key_ring.sample_key_ring_v2.id
}

resource "google_kms_key_ring_iam_member" "key_ring" {
  key_ring_id = google_kms_key_ring.sample_key_ring_v2.id
  role        = google_project_iam_custom_role.gke_cluster_defualt_to_access_kms.id

  # 下はGKEサービスアカウントで、各プロジェクトにデフォルトで作成されているサービスアカウントです。
  # アプリケーションレイヤでのシークレットの暗号化をするには、下のサービスアカウントにKMSでの暗号化、復号化の権限を付与する必要があります。
  # https://cloud.google.com/kubernetes-engine/docs/how-to/encrypting-secrets#grant_permission_to_use_the_key
  member = "serviceAccount:service-${var.gcp_project_number}@container-engine-robot.iam.gserviceaccount.com"
}

resource "google_project_iam_custom_role" "gke_cluster_defualt_to_access_kms" {
  role_id = "GKEClusterDefaulttoAccessKMS"
  title   = "GKE Cluster Default to AccessKMS"

  permissions = [
    # KMSを使った暗号化、復号化に必要なロール
    "cloudkms.cryptoKeyVersions.useToDecrypt",
    "cloudkms.cryptoKeyVersions.useToEncrypt"
  ]
}
