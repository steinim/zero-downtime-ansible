#!/bin/sh

APP_HOME=/home/devops
APP_JAR=current
LOGS=$APP_HOME/logs

USR=$( whoami )

PID=$( ps -ea -o "pid ppid args" | grep -v grep | grep "java -jar $APP_JAR" | sed -e 's/^  *//' -e 's/ .*//' | head -1 )

_start() {
  if [ -z $PID ]; then
    echo "Starting devops..."
    cd $APP_HOME
    if [ "devops" = "$USR" ]; then
      mkdir -p $LOGS ; nohup java -jar $APP_JAR 1>$LOGS/stdout.log 2>$LOGS/stderr.log &
    else
      sudo su -l devops -c "mkdir -p $LOGS ; nohup java -jar $APP_JAR 1>$LOGS/stdout.log 2>$LOGS/stderr.log &"
    fi
    cd -
    echo "Started devops."
  else
    echo "devops already running with PID: ${PID}"
  fi
}

_stop() {
  echo "Stopping devops..."
  if [ -z $PID ]; then
    echo "devops already stopped"
  else
    if [ "devops" = "$USR" ]; then
      kill $PID
    else
      sudo kill $PID
    fi
    unset PID
  fi
}

_status() {
  test $PID && echo "devops is running with PID: ${PID}" || echo "devops is not running"
}

case "$1" in
  start)
    _start
    ;;
  stop)
    _stop
    ;;
  restart)
    _stop
    wait 3
    _start
    ;;
  status)
    _status
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    ;;
esac
