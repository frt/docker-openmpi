#!/bin/bash

nr_nodes=${1:-1}
network_name=${2:-mpi_network}

docker network create "$network_name"
for i in $(seq 0 $(( $nr_nodes - 1 ))); do
    docker run -d --rm \
        --name "node$i" \
        --network "$network_name" \
        --mount type=bind,src=/usr/local,dst=/usr/local,ro \
        mpi-node
done

docker network inspect -f "{{range .Containers}}{{.IPv4Address}} {{end}}" "$network_name" | tr ' ' '\n' | cut -d\/ -f1 > hostsfile

echo "Nodes IPs listed in 'hostsfile' file."
echo "Execute with (for example): mpirun -np $nr_nodes --hostfile ./hostsfile -mca plm_rsh_args \"-i ssh-keys/id_rsa.mpi -l mpi_user -o StrictHostKeyChecking=no\" /usr/local/bin/mpi-app"
