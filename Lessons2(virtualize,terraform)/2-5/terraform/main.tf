terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  token                    = var.ya_auth_token
  cloud_id                 = var.ya_cloud_id
  folder_id                = var.ya_folder_id
  zone                     = var.ya_zone
}