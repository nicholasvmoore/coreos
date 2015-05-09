Heapster
=========
Helpful documents for heapster, I foudn the documentation for Heapster lacking in many areas, partly due to my coreos cluster running on VMWare and partly due to heapster being more widely deployed on kubernetes.

Docker Run
-------------
Heapster needs to have access to etcd in order to query it for the fleet hosts within the hidden directory _coreos.com/.  Because it assumes that etcd is running on the host it defaults to 127.0.0.1:4001. However, we're running Heapster in a container and within the container 127.0.0.1:4001 is serviced by nothing. You can do this two ways that I see, host networking or set a runtime flag. Below are two examples.

Host Networking
---------------
```bash
docker run --name heapster -d -e INFLUXDB_HOST=192.168.200.90:8086 -e COREOS=true -e CADVISOR_PORT=4194 --net=host kubernetes/heapster
```

Runtime Configuration
---------------------
/usr/bin/heapster --fleet_endpoints=http://${COREOS_PRIVATE_IPV4}:4001
