FROM jenkinsci/jnlp-slave:latest

USER root

# Install docker client, kubectl and helm
RUN curl -sSL https://get.docker.com/ | sh && \
    curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh && \
    chmod 700 get_helm.sh && \
    ./get_helm.sh && \
    rm -f get_helm.sh && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod 755 kubectl && \
    mv kubectl /usr/local/bin/kubectl

# Debian packages
RUN apt-get update -qy && \
    DEBIAN_FRONTEND=noninteractive apt-get install -qy python-pip groff-base && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN usermod -aG docker jenkins

USER jenkins
