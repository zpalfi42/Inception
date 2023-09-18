# Specifing the OS and version of the container.
FROM alpine:3.17

# Telling the container to run the commands "apk update" to update apk (Alpine Package Tool) and "apk add --no-chache nginx openssl" to add nginx package and openssl package requiered for the container to work properly. The --no-cache flag is used for not to cache the index locally, keeping the container small.
RUN apk update && apk add --no-cache nginx openssl



