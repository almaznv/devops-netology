
 ## Домашнее задание к занятию "3.3. Операционные системы, лекция 1"
 #### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/03-sysadmin-03-os


1. chdir("/tmp")
2. /usr/share/misc/magic.mgc
3. Командой sudo "lsof -p <PID> | grep deleted" выясняем номер дескриптора (FD_NUM).  
очищаем данные: echo "" | sudo tee /proc/<PID>/fd/<FD_NUM>
4. Не потребляют, они же мертвы. 
Единственная опасность, нехватка места в таблице процессов (cat /proc/sys/kernel/threads-max чтобы вяснить максимум)  
5. Не уверен что правильно понял задачу.  Сделал strace opensnoop-bpfcc в файл, grep-нул openat.

openat(AT_FDCWD, "/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libc.so.6", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libpthread.so.0", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libdl.so.2", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libutil.so.1", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libm.so.6", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libexpat.so.1", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/lib/x86_64-linux-gnu/libz.so.1", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/usr/lib/x86_64-linux-gnu/gconv/gconv-modules.cache", O_RDONLY) = 3  
openat(AT_FDCWD, "/usr/bin/pyvenv.cfg", O_RDONLY) = -1 ENOENT (No such file or directory)  
openat(AT_FDCWD, "/usr/pyvenv.cfg", O_RDONLY) = -1 ENOENT (No such file or directory)  
openat(AT_FDCWD, "/etc/localtime", O_RDONLY|O_CLOEXEC) = 3  
openat(AT_FDCWD, "/usr/lib/python3.8", O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = 3  
.....

6. Используется: uname()  
Выдержка из справки: "Part of the utsname information is also accessible via /proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}."
7. через ";" - список команд, которые выполнятся поочереди. Exit code от последней команды в списке.
через "&&" - команда справа выполнится если команда слева возвращает 0 (успех).  
В шелле команда "set -e; test -d <не существующая директория>; echo Hi" приводит к завершению текущего процесса bash. В этом случае наверное не стоит использовать так :)  
Но если использовать в скрипте, то любая команда вернувшая не успешный статус, этот завершит процесс. И в этом смысле это похоже на применение &&, и смысл есть.
8. Опции:  
-e  Exit immediately if a command exits with a non-zero status.  
-u  Treat unset variables as an error when substituting.   
-x  Print commands and their arguments as they are executed.   
-o  pipefail  - the return value of a pipeline is the status of the last command to exit with a non-zero status, or zero if no command exited with a non-zero status
Команда позволит предотвратить запуск команд после произошедшей ошибки, в т.ч. в пайплайне, увидеть очередность выполненных команд с аргументами.
Полезно при отладке скриптов и для уверенности что не выполнится ошибочный сценарий.
9. Больше всего S- interruptible sleep, на втором месте I - Idle kernel thread
