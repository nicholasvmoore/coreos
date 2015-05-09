Heapster Configuration
----------------------
Heapster seems like a good tool to deploy and at first sight easily deployed.  I found a few difficulties in this and decided to document the steps I took to deploy Heapster on my VMWare CoreOS infrastructure.

Design
------
It should be noted that I find the best design for this approach, pre-kubernetes, to be that InfluxDB, should you decide to use the sink I used, needs to be managed and packaged separately.  I find the main use case for not putting InfluxDB into Fleet or other cluster management tools to be that it's quite hard to 'tell' your many heapster/grafana services taht the sink has indeed moved.  I believe that kubernetes shoudl be a tool that can fill this shortcoming. That being said, I believe the best deisgn, for now, is to share one InfluxDB (cluster) to many heapster/grafana deployments. 
 
For my design I plan to register my InfluxDB instance within etcd. One reason is to get into the habbit of using a key/value store. The second is to prepare for the time when kubernetes is stable and I can begin experimenting. After-all, there are many things that I can spend my time hacking on which are stable. Next, I'm going to schedule grafana and heapster with fleet as they do not rely on each other and only reply on InfluxDB.  I have written a one-shot systemd unit that will be used to write an Environment file to `/etc/conf.d/{heapster,grafana}` respectively. Which will contain the location of the InfluxDB host and any other environment variables I decide to store in etcd. 
 
Required etcd keys
------------------
```bash
etcdctl set /production/heapster/cadvisor_port 4194
etcdctl set /production/heapster/influxdb_name k8s
etcdctl set /production/heapster/influxdb_username root
etcdctl set /production/heapster/influxdb_password root
```
