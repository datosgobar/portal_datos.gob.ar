#!/bin/sh

# URL for the primary database, in the format expected by sqlalchemy (required
# unless linked to a container called 'db')


CONFIG="${CKAN_CONFIG}/${CKAN_CONFIG_FILE}"

abort () {
  echo "$@" >&2
  exit 1
}

write_config () {
  "$CKAN_HOME"/bin/paster --plugin=ckan config-tool "$CONFIG" -e \
      "error_email_from = ckan@$(hostname -f)" 

  if [ -n "$ERROR_EMAIL" ]; then
    sed -i -e "s&^#email_to.*&email_to = ${ERROR_EMAIL}&" "$CONFIG"
  fi
}

write_config
exit $?
