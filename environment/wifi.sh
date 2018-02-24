ESSID=

ip link set wlp1s0 up
iw wlp1s0 link
if [ ! -f /etc/wpa_supplicant.conf ] 
then
	wpa_passphrase $ESSID >> /etc/wpa_supplicant.conf
fi
wpa_supplicant -B  -D wext -i wlp1s0 -c /etc/wpa_supplicant.conf 
iw wlp1s0 link
dhclient wlp1s0
ping -c 3 8.8.8.8
