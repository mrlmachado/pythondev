FROM continuumio/miniconda3:4.8.2
WORKDIR /

RUN apt-get update; apt-get -y install curl; apt-get -y install gnupg2

RUN apt -y install unzip

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get -y install msodbcsql17 && \
    ACCEPT_EULA=Y apt-get -y install mssql-tools && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile && \
    echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc && \
    . ~/.bashrc && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install --update && \
    rm -rf awscliv2.zip && \
    apt-get -y install build-essential && \
    apt-get -y install unixodbc-dev && \
    apt-get -y install libgssapi-krb5-2 && \
    apt-get -y install g++ && \
    apt-get -y install libsm6 libxrender1 libfontconfig1 libgl1-mesa-dev && \
    apt-get -y install python3-setuptools && \
    apt-get -y install powershell

RUN pwsh -Command Install-Module dbatools -AcceptLicense -PassThru -Force -SkipPublisherCheck
