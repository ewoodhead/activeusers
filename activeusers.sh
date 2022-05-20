#/bin/sh

users=$(ps --no-headers -eo user | sort | uniq)

if [ "$1" = '-a' ] || [ "$1" = '--all' ]; then
    min_id=0
elif [ -n "$1" ]; then
    echo "$0: unrecognised argument: $1." > /dev/stderr
    exit 1
else
    min_id=$(awk '/^UID_MIN/ { print $2 }' /etc/login.defs)
fi

for user in $users; do
    id=$(id -u $user)

    if [ $id -ge $min_id ]; then
        echo $user
    fi
done
