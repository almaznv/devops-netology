data "yandex_resourcemanager_folder" "default" {
  name     = "netology"
  cloud_id = "b1guasjnflc04401dbfo"
}

data "yandex_compute_image" "ubuntu2004" {
  family = "ubuntu-2004-lts"
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}


provider "yandex" {
  service_account_key_file     = "../../../secret/cloud-key.json"
  cloud_id  = "b1guasjnflc04401dbfo"
  folder_id = "b1gk759mka5sv3s1q679"
  zone      = "ru-central1-a"
}
