#/bin/sh

USERS=$(ps -ef | tail -n +2 | awk '{print $1}' | sort | uniq)

if [ "$1" = '-a' ] || [ "$1" = '--all' ]; then
    MIN_ID=0
elif [ -n "$1" ]; then
    echo "$0: unrecognised argument: $1." > /dev/stderr
    exit 1
else
    MIN_ID=$(awk '/^UID_MIN/ { print $2 }' /etc/login.defs)
fi

for user in $USERS; do
    id=$(id -u $user 2> /dev/null)

    if [ $? -eq 0 ]; then
        if [ $id -ge $MIN_ID ]; then
           echo $user
        fi
    fi
done
