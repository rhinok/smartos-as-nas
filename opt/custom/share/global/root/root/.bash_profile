[ -f /root/.profile ] && source /root/.profile
[ -f /root/.bashrc ] && source /root/.bashrc

TZ=Europe/Bucharest
export TZ

PATH=$PATH:$HOME/bin
export PATH
