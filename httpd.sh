#!/bin/bash

declare -A ENV=(
    ["SERVER_NAME"]=noname
    ["SERVER_PORT"]=8080
    ["SERVER_SOFTWARE"]=httpd.sh
    ["SERVER_PROTOCOL"]=HTTP/1.1
    ["GATEWAY_INTERFACE"]=CGI/1.1
    ["REQUEST_METHOD"]=
    ["HTTP_COOKIE"]=
    ["HTTP_ACCEPT"]=
    ["HTTP_USER_AGENT"]=
    ["HTTP_REFERER"]=
    ["PATH_INFO"]=
    ["PATH_TRANSLATED"]=
    ["SCRIPT_NAME"]=
    ["QUERY_STRING"]=
    ["REMOTE_HOST"]=
    ["REMOTE_ADDR"]=
    ["REMOTE_USER"]=
    ["REMOTE_IDENT"]=
    ["CONTENT_TYPE"]=
    ["CONTENT_LENGTH"]=
    ["REQUEST_METHOD"]=
);

[ -z "$IS_SERVER" ] && {
    export IS_SERVER=1
    socat -T20 TCP-LISTEN:${ENV[SERVER_PORT]},fork,reuseaddr exec:"$0"
    exit -1
}

function readtoken()
{
    CR=""
    read -d$CR $*
}

readtoken method path protocol
echo $method
echo $path
echo $protocol

while readtoken line; do
    echo $line
    printf "$line" | xxd
    if [ -z "$line" ]; then
        echo end!
        break;
    fi
done

echo hello world!

for index in ${!ENV[@]}; do
    echo $index: ${ENV[$index]}
done
