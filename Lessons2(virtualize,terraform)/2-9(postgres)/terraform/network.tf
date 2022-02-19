
resource "yandex_vpc_network" "rnb_test" {
    description = "avagagapov test cloud"
    name = "rnb-test"
    folder_id = data.yandex_resourcemanager_folder.default.folder_id
}
resource "yandex_vpc_subnet" "avagapov_test_a" {
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.rnb_test.id
  v4_cidr_blocks = ["10.18.1.0/24"]
}
resource "yandex_vpc_subnet" "avagapov_test_b" {
  zone           = "ru-central1-b"
  network_id     = yandex_vpc_network.rnb_test.id
  v4_cidr_blocks = ["10.28.1.0/24"]
}
resource "yandex_vpc_subnet" "avagapov_test_c" {
  zone           = "ru-central1-c"
  network_id     = yandex_vpc_network.rnb_test.id
  v4_cidr_blocks = ["10.38.1.0/24"]
}

