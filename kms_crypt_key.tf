resource "google_kms_crypto_key" "sample_crypto_key" {
  name     = "sample_crypto_key"
  key_ring = google_kms_key_ring.sample_key_ring.id
}
