#!/usr/bin/env bash

mkdir -p $HOME/screenshots
import -quality 95 $HOME/screenshots/$(date +"%Y%m%d-%H%M%S").jpg
