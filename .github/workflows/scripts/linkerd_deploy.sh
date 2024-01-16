#!/usr/bin/env bash

# This script is used to deploy Linkerd on Kubernetes
#
# Also deploys EmojiVoto on Linkerd and exposes the service to Meshplay

# See: https://github.com/service-mesh-performance/service-mesh-performance/blob/master/protos/service_mesh.proto
export MESH_NAME='Linkerd'
export SERVICE_MESH='LINKERD'

# Check if meshplayctl is present, else install it
if ! [ -x "$(command -v meshplayctl)" ]; then
    kubectl config view --minify --flatten > ~/minified_config
	mv ~/minified_config ~/.kube/config
    echo 'meshplayctl is not installed. Installing meshplayctl client... Standby... (Starting Meshplay as well...)' >&2
    curl -L https://meshplay.khulnasoft.com/install | ADAPTERS=linkerd PLATFORM=kubernetes bash -
fi

curl -fsL https://run.linkerd.io/emojivoto.yml --output emojivoto.yml

sleep 200
echo "Meshplay has been installed."
kubectl get pods -n meshplay

echo "Deploying meshplay linkerd adapter..."
meshplayctl system login --provider None
echo | meshplayctl mesh deploy adapter meshplay-linkerd:10001 --token "./.github/workflows/auth.json"
sleep 200
echo "Onboarding application... Standby for few minutes..."
#meshplayctl app onboard -f "./emojivoto.yml" -s "Kubernetes Manifest" --token "./.github/workflows/auth.json"
meshplayctl app onboard -f "./emojivoto.yml" --token "./.github/workflows/auth.json"

# Wait for the application to be ready
sleep 100

kubectl get namespace

echo "Service Mesh: $MESH_NAME - $SERVICE_MESH"
echo "Endpoint URL: http://localhost:8080"

# Pass the endpoint to be used by Meshplay
echo "ENDPOINT_URL=http://localhost:8080" >> $GITHUB_ENV
echo "SERVICE_MESH=$SERVICE_MESH" >> $GITHUB_ENV
