## Домашнее задание к занятию "4.1. Командная оболочка Bash: Практические навыки"
#### link to homework: https://github.com/netology-code/sysadm-homeworks/tree/master/04-script-01-bash

1. Ответ:
* c=a+b - т.к. присвоение строки
* d=1+2 - т.к. присвоение строки
* e=3   - т.к. это особенности bash, арифметические операции в двойных круглых скобках. e=$((a+b)) даст такой же результат

2. Нужно дописать условие остановки цикла в случае получения правильного ответа от сервиса (ну и в первой строке была опечатка, осуствие закрывающей скобки)
```bash
while ((1==1))
do
        curl https://localhost:4757

        if (($? != 0))
        then
                date >> curl.log
        else
                echo break
                break
        fi
done
```

3. 
```bash
try_count=5
hosts=("192.168.0.1" "173.194.222.113" "87.250.250.242")

echo "start requests" > log.log

for host in ${hosts[@]}
do

i=0

   while (( i < try_count ))
   do
        curl --connect-timeout 1 http://${host}

        if (($? != 0))
        then
                echo [$(date)] ${host} not available >> log.log
        else
                echo [$(date)] ${host} available >> log.log
        fi

        i=$((i+1))
   done

done
```

4. 
```bash
try_count=5
hosts=("173.194.222.113" "192.168.0.1" "87.250.250.242")

echo "start requests" > log.log

for host in ${hosts[@]}
do

i=0
stop=0

   while (( i < try_count ))
   do
        curl --connect-timeout 1 http://${host}

        if (($? != 0))
        then
                echo [$(date)] ${host} not available >> error.log
                stop=1
                break

        else
                echo [$(date)] ${host} available >> log.log
        fi

        i=$((i+1))
   done

   if (( stop == 1 ))
   then
        break
   fi

done
```