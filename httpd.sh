#!/bin/bash

declare -A ENV=(
    ["SERVER_NAME"]=noname
    ["SERVER_PORT"]=8080
    ["SERVER_SOFTWARE"]=httpd.sh
    ["GATEWAY_INTERFACE"]=CGI/1.1
    ["SERVER_PROTOCOL"]=
    ["REQUEST_METHOD"]=
    ["HTTP_HOST"]=
    ["HTTP_COOKIE"]=
    ["HTTP_ACCEPT"]=
    ["HTTP_ACCEPT_ENCODING"]=
    ["HTTP_ACCEPT_LANGUAGE"]=
    ["HTTP_USER_AGENT"]=
    ["HTTP_REFERER"]=
    ["PATH_INFO"]=
    ["PATH_TRANSLATED"]=
    ["SCRIPT_NAME"]=
    ["QUERY_STRING"]=
    ["REMOTE_ADDR"]=$SOCAT_PEERADDR
    ["CONTENT_TYPE"]=
    ["CONTENT_LENGTH"]=
    ["REQUEST_METHOD"]=
);

[ -z "$IS_SERVER" ] && {
    export IS_SERVER=1
    socat -t2 -T20 TCP-LISTEN:${ENV[SERVER_PORT]},fork,reuseaddr exec:"$0"
    exit -1
}

function readtoken()
{
    CR=""
    read -d$CR $*
}

function error()
{
    echo error_code:$1
    echo reason: $2
    exit -1
}

readtoken method path protocol

case "$method" in 
    HEAD)
        ;;

    GET)
        ;;

    *)
        error 500 "method not implement"
        ;;
esac

case $protocol in
    HTTP/1.1)
        ;;

    HTTP/1.0)
        ;;
        
    *)
        error 500 "$protocol not support"
        ;;
esac

[ "${path:0:1}" != "/" ] && error 500 "bad http request!"

ENV[REQUEST_METHOD]=$method
ENV[SCRIPT_NAME]=${path%\?*}
ENV[PATH_INFO]=${ENV[SCRIPT_NAME]}
ENV[SERVER_PROTOCOL]=$protocol

case $path in 
    *\?*)
        ENV[QUERY_STRING]=${path#*\?}
        ;;
esac

while readtoken line; do
    echo $line
    case $line in
        Accept:*)
            ENV[HTTP_ACCEPT]=`echo ${line#*:}`
            ;;

        Accept-Language:*)
            ENV[HTTP_ACCEPT_LANGUAGE]=`echo ${line#*:}`
            ;;

        Accept-Encoding:*)
            ENV[HTTP_ACCEPT_ENCODING]=`echo ${line#*:}`
            ;;

        Content-Type:*)
            ENV[CONTENT_TYPE]=`echo ${line#*:}`
            ;;

        Content-Length:*)
            ENV[CONTENT_LENGTH]=`echo ${line#*:}`
            ;;

        Host:*)
            ENV[HTTP_HOST]=`echo ${line#*:}`
            ;;

        User-Agent:*)
            ENV[HTTP_USER_AGENT]=`echo ${line#*:}`
            ;;

        Referer:*)
            ENV[HTTP_REFERER]=`echo ${line#*:}`
            ;;

        "")
            break
            ;;

        *)
            #Connection,Cache-Control and so on
            ;;
    esac
done

ENV[PATH_TRANSLATED]=${ENV[HTTP_HOST]}${ENV[PATH_INFO]}

for index in ${!ENV[@]}; do
    echo $index:${ENV[$index]}
done

