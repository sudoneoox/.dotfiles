
#  * `ccat` Cat file, but with syntax highlighting
alias ccat='pygmentize -g'

#  * `git-show-unpushed-commits` Git show unpushed commits
alias git-show-unpushed-commits='git cherry -v' 

function git-revert-file --description "Revert single file in git"
  git reset HEAD $argv; git checkout $argv
end

function git-wat --description "Show 5 latest commits"
  git log --pretty="format:%Cgreen%<(17,trunc)%an%Creset%s" --abbrev-commit  HEAD~5..HEAD
end

function git-recent-branches --description "Show recentbranches"
  git branch --sort=-committerdate
end

function git-pr --description "Create PR on Github"
  set from   (git config --get remote.origin.url | string match --regex "\:(.*)/" | tail -1)
  set to     (git config --get remote.oss.url | string match --regex "\:(.*)\.git" | tail -1)
  set branch (git rev-parse --abbrev-ref HEAD)
  
  xdg-open "https://github.com/$to/compare/master...$from:$branch?expand=1"
end


function td --description "Add to ~/todo.md list"
  echo -e "\n- [ ] $argv" >> ~/todo.md
end


#  * `server-here` Start serving files in current directory and open browser
alias server-here='python3 -m http.server 8888 && xdg-open http://localhost:8888'

function bak --description "Copies (backups) file in same folder with .bak extension"
  cp -i "$argv" "$argv.bak"
end
