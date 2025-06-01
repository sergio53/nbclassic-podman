alias m.='mcedit'
alias rc='m. ~/.bash_aliases  && . ~/.bash_aliases'
alias rc.='. ~/.bash_aliases'
alias rc..='m. -v ~/.bash_aliases'
alias b.='m. ~/.bashrc && . ~/.bashrc'

alias a..='alias'
alias a.='a.. | grep'
alias c.='clear'
alias e.='exit'
alias g.='git clone'
alias h.='htop'
alias w.='wget'
alias n..='sudo netstat -ntlp4'
alias n.='n.. | grep'

# functions:
# --------
rc... (){
  if [ $# -eq 0 ]; then
    cat ~/.bash_aliases
  else
    cat ~/.bash_aliases | grep $1
  fi
}

forest () {
  if [ $# -eq 0 ]; then
    ps -ef --forest
  else
    ps -ef --forest | grep $1 | grep -v grep
  fi
}

alias pod.='podman'
#alias pod.login='pod. login --username ****** --password ******** docker.io'

# functions:
# ---------
pod.exec () { 
  pod. exec -ti $1 ${@:2}
}
pod.bash () {
  pod.exec -ti $1 bash
}
pod.mc () {
  pod.exec -ti $1 mc 
}
pod.rm () {
  pod. kill $1 ; pod. rm $1 ; pod. ps -a
}
pod.rmi () {
  pod. rmi $1 ; pod. images
}
pod.commit () {
  pod. commit $1 $2 ; pod. images
}

jupyter.token () {
  pod.exec $1 jupyter server list
}


###########n nbclassic ############# nbclassic ########### nbclassi c############ nbclassic ##################

# aliases:
# -------
alias nbclassic.run='uid=1000;gid=100; dir=nbclassic; \
    subuidSize=$(( $(podman info --format "{{ range .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 )); \
    subgidSize=$(( $(podman info --format "{{ range .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 )); \
    mkdir -p ~/podmans_DIR/$dir \
    && podman run --name $dir -itd --network host \
    -e JUPYTER_PORT=8888 -e VOILA_PORT=8866 \
    -v ~/podmans_DIR/$dir:/home/jovyan --user $uid:$gid \
    --uidmap $uid:0:1 --uidmap 0:1:$uid --uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
    --gidmap $gid:0:1 --gidmap 0:1:$gid --gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
    localhost/nbclassic'

alias nbclassic.exec='pod.exec nbclassic'
alias nbclassic.bash='pod.exec nbclassic bash'
alias nbclassic.mc='pod.exec nbclassic mc'
alias nbclassic.rm='pod.rm nbclassic'
alias nbclassic.rmi='pod.rmi localhost/nbclassic:latest'
alias nbclassic.commit='pod.commit nbclassic localhost/nbclassic:latest'
alias nbclassic.token='jupyter.token nbclassic'
#.

# functions:
# ---------
nbclassic. () {
  if [ $# -lt 3 ]; then
    echo "nbclassic. CONTAINER_NAME  JUPYTER_PORT VOILA_PORT"
  else
    uid=1000; gid=100; \
    subuidSize=$(( $(podman info --format "{{ range .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 )); \
    subgidSize=$(( $(podman info --format "{{ range .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 )); \
    mkdir -p ~/podmans_DIR/NB_classic/$1 \
    && podman run --name $1 -itd -p $2:8888 -p $3:8866 \
    -v ~/podmans_DIR/NB_classic/$1:/home/jovyan --user $uid:$gid \
    --uidmap $uid:0:1 --uidmap 0:1:$uid --uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
    --gidmap $gid:0:1 --gidmap 0:1:$gid --gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
    localhost/nbclassic
  fi
  pod. ps -a --sort created
}

#.
