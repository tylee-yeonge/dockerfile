set -e
IMAGE=$1
CONTAINER=$2
docker create \
  --name "${CONTAINER}" \
  -p 6080:80 \
  -p 5901:5901 \
  --security-opt seccomp=unconfined \
  --privileged \
  -v /Users/yeonge/workspace/share/humble-ws:/home/tylee/share:rw \
  "${IMAGE}"