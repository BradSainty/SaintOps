# SaintOps | A DevOps toolbelt

This Docker image serves as a comprehensive DevOps toolbelt, pre-configured with essential tools for managing Kubernetes, AWS and IaC. 

This concept was inspired by [Jessie Frazelle's](https://github.com/jessfraz/dockerfiles) containerised workflow philosophy. 

By running applications inside containers, you can maintain a powerful set of portable and consistent tools across different systems on demand.

# Run Command
docker run -it --rm \
  --network host \
  -v "$PWD":/work \
  -v "$HOME/.aws":/root/.aws \
  -v "$HOME/.kube":/root/.kube \
  --workdir /work \
  ghcr.io/bradsainty/saintops:v2.0

# Tools
- Kubectl
- Kubelogin
- Kubectx
- Kubens
- Kubecolor
- K9s
- Helm
- AWS CLI
- Terraform

