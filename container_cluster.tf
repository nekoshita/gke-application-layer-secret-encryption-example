resource "google_container_cluster" "my_cluster" {
  name     = "my-cluster"
  location = var.gcp_zones["tokyo-a"]
  project  = var.gcp_project_id

  # デフォルトのノードプールがないクラスターを作成することはできないので、
  # クラスター作成直後にデフォルトのノードプールを削除する
  remove_default_node_pool = true
  initial_node_count       = 1

  # アプリケーションレイヤでのシークレットの暗号化を有効にする
  # KMSを使ってsecretを暗号化できる
  database_encryption {
    state    = "ENCRYPTED"
    key_name = google_kms_crypto_key.sample_crypto_key.self_link
  }
}

resource "google_container_node_pool" "my_cluster_nodes" {
  name       = "my-node-pool"
  location   = var.gcp_zones["tokyo-a"]
  cluster    = google_container_cluster.my_cluster.name
  node_count = 1

  node_config {
    preemptible  = true
    machine_type = "n1-standard-1"

    service_account = google_service_account.my_cluster.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
