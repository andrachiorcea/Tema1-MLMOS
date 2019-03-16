#/bin/bash
echo "Am intrat in fisier"

#update programs
yum update
if [ $? -eq 0 ]; then
  echo "updated successful"
else
  ret=$?
  echo "command failed with exit code $ret"
fi

#interface configuration

for intf in /sys/class/net/*; do
    echo "updating interface $intf"
    sudo ifconfig `basename $intf` up
done

#disabling password authentication

var =`grep SELINUX="disabled" /etc/selinux/config | tr "=" "\n" | sed -n 2p`
echo "$var"
if [ "$var" == "disabled" ]; then
    echo "Selinux is disabled"
    setenforce 0
    if [ $? -eq 0 ]; then 
        echo "Setenforce command executed successfully"
    else
        ret=$?
        "command setenforce failed with exit code $ret" 
    fi
else 
    echo "Selinux is not disabled"
fi

