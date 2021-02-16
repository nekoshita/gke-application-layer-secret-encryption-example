resource "google_project_iam_custom_role" "gke_cluster_defualt_to_access_kms" {
  role_id = "GKEClusterDefaulttoAccessKMS"
  title   = "GKEClusterDefaulttoAccessKMS"

  permissions = [
    # KMSを使った暗号化、復号化に必要なロール
    "cloudkms.cryptoKeyVersions.useToDecrypt",
    "cloudkms.cryptoKeyVersions.useToEncrypt"
  ]
}
