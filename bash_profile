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
# svn remove --force filename
# svn log -v | less

# find out on which port is running an app
# lsof -n | grep TCP | grep LISTEN
# lsof -t -i:4444
