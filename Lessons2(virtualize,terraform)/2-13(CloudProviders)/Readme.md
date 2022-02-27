## Домашнее задание к занятию "7.2. Облачные провайдеры и синтаксис Terraform."

1. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-1-%D0%B2%D0%B0%D1%80%D0%B8%D0%B0%D0%BD%D1%82-%D1%81-aws-%D1%80%D0%B5%D0%B3%D0%B8%D1%81%D1%82%D1%80%D0%B0%D1%86%D0%B8%D1%8F-%D0%B2-aws-%D0%B8-%D0%B7%D0%BD%D0%B0%D0%BA%D0%BE%D0%BC%D1%81%D1%82%D0%B2%D0%BE-%D1%81-%D0%BE%D1%81%D0%BD%D0%BE%D0%B2%D0%B0%D0%BC%D0%B8-%D0%BD%D0%B5%D0%BE%D0%B1%D1%8F%D0%B7%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE-%D0%BD%D0%BE-%D0%BA%D1%80%D0%B0%D0%B9%D0%BD%D0%B5-%D0%B6%D0%B5%D0%BB%D0%B0%D1%82%D0%B5%D0%BB%D1%8C%D0%BD%D0%BE)

```shell
> aws configure list

      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************IVQF              env
secret_key     ****************bPdh              env
    region                eu-west-1      config-file    ~/.aws/config
    
```

2. [Задание](https://github.com/netology-code/virt-homeworks/tree/master/07-terraform-02-syntax#%D0%B7%D0%B0%D0%B4%D0%B0%D1%87%D0%B0-2-%D1%81%D0%BE%D0%B7%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5-aws-ec2-%D0%B8%D0%BB%D0%B8-yandex_compute_instance-%D1%87%D0%B5%D1%80%D0%B5%D0%B7-%D1%82%D0%B5%D1%80%D1%80%D0%B0%D1%84%D0%BE%D1%80%D0%BC)  

**Вопрос:** при помощи какого инструмента (из разобранных на прошлом занятии) можно создать свой образ ami?  
**Ответ:** packer

**Вопрос:** Ссылку на репозиторий с исходной конфигурацией терраформа  
**Ответ:**  https://github.com/almaznv/devops-netology/tree/main/Lessons2(virtualize%2Cterraform)/2-13(CloudProviders)/terraform
