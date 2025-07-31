# damn-forti

*Retired* - `sudo openfortivpn http://whatever --saml-login --use-resolvconf=0` is enough now :)

Simple SAML login script for FortiVPN. 
Heavily inspired by [fuckForticlient](https://github.com/nonamed01/fuckForticlient)'s attitude. 

This would not be possible without [openfortivpn-webview](https://github.com/gm-vm/openfortivpn-webview) doing all the heavy lifting.

For now, tested only on Manjaro Linux.
Prerequisities:

```
yay -S openfortivpn openfortivpn-webview-qt
```

Modify variables ```VPN_HOST``` and ```TRUSTED_CERT``` to your needs.
