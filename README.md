### Jupyter-NBCLASSIC and Voila Podman-image builder 
####  + nbextensions + nbextensions_configurator
________
```
git clone https://github.com/sergio53/nbclassic-podman.git
cd nbclassic-podman
bash nbclassic.build.sh
```

```
alias nbclassic.run='uid=1000;gid=100; dir=nbclassic
    subuidSize=$(( $(podman info --format "{{ range .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
    subgidSize=$(( $(podman info --format "{{ range .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))
    mkdir -p ~/podmans_DIR/$dir
    podman run --name $dir -itd --network host \
      -e JUPYTER_PORT=8888 -e VOILA_PORT=8866 \
      -v ~/podmans_DIR/$dir:/home/jovyan --user $uid:$gid \
      --uidmap $uid:0:1 --uidmap 0:1:$uid --uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
      --gidmap $gid:0:1 --gidmap 0:1:$gid --gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
      localhost/nbclassic
      podman ps -a --sort created'
```
```
nbclassic. () {
  if [ $# -lt 1 ]; then
    echo "nbclassic. CONTAINER_NAME"
  else
    uid=1000; gid=100
    subuidSize=$(( $(podman info --format "{{ range .Host.IDMappings.UIDMap }}+{{.Size }}{{end }}" ) - 1 ))
    subgidSize=$(( $(podman info --format "{{ range .Host.IDMappings.GIDMap }}+{{.Size }}{{end }}" ) - 1 ))
    mkdir -p ~/podmans_DIR/NB_classic/$1
    podman run --name $1 -itd --network=jupyter \
      -v ~/podmans_DIR/NB_classic/$1:/home/jovyan --user $uid:$gid \
      --uidmap $uid:0:1 --uidmap 0:1:$uid --uidmap $(($uid+1)):$(($uid+1)):$(($subuidSize-$uid)) \
      --gidmap $gid:0:1 --gidmap 0:1:$gid --gidmap $(($gid+1)):$(($gid+1)):$(($subgidSize-$gid)) \
      localhost/nbclassic
    pod. ps -a --sort created
    pod.exec $1 "jupyter server list"
  fi
}
```

```
alias npm.run='
    mkdir -p ~/podmans_DIR/npm/data
    mkdir -p ~/podmans_DIR/npm/letsencrypt
    podman run -d --name npm  --network jupyter \
      -p 7780:80 -p 7781:81 \
      -v ~/podmans_DIR/npm/data:/data -v ~/podmans_DIR/npm/letsencrypt:/etc/letsencrypt \
      docker.io/jc21/nginx-proxy-manager:latest
    podman ps -a --sort created'
```
```
alias python.run='
  mkdir -p ~/podmans_DIR/python
  podman run -d --name python --network jupyter \
    -v ~/podmans_DIR/python:/root \
    docker.io/library/python:3.11.6
  podman ps -a --sort created'
```
________
```
nbclasiic.run

podman network create jupyter
npm.run
python.run
nbclasiic. nb_ONE
nbclasiic. nb_TWO
nbclasiic. nb_THREE
```
