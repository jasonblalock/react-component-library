#!/bin/sh
# entrypoint.sh

set -e

cmd="$@"

# Install dependencies
if nc -zw1 google.com 443 > /dev/null 2>&1; then
  if [ -e Gemfile ]; then
    bundle check || bundle
  fi

  if [ -e package.json ]; then
    yarn install --check-files
  fi
else
  echo "Installing dependencies offline"
  if [ -e Gemfile ]; then
    bundle check || bundle install --local
  fi

  if [ -e package.json ]; then
    yarn install --offline --check-files
  fi
fi

# Wait for database
if [ "$WAIT_FOR_DB" = "true" ]; then
  until psql -h "db" -U "postgres" -c '\q' &> /dev/null; do
    >&2 echo "Postgres is unavailable - sleeping"
    sleep 1
  done

  >&2 echo "Postgres is up - executing command"
fi

exec $cmd