#!/bin/bash

# Fail script on any command failure
set -e

# Function to replace
replace_string() {
    local search_string=$1
    local replace_string=$2
    local file_path=$3

    # 检查文件是否存在
    if [ ! -f "$file_path" ]; then
        echo "Error: 文件不存在 - $file_path"
        return 1
    fi

    # 检查字符串是否存在于文件中
    if grep -q "$search_string" "$file_path"; then
        # 字符串存在，执行替换
        sed -i "s#$search_string#$replace_string#g" "$file_path"
    else
        if grep -q "$replace_string" "$file_path"; then
            continue
	else
            # 字符串不存在，抛出异常
            echo "Error: 字符串 '$search_string' 在文件 $file_path 中不存在"
            return 1
	fi
    fi
}

# Function to start Nginx
startNginx() {
	nginx -g 'daemon off;' 2>&1 &
}

# Function to start Xray
startXray() {
	/usr/bin/xray -config /etc/xray/config.json 2>&1 &
}

# Call the functions
replace_string "<server_ssl_crt>" "${SSL_CRT}" "/etc/xray/config.json"
replace_string "<server_ssl_key>" "${SSL_KEY}" "/etc/xray/config.json"
replace_string "<troJanPass>" "${SERVER_PASSWD}" "/etc/xray/config.json"
replace_string "<server_domain>" "${SERVER_DOMAIN}" "/etc/nginx/nginx.conf" 
startNginx
startXray

# Keep the script running
# This line is optional and depends on how you want to manage your processes
tail -f /dev/null
