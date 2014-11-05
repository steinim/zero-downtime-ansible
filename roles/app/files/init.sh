#!/bin/bash
# devops daemon
# chkconfig: 345 20 80
# description: devops daemon
# processname: devops

NAME=devops
APP_HOME=/home/$NAME
APP_JAR=current
LOGS=$APP_HOME/logs
STDOUT=$APP_HOME/logs/stdout.log
STDERR=$APP_HOME/logs/stderr.log
PIDFILE=$APP_HOME/$NAME.pid

_start() {
  printf "%-50s" "Starting $NAME..."
  cd $APP_HOME
  if [ ! -d "$LOGS" ]; then
    mkdir $LOGS
  fi
  PID=`nohup java -jar $APP_JAR 1>$STDOUT 2>$STDERR & echo $!`
  if [ -z $PID ]; then
    printf "%s\n" "Fail"
  else
    echo $PID > $PIDFILE
    printf "%s\n" "Ok"
  fi
}

_stop() {
  printf "%-50s" "Stopping $NAME"
  PID=`cat $PIDFILE`
  cd $APP_HOME
  if [ -f $PIDFILE ]; then
    kill -9 $PID
    printf "%s\n" "Ok"
    rm -f $PIDFILE
  else
    printf "%s\n" "pidfile not found"
  fi
}

_status() {
  printf "%-50s" "Checking $NAME..."
  if [ -f $PIDFILE ]; then
    PID=`cat $PIDFILE`
    if [ -z "`ps axf | grep ${PID} | grep -v grep`" ]; then
      printf "%s\n" "Process dead but pidfile exists"
    else
      echo "Running"
    fi
  else
    printf "%s\n" "Service not running"
  fi
}

case "$1" in
  start)
    _start
    ;;
  stop)
    _stop
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    _status
    ;;
  *)
    echo "Usage: $0 {status|start|stop|restart}"
    ;;
esac
