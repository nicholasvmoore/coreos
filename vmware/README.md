VMware cloud-init
===
CoreOS supports cloud-init out of the box and if, like me, you use VMware as your primary hypervisor you can mount an ISO containing your cloud-init files.

## Package Dependencies
 - Fedora
  - yum -y install genisoimage
 - CentOS/RHEL
  - yum -y install genisoimage
 - Debian/Ubuntu
  - apt-get install {whatever the package is installed, not a fan of ubuntu....}

## Create ISO
```bash
mkdir -p /tmp/new-drive/openstack/latest
cp user_data /tmp/new-drive/openstack/latest/user_data
mkisofs -R -V config-2 -o configdrive.iso /tmp/new-drive
rm -r /tmp/new-drive
```

## References
[CoreOS: Customize with Cloud-Init](https://coreos.com/docs/cluster-management/setup/cloudinit-config-drive/)
[CoreOS: Running CoreOS on VMware](https://coreos.com/docs/running-coreos/platforms/vmware/)
[CoreOS: Using Cloud Config](https://coreos.com/docs/cluster-management/setup/cloudinit-cloud-config/#providing-cloud-config-with-config-drive)
