

resource "yandex_compute_disk" "test_boot_disk" {
  name     = "test-boot-disk"
  type     = "network-ssd"
  zone     = "ru-central1-a"
  size     = 50
  folder_id   = data.yandex_resourcemanager_folder.default.folder_id
  snapshot_id = "fd8vv1oa8r48eh485r37"

}

resource "yandex_compute_instance" "test" {
  description = "test"
  name        = "test"
  hostname    = "test"
  zone        = "ru-central1-a"
  platform_id = "standard-v3"
  folder_id   = data.yandex_resourcemanager_folder.default.folder_id
  allow_stopping_for_update = true

  depends_on = [yandex_compute_disk.test_boot_disk, yandex_vpc_subnet.avagapov_test_a]

  resources {
    cores  = 2 //8
    memory = 4 //64
  }

  boot_disk {
    disk_id     = yandex_compute_disk.test_boot_disk.id
    device_name = "devafs-boot"
    auto_delete = true
  }


  network_interface {
    subnet_id = yandex_vpc_subnet.avagapov_test_a.id
    nat = true
    security_group_ids = []
  }

  metadata = {
    user-data = file("../../../secret/cloud-config.yml")
  }

}

output "test_external_ip" {
  value = "${yandex_compute_instance.test.network_interface.0.nat_ip_address}"
}





