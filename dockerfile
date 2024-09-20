FROM alpine:latest

# Update Image
RUN apk update

# Install base tools
RUN apk add --no-cache curl vim tree unzip ncurses git bash

# Set Versioning
ENV KUBECTL_VERSION=v1.30.5
ENV KUBELOGIN_VERSION=v1.29.0
ENV KUBECTX_VERSION=0.9.5
ENV KUBESEAL_VERSION=0.27.1
ENV KUBECOLOR_VERSION=0.4.0
ENV K9S_VERSION=v0.32.5
ENV HELM_VERSION=3.16.1
ENV TF_VERSION=1.9.6

ENV KUBE_EDITOR=vim

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/

# Install kubelogin
RUN curl -LO https://github.com/int128/kubelogin/releases/download/${KUBELOGIN_VERSION}/kubelogin_linux_amd64.zip \
    && unzip kubelogin_linux_amd64.zip \
    && mv kubelogin /usr/local/bin/kubectl-oidc_login \
    && rm kubelogin_linux_amd64.zip

# Install kubens & kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v${KUBECTX_VERSION}.tar.gz | tar xz \
    && cd ./kubectx-${KUBECTX_VERSION} \
    && mv kubens kubectx /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens \
    && cat completion/kubectx.bash >> ~/.bashrc \
    && cat completion/kubens.bash >> ~/.bashrc \
    && cd ../ \
    && rm -rf ./kubectx-${KUBECTX_VERSION}

# Install kubeseal
RUN curl -Lo kubeseal.tar.gz https://github.com/bitnami-labs/sealed-secrets/releases/download/v${KUBESEAL_VERSION}/kubeseal-${KUBESEAL_VERSION}-linux-amd64.tar.gz \
    && tar -xzf kubeseal.tar.gz kubeseal \
    && mv kubeseal /usr/local/bin/ \
    && rm -rf kubeseal.tar.gz

# Install kubecolor
RUN curl -L https://github.com/kubecolor/kubecolor/releases/download/v${KUBECOLOR_VERSION}/kubecolor_${KUBECOLOR_VERSION}_linux_amd64.tar.gz  | tar xz \
    && mv kubecolor /usr/local/bin/ \
    && rm LICENSE README.md \
    && echo "alias kubectl='/usr/local/bin/kubecolor'" >> ~/.bashrc \
    && echo "alias k='/usr/local/bin/kubecolor'" >> ~/.bashrc
    
# Install K9s
RUN curl -Lo k9s.tar.gz curl -Lo k9s.tar.gz https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_Linux_amd64.tar.gz  \
    && tar -xzf k9s.tar.gz \
    && mv k9s /usr/local/bin/ \
    && rm -rf k9s.tar.gz

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

ENTRYPOINT ["/bin/bash"]
