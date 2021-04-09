#Dodanie wymaganych providerów

provider "google" {
 project     = "karotki-acc-2021"
 region      = "europe-west1"
 zone        = "europe-west1-b"
}
#-------------------------------------------------------

#Utworzenie losowego identyfikatora, który będzie użyty do nadawania nazwy zasobom
resource "random_id" "instance_id" {
 byte_length = 8
}
#-------------------------------------------------------

#Utworzenie maszyny wirtualnej z wykorzystaniem własnego klucza w polu kms_key_self_link

resource "google_compute_instance" "default" {
 name         = "karotki-dary-vm-${random_id.instance_id.hex}"
 machine_type = "f1-micro"

 boot_disk {
#   kms_key_self_link = ""
   initialize_params {
     image = "debian-cloud/debian-9"
   }
 }

 network_interface {
   network = "default"

   access_config {
     
   }
 }
}
#-------------------------------------------------------

#Utworzenie bucketu zaszyfrowanego własnym kluczem podanym w polu default_kms_key_name

resource "google_storage_bucket" "testowy-bucket"{
  name          = "karotki-dary-${random_id.instance_id.hex}"
  location      = "europe-west1"
  force_destroy = true

  bucket_policy_only = true

#  encryption {
#    default_kms_key_name = ""
#}
}
#-------------------------------------------------------