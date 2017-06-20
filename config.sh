DOCUMENT_ROOT=`pwd`/doc
INDEX=index.php
CACHE_DIR=./cache
SSL_DIR=./ssl

declare -A CONFIG=(
    [SERVER_NAME]=noname
    [SERVER_PORT]=8080
    [SERVER_SOFTWARE]=httpd.sh
    [SERVER_ADDR]=127.0.0.1
    [GATEWAY_INTERFACE]=CGI/1.1
    [HTTPS_ENABLED]=yes
);

