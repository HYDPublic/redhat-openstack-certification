time openstack overcloud deploy --templates /home/stack/openstack/templates/openstack-tripleo-heat-templates \
-e /home/stack/openstack/templates/openstack-tripleo-heat-templates/environments/network-isolation.yaml \
-e /home/stack/openstack/templates/network-environment.yaml \
-e /home/stack/openstack/templates/storage-environment.yaml \
--control-flavor control \
--compute-flavor compute \
--control-scale 1 \
--compute-scale 1 \
--ntp-server 10.210.8.24 \
--neutron-tunnel-types vxlan \
--neutron-network-type vxlan 

