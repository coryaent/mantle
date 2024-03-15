#!/bin/bash
# calculate a priority within server ID limits
genID() {
  echo "md5sum,md5" | tr ',' '\n' | while read -r cmd; do
    if [[ -x "$(command -v "${cmd}")" ]]; then
      num=$(( 0x$(echo "$(hostname)" | command "${cmd}" | cut -d ' ' -f 1 | head -c 15) ))
      [[ $num -lt 0 ]] && num=$((num * -1))
      echo $(($num % 1000000000))
      return 0
    fi
  done
  return 1
}
#printf "[mysqld]\nserver-id=$(genID)\n" > /etc/mysql/conf.d/id.cnf
mysql --host=localhost --user=root --password=$(cat MYSQL_ROOT_PASSWORD_FILE) --execute
