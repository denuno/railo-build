du -hs -I .svn -I artifacts -I ext -I .git ${1:-*}  | /opt/local//libexec/gnubin/sort -h
