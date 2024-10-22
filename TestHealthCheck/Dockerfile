# Use the official SQL Server image
FROM mcr.microsoft.com/mssql/server:2022-latest

# Switch to root to install packages
USER root

# Install mssql-tools and dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        curl \
        apt-transport-https \
        gnupg2 && \
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/msprod/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/mssql-tools.list && \
    apt-get update && \
    ACCEPT_EULA=Y apt-get install -y mssql-tools unixodbc-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Restore back to the mssql user
USER mssql
