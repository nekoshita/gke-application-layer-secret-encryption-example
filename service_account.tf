resource "google_service_account" "my_cluster" {
  account_id   = "my-cluster"
  display_name = "My Service Account For My Cluster"
}
