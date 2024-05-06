FROM jenkins/jenkins:latest-jdk17

USER root

# Update system and install dependencies
RUN apt-get update && \
    apt-get install -y \
    lsb-release \
    python3-pip \
    git \
    curl \
    software-properties-common \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    maven \
    ansible

# Add Docker’s official GPG key
RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

# Set up the Docker repository
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && \
    apt-get install -y docker-ce-cli

# Switch back to the jenkins user
USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins \
    blueocean \
    docker-workflow \
    git \
    job-dsl \
    configuration-as-code \
    terraform \
    ansible
