CoreOS
======
This repository is to configure CoreOS using a config drive or cloud-init indentically.

Create a Config Drive
--------------------
With your cloud-config file in place you can use it to create a config drive. The easiest way to create a config-drive is to generate an ISO using a cloud-config file and attach it to a VM.

Helper Script (make.sh)
-----------------------
To chose which .yaml you want to include in your config-drive, specify the name *omitting* the extension .yaml as the first argument when calling ./make.sh.

Manual Method
-------------
Linux
```bash
mkdir -p /tmp/new-drive/openstack/latest
cp cloud-config.pdx.yaml /tmp/new-drive/openstack/latest/user_data
mkisofs -R -V config-2 -o configdrive.iso /tmp/new-drive
rm -r /tmp/new-drive
```

MacOS
```bash
mkdir -p /tmp/new-drive/openstack/latest
cp cloud-config.pdx.yaml /tmp/new-drive/openstack/latest/user_data
hdiutil makehybrid -iso -joliet -joliet-volume-name "config-2" -o ~/cloudconfig.iso /tmp/new-drive
rm -r /tmp/new-drive
```

Generate MD5 Password Hash
--------------------------
```bash
openssl passwd -l
```

VMWare
--------------
Running CoreOS on VMWare just got a whole lot easier. Check out this [article](https://coreos.com/blog/vmware-vcloud-air-and-vsphere/) for more information.

```bash
mkdir coreos-vmware
cd coreos-vmware
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_vmware.vmx
wget http://alpha.release.core-os.net/amd64-usr/current/coreos_production_vmware_image.vmdk.bz2
```

Putting etcd values into systemd unit file
------------------------------------------
In order to pull values out of etcd you need to understand that systemd does not invoke a shell, There are a few ways to accomplish this, you can do it during ExecStart or during ExecPreStart. I'm a fan of keeping the ExecStart clean and doing random thing sin ExecPreStart.

### During Exec Start
```bash
ExecStart=/bin/sh -c '/usr/bin/docker run -e A_ADDR=$(/usr/bin/etcdctl get /A_ADDR)
```

### DUring ExecPreStart
```bash
ExecPreStart=/bin/sh -c '/usr/bin/etcdctl get 
```
