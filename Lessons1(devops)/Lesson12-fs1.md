 ## Домашнее задание к занятию "Домашнее задание по лекции "Файловые системы""
 #### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/03-sysadmin-05-fs

1. Прочитаны материалы по sparse файлам
2. Файлы - жесткие ссылки на один объект не могут иметь разные права и владельца, т.к. ссылаются на один inode. Права и владелец привязаны к inode, в отличии от символических ссылок




14 Вывод lsblk
>NAME                 MAJ:MIN RM  SIZE RO TYPE  MOUNTPOINT  
sda                    8:0    0   64G  0 disk  
├─sda1                 8:1    0  512M  0 part  /boot/efi  
├─sda2                 8:2    0    1K  0 part  
└─sda5                 8:5    0 63.5G  0 part  
    ├─vgvagrant-root   253:0    0 62.6G  0 lvm   /  
    └─vgvagrant-swap_1 253:1    0  980M  0 lvm   [SWAP]  
sdb                    8:16   0  2.5G  0 disk  
├─sdb1                 8:17   0    2G  0 part  
│ └─md0                9:0    0    2G  0 raid1  
│   └─myvg-lvol0     253:2    0  100M  0 lvm   /tmp/new  
└─sdb2                 8:18   0  511M  0 part  
  └─md1                9:1    0 1018M  0 raid0  
sdc                    8:32   0  2.5G  0 disk  
├─sdc1                 8:33   0    2G  0 part  
│ └─md0                9:0    0    2G  0 raid1  
│   └─myvg-lvol0     253:2    0  100M  0 lvm   /tmp/new  
└─sdc2                 8:34   0  511M  0 part  
  └─md1                9:1    0 1018M  0 raid0  


18. Вывод dmesg 
> [Sun Oct  3 17:27:39 2021] md/raid1:md127: Disk failure on sdb1, disabling device.
                           md/raid1:md127: Operation continuing on 1 devices.