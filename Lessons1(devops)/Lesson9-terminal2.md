

 ## Домашнее задание к занятию "3.2. Работа в терминале, лекция 2"
 #### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/03-sysadmin-02-terminal


1. cd это builtin команда, т.е. встроенная в систему, а не, например, установленная. 
Builtin команды по сути представляют собой базовый интерфейс для общения системой, 
cd - базовая функция навигации по файловой системе.

2. "grep <some_string> <some_file> -c". Количество строк можно получить добавив параметр  "-c"
3. systemd
4. ls 2>/dev/pts/x, где x номер терминала
5. wc -l < file.txt > new_file.txt
6. Получится перенаправлением вывода echo Hello > /dev/tty1. В этом же терминале (pts/x) конечно не увидим
Но можем наблюдать подключившись "напрямую" (открыв виртуалку через virtualbox , а не через ssh)
7. Приведет к созданию запуску новой сессии терминала с новым PID и созданию дескриптора процесса 5 вывод которого направлен на std out. 
Фактически дескрпитор 5 в новой сессии станет дублем stdout. Поэтому перенаправление потока в него, даст такой же результат как и перенаправление в 1 (stdout)
8. ls -la <несуществующая директория> 1>&5 2>&5 5>&1 | wc -l
9. это переменные окружения. можно получить , например, командой printenv
10. /proc/<PID>/cmdline - команда ( с параметрами запуска ) с помощью которой был запущен процесс   
/proc/<PID>/exe - символическая ссылка к файлу запуска этого процесса
11. SSE 4.2
12. В примере "ssh localhost 'tty'", судя по всему ssh просто выполняет команду на remote сервере без создания PTY. Поэтому ошибка   
Справка man ssh говорит что можно изменить параметром -t (Force pseudo-terminal allocation). 
13. Изучил screen и reptyr. С помощью reptyr переносил процесс "top" между терминалами. Если смотреть pstree, процесс не становится дочерним текущему. Reptyr это просто "прокси" к процессу.
14. "tee" - читает из stdin пишет в stdout или файл  
"sudo tee" - запускается как отдельный процесс с рутовыми привелегиями, поэтому может быть выполнена  
"sudo echo hello > /root/new_file" - в этой команде повышенные привелегии только у "процесса" echo, процесс перенаправления в файл с пользовательскими, поэтому не может быть выполнена 

