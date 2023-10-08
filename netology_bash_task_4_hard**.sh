#!/bin/bash
#У скрипта есть две переменные — IP-адрес и порт, которые задаются в самом скрипте и не меняются при последующих запусках.
#С помощью утилиты netcat (nc) необходимо проверить доступность порта. Утилиту nc можно вызвать строго один раз в скрипте.
#Если порт недоступен, сделать запись в логе, имя которого задано в переменной LOG_FILE (используя стандартное перенаправление в файл)

IP=127.0.0.1 #не изменять
PORT=80 #не изменять
LOG_FILE=/var/log/syslog #не изменять
STATUS_FILE=status #не изменять

nc -z "$IP" "$PORT"

CUR_STATUS=$?

case "$CUR_STATUS" in
    0)
        if [[ ( -f $STATUS_FILE ) && $( cat $STATUS_FILE ) = 1 ]]; then
            echo "$(date "+%b %d %T") port_check: IP $IP Port $PORT is available again" >> $LOG_FILE
            echo "$CUR_STATUS" > $STATUS_FILE
        else
            exit 0
        fi
    ;;
    1)
        echo "$(date "+%b %d %T") port_check: IP $IP Port $PORT is not available" >> $LOG_FILE
        echo "$CUR_STATUS" > $STATUS_FILE
    ;;
esac