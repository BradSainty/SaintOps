FROM alpine:latest

# Update Image
RUN apk update

# Install common tools
RUN apk add --no-cache curl bash vim tree unzip ncurses git

# Versioning
ENV KUBECTL_VERSION=v1.29.0
ENV KUBELOGIN_VERSION=v1.28.0
ENV KUBECTX_VERSION=0.9.5
ENV KOMPOSE_VERSION=v1.32.0
ENV HELM_VERSION=3.14.3
ENV TF_VERSION=1.7.5

ENV KUBE_EDITOR=vim
ENV KUBECONFIG=/root/.kube/kubeconfig.yml

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/

# Install kubelogin
RUN curl -LO https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin_linux_amd64.zip \
    && unzip kubelogin_linux_amd64.zip \
    && mv kubelogin /usr/local/bin/kubectl-oidc_login \
    && rm kubelogin_linux_amd64.zip

# Install Kubens & Kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz | tar xz \
    && cd ./kubectx-${KUBECTX_VERSION} \
    && mv kubens kubectx /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens \
    && cat completion/kubectx.bash >> ~/.bashrc \
    && cat completion/kubens.bash >> ~/.bashrc \
    && cd ../ \
    && rm -rf ./kubectx-${KUBECTX_VERSION}

# Install Kompose
RUN curl -L https://github.com/kubernetes/kompose/releases/download/${KOMPOSE_VERSION}/kompose-linux-amd64 -o kompose \
    && chmod +x kompose \
    && mv ./kompose /usr/local/bin/kompose

# Install Helm
RUN curl -o helm.tar.gz -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzf helm.tar.gz \
    && rm helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/ \
    && rm -rf linux-amd64 \
    && chmod +x /usr/local/bin/helm  

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && rm awscliv2.zip \
    && ./aws/install

# Install Terraform
RUN curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && rm terraform.zip \
    && chmod +x terraform \
    && mv terraform /usr/local/bin/

ENTRYPOINT ["bash"]
