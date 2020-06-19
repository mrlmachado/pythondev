FROM continuumio/miniconda3
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
    apt-get -y install unixodbc-dev && \
    apt-get -y install libgssapi-krb5-2 && \
    apt-get -y install g++ && \
    apt-get -y install libsm6 libxrender1 libfontconfig1 && \
    apt-get -y install python3-setuptools

CMD [ "/bin/bash" ]
