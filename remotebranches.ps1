git for-each-ref --sort=-committerdate refs/remotes/ --format='%(refname:short),%(authorname),%(committerdate:relative)' | 
%{$_ -replace 'refs/remotes/', ''} |
select-string -notmatch "BACKUP" |
convertfrom-csv -header "Branch","Author","Last Commit"
