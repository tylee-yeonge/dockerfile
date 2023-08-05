set -e
IMAGE=$1
PATH=$2
docker buildx build --platform linux/amd64 --tag ${IMAGE} ${PATH}
