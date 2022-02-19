variable "ya_auth_token" {
    description = "Security token or IAM token used for authentication in Yandex.Cloud"
    type = string
}

variable "ya_key_file" {
    description = "Path to service account key file"
    type = string
}

variable "ya_cloud_id" {
    description = "The ID of the cloud to apply any resources to"
    type = string
}

variable "ya_folder_id" {
    description = "The ID of the folder to operate under"
    type = string
}

variable "ya_zone" {
    description = "availability zone"
    type = string
    default = "ru-central1-a"
}

variable "ubuntu2004" {
  default = "fd81hgrcv6lsnkremf32"
}
