# Configure the Google Cloud provider
provider "google" {
  credentials = "${file("account.json")}"
  project     = "admarvelnoc"
  region      = "us-east1-c"
}
