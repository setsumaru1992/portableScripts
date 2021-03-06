#! /bin/bash

#（オプション）このファイルを作業ディレクトリとする
##（オプション）オプション引数を使う場合は以下を使用
#haveOpt=0
#while getopts f:dc: OPT
#do
#  case $OPT in
#    f) filename="$OPTARG"
#      haveOpt=1
#      ;;
#    d) isDebug=1
#      haveOpt=1
#      ;;
#    c) count='$OPTARG'
#      haveOpt=1
#      ;;
#  esac
#done
#
#if [ ${haveOpt} = 1 ]
## オプションがある場合、オプション分だけ引数をずらす（これがないと-fなどが$1に入る）
#then
#  shift $(($OPTIND - 1))
#fii

# https://rcmdnk.com/blog/2015/07/24/computer-bash-zsh/
# https://qiita.com/yudoufu/items/48cb6fb71e5b498b2532
cur_dir=$(cd $(dirname ${BASH_SOURCE:-$0}) > /dev/null && pwd)
source ${cur_dir}/alias.sh


