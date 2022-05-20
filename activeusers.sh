#/bin/sh

USERS=$(ps --no-headers -eo user | sort | uniq)

if [ "$1" = '-a' ] || [ "$1" = '--all' ]; then
    MIN_ID=0
elif [ -n "$1" ]; then
    echo "$0: unrecognised argument: $1." > /dev/stderr
    exit 1
else
    MIN_ID=$(awk '/^UID_MIN/ { print $2 }' /etc/login.defs)
fi

for user in $USERS; do
    id=$(id -u $user)

    if [ $id -ge $MIN_ID ]; then
        echo $user
    fi
done
