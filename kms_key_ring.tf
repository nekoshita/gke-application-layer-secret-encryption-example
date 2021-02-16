resource "google_kms_key_ring" "sample_key_ring" {
  name = "sample_key_ring"
  # GKEクラスタと同じリージョンに作成する必要がある
  location = var.gcp_regions["tokyo"]
}
