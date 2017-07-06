#!/usr/bin/env bash
current_dir="$(dirname "$0")"
config_file="/etc/ckan/default/production.ini";

sed -i -r '/ckan.plugins/ s/googleanalytics//' $config_file
