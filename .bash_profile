ulimit -n 1024
alias la='ls -alhG'
alias ll='ll -alrth'
alias c='clear'
alias mysql='/Applications/MAMP/Library/bin/mysql'
alias mysqladmin='/Applications/MAMP/Library/bin/mysqladmin'
alias mysqld_safe='/Applications/MAMP/Library/bin/mysqld_safe'
alias mysqld_safe='/Applications/MAMP/Library/bin/mysqld'
# Set my editor and git editor
export EDITOR="vim"
# export GIT_EDITOR="vim"
# export GIT_EXTERNAL_DIFF="vimdiff"
export SVN_EDITOR="vim"
# alias git_diff_wrapper='$HOME/dotfiles/bin/git_diff_wrapper'
# export PATH=$PATH:$HOME/dotfiles/bin/git_diff_wrapper
# git diff --no-ext-diff -w "$@" | vim -R -

#
# Git aliases from the oh-my-zsh plugin, which are not included in the bash-it framework
#
alias g='git'
alias get='git'
alias gitmerge='git mergetool -t vimdiff'
alias gcl='git clone'
alias ga='git add'
alias gall='git add .'
alias gst='git status'
alias gs='git status'
alias gss='git status -s'
alias gsb='git status -sb'
alias gl='git pull'
alias gpr='git pull --rebase'
alias gpp='git pull && git push'
alias gup='git fetch && git rebase'
alias gp='git push'
alias gpo='git push origin'
alias gd='git diff'
alias gdv='git diff -w "$@" | vim -R -'
alias gdd='git diff -w --word-diff=color'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gci='git commit --interactive'
alias gc!='git commit -v --amend'
alias gca!='git commit -v -a --amend'
alias gb='git branch'
alias gba='git branch -a'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gco='git checkout'
alias gexport='git archive --format zip --output'
alias gdel='git branch -D'
alias gmu='git fetch origin -v; git fetch upstream -v; git merge upstream/master'
alias glg='git lg'
alias glga='git lg --all'
alias glo='git log --oneline'
alias gll='git log --graph --pretty=oneline --abbrev-commit'
alias gg="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias glp="_git_log_prettily"
alias ggs="gg --stat"
alias gsl="git shortlog -sn"
alias gw="git whatchanged"
alias gc='git commit -v'
alias gco='git checkout'
alias gcm='git checkout master'
alias gr='git remote'
alias grv='git remote -v'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grup='git remote update'
alias gcl='git config --list'
alias gm='git merge'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gwc='git whatchanged -p --abbrev-commit --pretty=medium'
alias gf='git ls-files | grep'
alias gpoat='git push origin --all && git push origin --tags'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
alias gsr='git svn rebase'
alias gsd='git svn dcommit'
alias ggpull='git pull origin $(current_branch)'
alias ggpush='git push origin $(current_branch)'
alias ggpnp='git pull origin $(current_branch) && git push origin $(current_branch)'
alias ..='cd ..'
alias ...='cd ../../'
# setopt glob_dots
# unsetopt glob_dots
# find -type f -name '*js' -print0 | xargs -0 grep -l -i 'asdf' # will list all js files containing the string asdf under the current directory
# find . -type f -exec sed -i.bak "s/foo/bar/g" {} \;   # replace fro all files in the folder
# find . -type f -exec sed -i.bak "s/foo/bar/g' {} + # recursive find/replace
# sed 's/foo/bar/g' filename         # standard replace command
# sed '/foo/ s/foo/bar/g' filename   # executes more quickly
# sed '/foo/ s//bar/g' filename      # shorthand sed syntax
