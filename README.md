# CSstatsX SQL
Запись статистики csstats в БД MySQL и SQLite.

## Требования
* AMXX >= 1.8.2
* MySQL >= 5.6 / MariaDB >= 10
* Разрешение на использование триггеров для работы статистики по картам.


## Установка
* Скомпилируйте плагин.
	* Для поддержки utf8 ников требуется AMXX 1.8.3, компилить так-же нужно будет с компилятором от 1.8.3 версии.
* Раскомментируйте нужный модуль SQL в файле **addons/amxmodx/configs/modules.ini**.
* Укажите данные для подключения в кварах **csstats_sql_host**, **csstats_sql_user**, **csstats_sql_pass**, **csstats_sql_db**, **csstats_sql_type**.
* Чтобы плагины статистики начали использовать данные с SQL выполните инструкции ниже.
* Для обновления с версии **0.4** на версию **0.5** выполните импорт **csstats_04_to_05.sql**.
* Для обновления с версии **0.5** dev на версию **0.5** выполните импорт **csstats_05dev_to_05.sql**.
* Для обновления с версии **0.6** на версию **0.7** выполните импорт **csstats_06_to_07.sql**.
* Для обновления с версии **0.7** на версию **0.7.2** выполните импорт **csstats_07_to_072.sql**.
	* Выполните импорт **csstats_07_to_072_maps.sql**, если включена запись статистики за карту.
	* Перекомпилите все плагины с новым **csstatsx_sql.inc**.
* Для записи статистики за карту необходимо выполнить импорт файла **csstats_maps.sql** в БД.
	* **csstats_maps_sqlite.sql** для sqlite.
* Для обновления с **CsStats MySQL** выполните импорт **csstats_mysql_convert.sql** (обратите внимание на название таблицы в sql файле).
	* ВНИМАНИЕ! Опыт, количество подключений и побед конвертированы не будут!

## Вариант с заменой модуля CSX

* Выключите сервер.
* Файл **dummy_csx_amxx** из архива переименуйте в **csx_amxx**.
* Замените этим файлом ваш модуль в папке **addons/amxmodx/modules**.
* Задайте квар **csstats_sql_forwards** в **1**.
* Пропишите **csstatsx_sql.amxx** **ВЫШЕ** всех остальных ваших плагинов статистики.

## Вариант без замены модуля CSX
Выполните следующие инструкции для **ВСЕХ** ваших плагинов статистики.
* Откройте исходник плагина.
* Добавьте следующий код в начало файла:
```
native get_statsnum_sql()
native get_user_stats_sql(index, stats[8], bodyhits[8])
native get_stats_sql(index, stats[8], bodyhits[8], name[], len, authid[] = "", authidlen = 0)
```
* Замените все строчки **get_statsnum** на **get_statsnum_sql**.
* Замените все строчки **get_user_stats** на **get_user_stats_sql**.
* Замените все строчки **get_stats** на **get_stats_sql**.
* Скомпилируйте плагин.

## Квары
* **csstats_sql_host** "localhost" - хост БД MySQL
* **csstats_sql_user** "root" - пользователь БД MySQL
* **csstats_sql_pass** "" - пароль БД MySQL
* **csstats_sql_db** "amxx" - название БД.
* **csstats_sql_table** "csstats" - название таблицы.
* **csstats_sql_type** "mysql" - тип используемой базы данных.
	* mysql		- база данных MySQL.
	* sqlite		- локальная база данных SQLite.
* **csstats_sql_create_db** "1" - автоматическое создание таблицы в БД.
	* 0					- не отправлять запрос.
	* 1					- отправлять запрос при загрузке карты.
* **csstats_sql_update** "-2" - как обновлять статистику игрока в БД
	* -2 					- при смерти и дисконнекте
	* -1					- в конце раунда и дисконнекте
	* 0 					- при дисконнекте
	* значение больше 0 	- через указанное кол-во секунд и дисконнекте
* **csstats_sql_forwards** "0" - включить собственные форварды для client_death, client_damage
	* 0			- выключить
	* 1			- включить, небоходимо, если csstats_sql используется в качестве замены модуля
	
* **csstats_sql_rankformula** "0" - формула расчета позиции игрока
	* 0			- убийства - смерти - тк
	* 1			- убийства
	* 2			- убийства + хедшоты
	* 3			- скилл
	* 4			- время онлайн
* **csstats_sql_skillformula** "0" - формула расчета скилла
	* 0			- The ELO Method (http://fastcup.net/rating.html)
* **csstats_sql_weapons** "0" - запись статистики по оружию
	* 0			- опция выключена
	* 1			- опция включена
* **csstats_sql_maps** "0" - запись статистики за карту
	* 0			- опция выключена
	* 1			- опция включена
* **csstats_sql_autoclear** "0" - автоматическое удаление игроков из БД, которые не заходили последние n-дней на сервер
* **csstats_sql_autoclear_day** "0" - автоматический сброс статистики каждый n-день месяца
* **csstats_sql_cachetime** "-1" - функция кеширование для get_stats
	* -1			- кеш включен
	* 0			- кеш выключен
	* *не работает при csstats_sql_update -2 и 0*
* **csstats_sql_assisthp** "50" - минимальный урон для учета ассиста. 0 - выключить учет ассистов.

## Команды
* **csstats_sql_reset** - полный сброс статистики. Выполняется в консоли сервера или через RCON.

## Информация
* Из-за особенности хранения данных в БД, плагин вернет наименьший ранг в случае если статистика 2х и более игроков совпадает.
