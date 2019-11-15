curDir=$(cd $(dirname ${BASH_SOURCE:-$0}) > /dev/null && pwd)
gitRoot=$(cd $(dirname $(dirname $curDir)) > /dev/null && pwd)

# alias r='ruby' # ビルトインと競合する

# 初期起動時のブランチをキャッシュしてしまうのでaliasで設定したコマンド実行時に毎回取得するようにした
# currentBranch=$(git branch | grep '\*'  | awk '{print $2}')

# git alias
alias gdh='git diff HEAD^..HEAD'
alias gs='git status'
alias gc='git checkout'
alias gd='git diff'
alias gpush="${gitRoot}/git_scripts/gitPushOriginCurBranch.sh"
alias gpull="${gitRoot}/git_scripts/gitPullOriginCurBranch.sh"
#alias gpull="git pull origin"
alias gl1='git log --oneline --graph --decorate'

# ruby/rails alias
alias rs='bundle exec rails'

# TODO aliasでのgpull廃止。aliasにcurBranchのキャッシュ残るから。スクリプトでgpullできるようにして、gpullエイリアスでそのスクリプトを指定する

# top
alias topc='top -o cpu'
alias topm='top -o mem'









