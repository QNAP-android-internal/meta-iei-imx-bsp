#!/bin/bash
network_name=`ifconfig |awk '{print $1}'|grep :|awk -F: '{print $1}'`
touch /home/ubuntu/.local/share/iptable.txt
sudo iptable -X
for net_name in ${network_name}
   do
       if [ ${net_name} = 'lo' ]; then
              continue
       fi
       if [ ${net_name} = 'docker0' ]; then
              continue
       fi
       if ! grep -q ${net_name} /home/ubuntu/.local/share/iptable.txt ; then
	      echo ${net_name} >> /home/ubuntu/.local/share/iptable.txt
	      sudo iptables -A FORWARD --in-interface ${net_name} -j ACCEPT
	      sudo iptables --table nat -A POSTROUTING --out-interface ${net_name} -j MASQUERADE
	      sudo iptables-save
	      sudo netfilter-persistent save
       fi
   done
