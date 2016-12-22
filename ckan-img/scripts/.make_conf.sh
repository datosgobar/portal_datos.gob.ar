#!/bin/sh

# URL for the primary database, in the format expected by sqlalchemy (required
# unless linked to a container called 'db')


CONFIG="${CKAN_CONFIG}/${CKAN_CONFIG_FILE}"

abort () {
  echo "$@" >&2
  exit 1
}

write_config () {
  CKAN_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')

  "$CKAN_HOME"/bin/paster --plugin=ckan config-tool "$CONFIG" -e \
      "ckan.storage_path = ${CKAN_DATA}" \
      "ckan.plugins = stats text_view image_view recline_view hierarchy_display hierarchy_form gobar_theme datastore datapusher"  \
      "ckan.auth.create_user_via_api = false" \
      "ckan.auth.create_user_via_web = false" \
      "ckan.locale_default = es" \
      "email_to = disabled@example.com" \
      "ckan.datapusher.url = http://${CKAN_IP}:8800" \
      "ckan.max_resource_size = 300" \
      "error_email_from = ckan@$(hostname -f)" \
      "ckan.site_url = http://${CKAN_IP}"

  if [ -n "$ERROR_EMAIL" ]; then
    sed -i -e "s&^#email_to.*&email_to = ${ERROR_EMAIL}&" "$CONFIG"
  fi
}

write_config
exit $?