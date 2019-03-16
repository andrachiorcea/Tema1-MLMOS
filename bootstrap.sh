#/bin/bash
echo "Am intrat in fisier"

#update programs

if [[`yum update`]]; then
  echo "updated successful" >&2
else
  ret=$?
  echo "command failed with exit code $ret" >&2
fi

#interface configuration

for intf in /sys/class/net/*; do
    echo "updating interface $intf"
    sudo ifconfig `basename $intf` up
done

#disabling password authentication

selinux_status='getenforce'
if ["$selinux_status" == "disabled"]; then
    echo "Selinux is disabled"
    if [[`setenforce 0`]]; then 
        echo "Setenforce command executed successfully"
    else
        ret=$?
        "command setenforce failed with exit code $ret" 
    fi
fi

