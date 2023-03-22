FROM almalinux:9.1

# Update Image
RUN dnf update -y

# Install common tools
RUN dnf install which vim unzip -y

# Install kubectl
RUN curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/

# Install Helm
RUN curl -o ./helm.tar.gz -LO https://get.helm.sh/helm-v3.10.1-linux-amd64.tar.gz \
    && tar -zxvf ./helm.tar.gz \
    && mv ./linux-amd64/helm /usr/local/bin/ \
    && chmod +x /usr/local/bin/helm

# Install AWS CLI
RUN curl https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip \
    && unzip awscliv2.zip \
    && ./aws/install

# Install Terraform
RUN curl https://releases.hashicorp.com/terraform/1.4.2/terraform_1.4.2_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && chmod +x terraform \
    && mv terraform /usr/local/bin/

# Install Kubens & Kubectx
RUN curl -L https://github.com/ahmetb/kubectx/archive/v0.4.0.tar.gz | tar xz \
    && cd ./kubectx-0.4.0 \
    && mv kubens kubectx utils.bash /usr/local/bin/ \
    && chmod +x /usr/local/bin/kubectx /usr/local/bin/kubens \
    && cat completion/kubectx.bash >> ~/.bashrc \
    && cat completion/kubens.bash >> ~/.bashrc \
    && cd ../ \
    && rm -fr ./kubectx-0.4.0

ENV KUBE_EDITOR vim

ENTRYPOINT ["bash"]


