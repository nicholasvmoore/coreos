Heapster
=========
Helpful documents for heapster

Docker Run
-------------
Heapster needs to have access to etcd in order to query it for the fleet hosts within the hidden directory _coreos.com/.  Because it assumes that etcd is running on the host it defaults to 127.0.0.1:4001 which means that heapster needs access to this.  You could do portmapping but I've used host networking because it's easy.

```bash
docker run --name heapster -d -e INFLUXDB_HOST=192.168.200.90:8086 -e COREOS=true -e CADVISOR_PORT=4194 --net=host kubernetes/heapster
```
