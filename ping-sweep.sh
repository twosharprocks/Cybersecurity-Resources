#Simple ping sweeper to find hosts on a private network
#Currently only scans fourth octal of ip4 address. Future version should scan 3rd AND 4th - 10.0.x.x instead of just 10.0.0.x)
#Future version could use fping (or just use NMap like everyone else)

#! /bin/bash
echo "Hosts in 10.0.0.x range"
for ip in $(seq 0 254); do
  ping -c 1 10.0.0.$ip | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 &
done
sleep 1 #implemented incase the response from a host arrives after the "for" loop completes

echo "Hosts in 172.16.0.x range"
for ip2 in $(seq 0 254); do
	ping -c 1 172.16.0.$ip2 | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 &
done
sleep 1

echo "Hosts in 192.168.0.x range"
for ip3 in $(seq 0 254); do
	ping -c 1 192.168.0.$ip3 | grep "bytes from" | cut -d " " -f 4 | cut -d ":" -f 1 &
done
