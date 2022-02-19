data "yandex_resourcemanager_folder" "default" {
  name     = "netology"
  cloud_id = "b1guasjnflc04401dbfo"
}

data "yandex_compute_image" "ubuntu2004" {
  family = "ubuntu-2004-lts"
}

