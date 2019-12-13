#!/bin/bash
set -e

SQL=""

for i in `env`
do
	if [[ $i == POSTGRES_INITDB.* ]];
	then
		item=`echo $i | awk -F '.' '{print $2}'`
		user=`echo $item | awk -F '=' '{print $1}'`
		password=`echo $item | awk -F '=' '{print $2}'`
		nextline=`echo -e "\n\r"`
		USER_SQL=$(cat<<EOF
CREATE USER ${user} WITH PASSWORD '${password}';
CREATE DATABASE ${user};
GRANT ALL PRIVILEGES ON DATABASE ${user} TO ${user};
${nextline}
EOF
)
		SQL="${SQL}${USER_SQL}"
	fi
done

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    ${SQL}
EOSQL