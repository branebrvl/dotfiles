source ~/.profile
# ps aux
# setopt glob_dots
# unsetopt glob_dots
# find -type f -name '*js' -print0 | xargs -0 grep -l -i 'asdf' # will list all js files containing the string asdf under the current directory
# find . -type f -exec sed -i.bak "s/foo/bar/g" {} \;   # replace fro all files in the folder
# find . -type f -exec sed -i.bak "s/foo/bar/g' {} + # recursive find/replace
# sed 's/foo/bar/g' filename         # standard replace command
# sed '/foo/ s/foo/bar/g' filename   # executes more quickly
# sed '/foo/ s//bar/g' filename      # shorthand sed syntax
# svn st | grep '^!' | awk '{print $2}' | xargs svn delete --force
# svn status | grep -v "^.[ \t]*\..*" | grep "^?" | awk '{print $2}' | xargs svn add
# svn remove --force filename
# svn log -v | less

# find out on which port is running an app
# lsof -n | grep TCP | grep LISTEN
# lsof -t -i:4444

# view a prev revison
# svn cat -r 1234 file | less


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# added by Anaconda3 2019.03 installer
# >>> conda init >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$(CONDA_REPORT_ERRORS=false '/Users/bvladisavljev/anaconda3/bin/conda' shell.bash hook 2> /dev/null)"
if [ $? -eq 0 ]; then
    \eval "$__conda_setup"
else
    if [ -f "/Users/bvladisavljev/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/bvladisavljev/anaconda3/etc/profile.d/conda.sh"
        CONDA_CHANGEPS1=false conda activate base
    else
        \export PATH="/Users/bvladisavljev/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda init <<<
