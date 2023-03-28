FROM almalinux:9.1

# Update Image
RUN dnf update -y

# Install common tools
RUN dnf install which vim tree unzip ncurses git -y

ENV KUBECTL_VERSION=1.26.0

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/

ENV HELM_VERSION=3.10.1

# Install Helm
RUN curl -o helm.tar.gz -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz \
    && tar -xzf helm.tar.gz \
    && rm helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/ \
    && rm -rf linux-amd64 \
    && chmod +x /usr/local/bin/helm

# Install Kubens & Kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v0.4.0.tar.gz | tar xz \
    && cd ./kubectx-0.4.0 \
    && mv kubens kubectx utils.bash /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens \
    && cat completion/kubectx.bash >> ~/.bashrc \
    && cat completion/kubens.bash >> ~/.bashrc \
    && cd ../ \
    && rm -fr ./kubectx-0.4.0

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && rm awscliv2.zip \
    && ./aws/install

# Install Github CLI
RUN curl -L https://github.com/cli/cli/releases/download/v2.25.1/gh_2.25.1_linux_386.rpm -o ghcli.rpm \
    && dnf install ghcli.rpm -y \
    && rm -rf ghcli.rpm

ENV TF_VERSION=1.4.2

# Install Terraform
RUN curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && rm terraform.zip \
    && chmod +x terraform \
    && mv terraform /usr/local/bin/

ENV KUBE_EDITOR vim

ENTRYPOINT ["bash"]
