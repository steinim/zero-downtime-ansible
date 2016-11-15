#!/bin/bash
### BEGIN INIT INFO
# Provides:          devops
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start devops app at boot time
# Description:       Enable service provided by devops daemon.
### END INIT INFO

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
    su $NAME -c "mkdir $LOGS"
  fi
  touch $PIDFILE
  chown $NAME:$NAME $PIDFILE
  su $NAME -c "nohup java -jar $APP_JAR 1>$STDOUT 2>$STDERR & echo \$! > '$PIDFILE'"
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
