function app_setup {
  FLAG=${1:-/tmp/setup.done}
  FORCE_SETUP="${FORCE_SETUP:-0}"
  FORCE_RELOAD="${FORCE_RELOAD:-0}"

  if [ ! -f "${FLAG}" ] || [ "${FORCE_SETUP}" == '1' ]; then
    setup_cm "{$FORCE_RELOAD}"
    touch "${FLAG}"
    echo "Setup completed, flag added in ${FLAG}"
  else
    echo 'Setup already done'
    echo ' - force setup with FORCE_SETUP=1'
    echo ' - force "cm app setup -reload" with FORCE_RELOAD=1'
  fi
}

function setup_cm {
    mkdir -p /var/log/app
    foreman export -u root supervisord /etc/supervisor/conf.d
    composer --no-interaction install
    ./bin/cm app set-config deploy "$(date '+%s')"
    if [ "${1}" == '1' ]; then
      ./bin/cm app setup --reload
    else
      ./bin/cm app setup
      ./bin/cm migration run
    fi
}

function app_wait_services {
  TIMEOUT=${2:-300}
  echo "Waiting for ${1} services..."
  count=0
  until ( test_services "$1" )
  do
    let "count=+1"
    if [ ${count} -gt $TIMEOUT ]
    then
      echo "Services didn't become ready in time"
      return 100
    fi
    sleep 1
    printf "\n"
  done
  printf "\n"
  echo "All services are ready!"
  return 0
}

function test_services {
  IFS=","
  read -a services <<< "$1"
  for service in "${services[@]}"
  do
      "test_${service}"
      if [ "$?" -ne 0 ]
      then
        echo "- ${service}:waiting";
        return 1
      else
        echo "- ${service}:ok";
      fi
  done
  return 0
}

function test_mysql {
  mysqladmin -h "mysql" ping &>/dev/null
}

function test_redis {
  redis-cli -h "redis" PING &>/dev/null
}

function test_memcached {
  echo "flush_all" | nc -w1 "memcached" "11211" &>/dev/null
}

function test_mongo {
  curl "http://mongo:27017" &>/dev/null
}

function test_gearman {
  echo "status" | nc -w1 "gearman" "4730" &>/dev/null
}

function test_elasticsearch {
  curl "http://elasticsearch:9200" &>/dev/null
}

