#!/usr/bin/env bash
# This script is used to deploy Istio on Kubernetes
#
# Also deploys the bookinfo application on Istio and passes the gateway URL to Meshplay
# See: https://github.com/service-mesh-performance/service-mesh-performance/blob/master/protos/service_mesh.proto

export MESH_NAME='Istio'
export SERVICE_MESH='ISTIO'

# Check if meshplayctl is present, else install it
if ! [ -x "$(command -v meshplayctl)" ]; then
    kubectl config view --minify --flatten > ~/minified_config
	mv ~/minified_config ~/.kube/config
    echo 'meshplayctl is not installed. Installing meshplayctl client... Standby... (Starting Meshplay as well...)' >&2
    curl -L https://meshplay.io/install | ADAPTERS=istio PLATFORM=kubernetes bash -
fi

sleep 200
kubectl get pods -n meshplay
echo "Meshplay has been installed."
meshplayctl system login --provider None
# echo "Deploying meshplay istio adapter..."
# echo | meshplayctl mesh deploy adapter meshplay-istio:10000 --namespace "istio-system" --token "./.github/workflows/auth.json"
# sleep 200
# echo "Onboarding application... Standby for few minutes..."
# meshplayctl pattern apply -f "https://raw.githubusercontent.com/service-mesh-patterns/service-mesh-patterns/master/samples/bookInfoPattern.yaml" --token "./.github/workflows/auth.json"

curl -fsL http://raw.githubusercontent.com/service-mesh-patterns/service-mesh-patterns/master/samples/minimalistiobookinfo.yaml --output minimalistiobookinfo.yaml

# Change profile to default
yq e -i '.services.istioinstallation.settings.profile = "default"' minimalistiobookinfo.yaml

cat minimalistiobookinfo.yaml
meshplayctl pattern apply -f "./minimalistiobookinfo.yaml" --token "./.github/workflows/auth.json"
# Wait for the application to be ready
sleep 300

# Get the gateway URL and export it and
# Expose the service inside the cluster
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export INGRESS_HOST=$(minikube ip)
kubectl -n istio-system get service 
kubectl -n default get service 
kubectl get namespace
echo "INGRESS_PORT : $INGRESS_PORT , $SECURE_INGRESS_PORT"
export GATEWAY_URL=http://$INGRESS_HOST:$INGRESS_PORT

minikube tunnel &> /dev/null &

echo "Service Mesh: $MESH_NAME - $SERVICE_MESH"
echo "Gateway URL: $GATEWAY_URL"
echo "ENDPOINT_URL=$GATEWAY_URL/productpage" >> $GITHUB_ENV
echo "SERVICE_MESH=$SERVICE_MESH" >> $GITHUB_ENV
