#!/bin/bash -
#===============================================================================
#
#          FILE: entrypoint.sh
#
#         USAGE: ./entrypoint.sh
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Evan Mattiza (emattiza@gmail.com),
#  ORGANIZATION:
#       CREATED: 08/22/2019 07:50:00 PM
#      REVISION:  ---
#===============================================================================

set -o nounset                                  # Treat unset variables as an error

pipenv run gunicorn --bind 0.0.0.0:8000 src.app:app
