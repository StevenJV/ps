git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short),%(authorname),%(committerdate:relative)' | 
%{$_ -replace 'refs/heads/', ''} |
convertfrom-csv -header "Branch","Author","Last Commit"
