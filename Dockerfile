FROM continuumio/miniconda3:4.8.2

WORKDIR /

RUN set -ex \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
        curl \
        gnupg2 \
        unzip \
        build-essential \
        unixodbc-dev \
        libgssapi-krb5-2 \
        g++ \
        libsm6 libxrender1 libfontconfig1 libgl1-mesa-dev \
        python3-setuptools \
    && curl -s https://packages.microsoft.com/keys/microsoft.asc | apt-key add - \
    && curl -s https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && apt-get -qq update \
    && ACCEPT_EULA=Y apt-get -qq install -y --no-install-recommends \
        msodbcsql17 \
        mssql-tools \
        powershell \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bash_profile \
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && . ~/.bashrc \
    && curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
        && unzip -qq awscliv2.zip \
        && ./aws/install --update \
        && rm -f awscliv2.zip \
    && pwsh -Command Install-Module dbatools -AcceptLicense -PassThru -Force -SkipPublisherCheck \
    && apt-get -qq clean \
    && rm -rf /var/lib/apt/lists/*
