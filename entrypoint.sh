#!/bin/bash
set -e

if [ -v LOCAL_USER_ID ]; then
  if id -u ${LOCAL_USER_ID} >/dev/null 2>&1; then
    BASE_USER=cv
  else
    # Create a new user with the specified UID and GI
    useradd --home /home/cv --uid $LOCAL_USER_ID --shell /bin/bash dynamic && usermod -aG sudo dynamic && echo "dynamic ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    BASE_USER=dynamic
  fi
else
  BASE_USER=cv
fi

echo "Starting with UID : $LOCAL_USER_ID, base user: $BASE_USER"


if [ "$#" -ne 0 ]; then
  su -s /bin/bash $BASE_USER -c "$@"
else
  su -s /bin/bash $BASE_USER -c "script -q /dev/null -c 'bash -i'"
fi
