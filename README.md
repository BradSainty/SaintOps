# SaintOps | A DevOps toolbelt

This docker image contains some common tools used for working with Kubernetes and AWS. 

A concept inspired by [Jessie Frazelle](https://github.com/jessfraz/dockerfiles) - you don't need to install separate tools on your machine, this image allows you to work with a set of tools from a single docker run command on any machine.

# Run Command
docker run -it --rm --network=host -v $PWD:/work -v ~/.kube:/root/.kube --workdir /work saintops:v2 

# Tools
- Kubectl
- Helm
- Kubectx
- Kubens
- AWS CLI
- Guthub CLI
- Terraform

