FROM alpine:latest AS setup
WORKDIR /app

RUN apk add --no-cache --upgrade curl unzip
RUN curl -SL https://github.com/spikeydragoon/Cross-Ark-Chat/files/5556890/CrossArkChatLinux.zip -o CrossArkChatLinux.zip \
    && unzip CrossArkChatLinux.zip \
    && rm -rf CrossArkChatLinux.zip \
    && mv CrossArkChatLinux/* .

FROM mcr.microsoft.com/dotnet/runtime:3.1-alpine
WORKDIR /app
COPY --from=setup /app ./
ENTRYPOINT ["dotnet", "CrossArkChat.dll"]