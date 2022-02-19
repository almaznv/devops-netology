
 ### Домашнее задание к занятию «2.4. Инструменты Git»

1. git show aefea
	>aefead2207ef7e2aa5dc81a34aedf0cad4c32545  
   Update CHANGELOG.md
2. git show 85024d3
   >tag: v0.12.23
3. git show --oneline b8d720^  
git show b8d720^2
	>2 родителя:   
	56cd7859e05c36c06b56d013b55a252d0bb7e158     
	9ea88f22fc6269854151c571162c5bcf958bee2b  
4.  git log --oneline v0.12.23..v0.12.24
	>33ff1c03b (HEAD, tag: v0.12.24) v0.12.24  
b14b74c49 [Website] vmc provider links  
3f235065b Update CHANGELOG.md  
6ae64e247 registry: Fix panic when server is unreachable  
5c619ca1b website: Remove links to the getting started guide's old location  
06275647e Update CHANGELOG.md  
d5f9411f5 command: Fix bug when using terraform login on Windows  
4b6d06cc5 Update CHANGELOG.md  
dd01a3507 Update CHANGELOG.md  
225466bc3 Cleanup after v0.12.23 release  

5. * Ищем файл с функцией providerSource:  
   git grep -p 'func providerSource'
	* Ищем историю изменения функции в файле:  
 git log -L :providerSource:provider_source.go
  
	> 8c928e835 (создан)  
5af1e6234 (отредактирован)

6. git log -L '/func globalPluginDirs/',/^}/:plugins.go   
	>78b122055 Remove config.go and update things using its aliases  
52dbf9483 keep .terraform.d/plugins for discovery  
41ab0aef7 Add missing OS_ARCH dir to global plugin paths  
66ebff90c move some more plugin search path logic to command  
8364383c3 Push plugin discovery down into command package (создании функции)  

7. * ищем упоминания функции  ( видим что автор первого коммита Martin Atkins <mart@degeneration.co.uk>)
   git log -S 'func synchronizedWriters'  
	* затем переход к коммиту с первым упоминание этой функции   
   git checkout 5ac311e2a91e381e2f52234668b49ba670aa0fe5
	* находим название файла  
	git grep -p 'func synchronizedWriters'  
	* убеждаемся что именно этот автор создал функцию  
	git log -L :synchronizedWriters:synchronized_writers.go
	  
	>Martin Atkins <mart@degeneration.co.uk>
	
 ### Домашнее задание к занятию "3.1. Работа в терминале, лекция 1
1.
2.
3.
4.
5. 2 core, 1Gb RAM, 64 Gb HDD
6. В Vagrantfile добавить 
 >config.vm.provider "virtualbox" do |v|  
  	  v.memory = 1024  
  	v.cpus = 2  
end
7.
8. >HISTSIZE  (862 строка документации   
   ignoreboth is shorthand for ignorespace and ignoredups. Если пробел перед командой, или команда повторяется (запуск одной команды несколько раз) то не сохраняется в истории.
   
9. >1035 строка: Обращение к элементам массива  
1091 строка: Brace expansion  
1159 строка: Parameter expansion  
2173 строка: Формат даты времени  

10. Создать 100к файлов: touch {1..100000}  
	300000 не удалось, ошибка "Argument list too long"  (список аргументов слишком большой) 
	
	после запуска команда преобразуется из "touch {1..300000}" в "touch 1 2 3 .. и т.д. до 300000"  
	У запускаемого процесса есть ограничение на количество аргументов, а скорее на размер аргументов в байтах   
	Максимальный размер можно получить "getconf ARG_MAX" или еще "xargs --show-limits" или "ulimit -s/4". На моей системе это 2Мб.
	Лимит можно увеличить или сделать без лимита командой "ulimit -s unlimited"
	

11. [[ -d /tmp ]] Проверяет что tmp это директория.  
	[[ ]] в случае успеха возвращает 0, а не 1. Логика кажется немного необычной, но всё встаёт на свои места, если вспомнить, что [[ - это команда, а успешные команды завершаются с кодом возврата 0, а завершишиеся неуспешно - с кодом > 0  

12. Порядок действий:
* создаем директорию: mkdir /tmp/new_path_directory
* копируем bash: cp /bin/bash /tmp/new_path_directory/bash
* Добавляем в PATH: export PATH=/tmp/new_path_directory:/usr.....и т.д.
* при вводе type -a bash , "bash is /tmp/new_path/directory" первая в списке.

13. at для однократного запуска задачи 
	batch тоже для однократного запуска но с условием (when the load average drops below 0.8)