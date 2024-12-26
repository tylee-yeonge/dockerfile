set -e
IMAGE=$1
CONTAINER=$2
docker create \
  --name "${CONTAINER}" \
  --net="host" \
  --privileged \
  -v /Users/yeonge/workspace/share:/root/share:rw \
  "${IMAGE}"
