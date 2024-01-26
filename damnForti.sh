#!/bin/bash

# Define VPN host and cookie file path
VPN_HOST="vpn.example.com"
COOKIE_FILE="$HOME/.config/fortivpn/cookie"
TRUSTED_CERT="sample-value"

# Function to connect to VPN
connect_vpn() {
    # Read cookie from file and pass it to openfortivpn
    cookie=$(cat "$1")
    sudo openfortivpn $VPN_HOST --cookie="$cookie" --trusted-cert $TRUSTED_CERT
}

# Check if cookie file exists
if [[ -f "$COOKIE_FILE" ]]; then
    echo "Cookie found, attempting to connect to VPN..."
    connect_vpn "$COOKIE_FILE"

    # Check if VPN connection was successful
    if [[ $? -ne 0 ]]; then
        echo "VPN connection failed. Running openfortivpn-webview to obtain new cookie..."
        # Run openfortivpn-webview to get a new cookie
        new_cookie=$(openfortivpn-webview $VPN_HOST)

        # Store the new cookie
        echo "$new_cookie" > "$COOKIE_FILE"

        # Retry connection with new cookie
        echo "Retrying VPN connection with new cookie..."
        connect_vpn "$COOKIE_FILE"
    else
        echo "Connected to VPN successfully."
    fi
else
    echo "No cookie found. Running openfortivpn-webview to obtain cookie..."
    # The same procedure as above for obtaining and storing the cookie
    new_cookie=$(openfortivpn-webview --get-cookie)
    mkdir -p "$(dirname "$COOKIE_FILE")"
    echo "$new_cookie" > "$COOKIE_FILE"

    # Connect using the new cookie
    connect_vpn "$COOKIE_FILE"
fi
