resource "google_project_iam_binding" "gke_cluster_defualt_to_access_kms" {
  role = google_project_iam_custom_role.gke_cluster_defualt_to_access_kms.id

  members = [
    # 下はGKEサービスアカウントで、各プロジェクトにデフォルトで作成されているサービスアカウントです。
    # アプリケーションレイヤでのシークレットの暗号化をするには、下のサービスアカウントにKMSでの暗号化、復号化の権限を付与する必要があります。
    # https://cloud.google.com/kubernetes-engine/docs/how-to/encrypting-secrets#grant_permission_to_use_the_key
    "serviceAccount:service-${var.gcp_project_number}@container-engine-robot.iam.gserviceaccount.com",
  ]
}
