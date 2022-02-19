resource "local_file" "inventory" {
  content = <<-DOC
    [all:children]
    test

    [test]
    ${yandex_compute_instance.test.name} ansible_host=${yandex_compute_instance.test.network_interface.0.nat_ip_address} ansible_user=ops ansible_port=22 ansible_connection=ssh ansible_ssh_private_key_file="~/.ssh/id_rsa"

    DOC
  filename = "../ansible/inventory"

  depends_on = [
    yandex_compute_instance.test
  ]
}

resource "local_file" "ansiblecfg" {
  content = <<-DOC

    [defaults]
    stdout_callback    = yaml
    host_key_checking  = false
    inventory          = ./inventory
    roles_path         = ../../../ansible_roles

    DOC
  filename = "../ansible/ansible.cfg"

}