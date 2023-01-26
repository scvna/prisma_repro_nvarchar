FROM mcr.microsoft.com/mssql/server:2019-latest

EXPOSE 1433

# Create a config directory
RUN mkdir -p /usr/config
WORKDIR /usr/config

# Bundle config source
COPY ./scripts /usr/config

ENTRYPOINT ["./entrypoint.sh"]