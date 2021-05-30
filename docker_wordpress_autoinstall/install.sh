#!/bin/bash
#
# Use docker run and wordpress:cli-2.4 and execute the WordPress CLI's
# core install command to automate WordPress installation at an
# existing site.
#
# To see command-line flags available for core install visit:
# https://developer.wordpress.org/cli/commands/core/install/#options
#
docker run --rm --volumes-from 00faf78a4ef8 --network container:00faf78a4ef8 wordpress:cli-2.4 wp core install \
  --url="http://localhost:10080" \
  --title="cim" \
  --admin_user="admin" \
  --admin_password="admin" \
  --admin_email="erdodip@gmail.com" \
  --skip-email