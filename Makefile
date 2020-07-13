mpi-node-image: | ssh-keys/id_rsa.mpi ssh-keys/id_rsa.mpi.pub
	docker image build -t mpi-node .

ssh-keys/id_rsa.mpi ssh-keys/id_rsa.mpi.pub:
	ssh-keygen -f ssh-keys/id_rsa.mpi

.PHONY: mpi-node-image
