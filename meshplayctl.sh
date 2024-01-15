#!/usr/bin/env bash

SCRIPT_DIR=$(dirname -- "$(readlink -f "${BASH_SOURCE[0]}" || realpath "${BASH_SOURCE[0]}")")

declare -A adapters
adapters["istio"]=meshplay-istio:10000
adapters["linkerd"]=meshplay-linkerd:10001
adapters["consul"]=meshplay-consul:10002
adapters["network_service_mesh"]=meshplay-nsm:10004
adapters["kuma"]=meshplay-kuma:10007
adapters["open_service_mesh"]=meshplay-osm:10009
adapters["traefik_mesh"]=meshplay-traefik-mesh:10006

main() {
	local perf_filename=
	local perf_profile_name=
	local endpoint_url=
	local service_mesh=
	local test_name=
	local load_generator=

	parse_command_line "$@"

	# perform the test given in the provided profile_id
	if [ -z "$perf_filename" ]
	then
		# get the mesh name from performance test config
		service_mesh=$(meshplayctl perf view $perf_profile_name -t ~/auth.json -o json 2>&1 | jq '."service_mesh"' | tr -d '"')
		echo "Checking service mesh list from given profile..."
		#echo $service_mesh
		if [[ -n $service_mesh ]]
		then
			echo "Service mesh is present from profile."
			shortName=$(echo ${adapters[$service_mesh]} | cut -d ':' -f1)
			echo $shortName
			shortName=${shortName#meshplay-} #remove the prefix "meshplay-"
			if [[ -z $shortName ]]
			then
				echo "'shortName' value is empty. Provide a valid profile containing with service mesh name, else contact us to raise an issue!"
				exit 1
			else 
				docker network connect bridge meshplay_meshplay-"$shortName"_1
				docker network connect minikube meshplay_meshplay-"$shortName"_1
			fi
			docker network connect bridge meshplay_meshplay_1
			docker network connect minikube meshplay_meshplay_1
			meshplayctl system config minikube -t ~/auth.json

		else
			echo "Service mesh not found from profile. Invalid profile name has been provided"
			exit 1
		fi
		#rand_string=$(openssl rand -hex 3)
		#perf_profile_name="$rand_string-$perf_profile_name"
		echo "Running test with performance profile $perf_profile_name"
		meshplayctl perf apply $perf_profile_name -t ~/auth.json --yes
		
	else
		echo "Executing from given test config file..."
		#echo $service_mesh
		shortName=$(echo ${adapters[$service_mesh]} | cut -d ':' -f1)
		shortName=${shortName#meshplay-} #remove the prefix "meshplay-"
		docker network connect bridge meshplay_meshplay-"$shortName"_1
		docker network connect minikube meshplay_meshplay-"$shortName"_1
		
		docker network connect bridge meshplay_meshplay_1
		docker network connect minikube meshplay_meshplay_1
		meshplayctl system config minikube -t ~/auth.json
		
		perf_profile_name="smp-$perf_profile_name"
		
		echo "Configuration file: $perf_filename"
		echo "Endpoint URL: $endpoint_url"
		echo "Service Mesh: $service_mesh"
		echo "Test Name: $test_name"
		echo "Load Generator: $load_generator"
		echo "Profile name: $perf_profile_name"

		echo "Running test with test configuration file $perf_filename"
		meshplayctl perf apply --file $GITHUB_WORKSPACE/.github/$perf_filename -t ~/auth.json --url "$endpoint_url" --mesh "$service_mesh" --name "$test_name" --load-generator "$load_generator" $perf_profile_name -y
	fi
}

parse_command_line() {
	while :
	do
		case "${1:-}" in
			--perf-filename)
				if [[ -n "${2:-}" ]]; then
					perf_filename=$2
					shift
				else
					echo "ERROR: '--profile-name' cannot be empty." >&2
					exit 1
				fi
				;;
			--profile-name)
				if [[ -n "${2:-}" ]]; then
					perf_profile_name=$2
					shift
				else
					echo "ERROR: '--profile-id' cannot be empty." >&2
					exit 1
				fi
				;;
			--endpoint-url)
				if [[ -n "${2:-}" ]]; then
					endpoint_url=$2
					shift
				else
					echo "ERROR: '--endpoint-url' cannot be empty." >&2
					exit 1
				fi
				;;
			--service-mesh)
				if [[ -n "${2:-}" ]]; then
					service_mesh=$2
					shift
				else
					echo "ERROR: '--service-mesh' cannot be empty." >&2
					exit 1
				fi
				;;
			--test-name)
				if [[ -n "${2:-}" ]]; then
					test_name=$2
					shift
				else
					echo "ERROR: '--test-name' cannot be empty." >&2
					exit 1
				fi
				;;
			--load-generator)
				if [[ -n "${2:-}" ]]; then
					load_generator=$2
					shift
				else
					echo "ERROR: '--load-generator' cannot be empty." >&2
					exit 1
				fi
				;;
			*)
				break
				;;
		esac
		shift
	done
}

main "$@"
