#! /bin/bash

git branch | grep '\*'  | awk '{print $2}'
