#!/bin/sh

delete() {
    sudo ovs-vsctl del-br vswitch1
    sudo ovs-vsctl del-br vswitch2
    sudo ovs-vsctl del-br vswitch3
    sudo ovs-vsctl del-br vswitch4
    sudo ip netns delete vhost1
    sudo ip netns delete vhost2
    sudo ip netns delete vhost3
    sudo ip netns delete vhost4
    sudo ip netns delete vhost5
    sudo ip netns delete vhost6
    sudo ip netns delete vhost7
    sudo ip netns delete vhost8
    sudo ip link delete vlink5-0
    sudo ip link delete vlink5-1
    sudo ip link delete vlink5-2
    sudo ip link delete vlink5-3
    sudo ip link delete vlink5-4
    sudo ip link delete vlink5-5
}

add() {
    sudo ovs-vsctl add-br vswitch1
    sudo ovs-vsctl add-br vswitch2
    sudo ovs-vsctl add-br vswitch3
    sudo ovs-vsctl add-br vswitch4

    ovs-vsctl set bridge vswitch1 other-config:datapath-id=0000000000000011
    ovs-vsctl set bridge vswitch2 other-config:datapath-id=0000000000000012
    ovs-vsctl set bridge vswitch3 other-config:datapath-id=0000000000000013
    ovs-vsctl set bridge vswitch4 other-config:datapath-id=0000000000000014

    ovs-vsctl set bridge vswitch1 protocols=OpenFlow13
    ovs-vsctl set bridge vswitch2 protocols=OpenFlow13
    ovs-vsctl set bridge vswitch3 protocols=OpenFlow13
    ovs-vsctl set bridge vswitch4 protocols=OpenFlow13
    ovs-vsctl set-controller vswitch1 tcp:192.168.35.51 tcp:192.168.35.55 tcp:192.168.35.56 
#tcp:192.168.35.52 tcp:192.168.35.53
    ovs-vsctl set-controller vswitch2 tcp:192.168.35.51 tcp:192.168.35.55 tcp:192.168.35.56
# tcp:192.168.35.52 tcp:192.168.35.53
    ovs-vsctl set-controller vswitch3 tcp:192.168.35.51 tcp:192.168.35.55 tcp:192.168.35.56 
#tcp:192.168.35.52 tcp:192.168.35.53
    ovs-vsctl set-controller vswitch4 tcp:192.168.35.51 tcp:192.168.35.55 tcp:192.168.35.56 
# tcp:192.168.35.52 tcp:192.168.35.53

    
    sudo ip link add name vlink1-0 type veth peer name vlink1-1
    sudo ip link add name vlink2-0 type veth peer name vlink2-1
    sudo ip link add name vlink3-0 type veth peer name vlink3-1
    sudo ip link add name vlink4-0 type veth peer name vlink4-1
    sudo ip link add name vlink5-0 type veth peer name vlink5-1
    sudo ip link add name vlink6-0 type veth peer name vlink6-1
    sudo ip link add name vlink7-0 type veth peer name vlink7-1
    sudo ip link add name vlink8-0 type veth peer name vlink8-1
    sudo ip link add name vlink9-0 type veth peer name vlink9-1

    sudo ip link add name vlink5-2 type veth peer name vlink5-3
    sudo ip link add name vlink5-4 type veth peer name vlink5-5
    

    sudo ip link set vlink1-0 up
    sudo ip link set vlink2-0 up
    sudo ip link set vlink3-0 up
    sudo ip link set vlink4-0 up
    
    sudo ip link set vlink1-1 up
    sudo ip link set vlink2-1 up
    sudo ip link set vlink3-1 up
    sudo ip link set vlink4-1 up

    sudo ip link set vlink6-0 up
    sudo ip link set vlink7-0 up
    sudo ip link set vlink8-0 up
    sudo ip link set vlink9-0 up

    sudo ip link set vlink6-1 up
    sudo ip link set vlink7-1 up
    sudo ip link set vlink8-1 up
    sudo ip link set vlink9-1 up
    
    sudo ip netns add vhost1
    sudo ip netns add vhost2
    sudo ip netns add vhost3
    sudo ip netns add vhost4
    sudo ip netns add vhost5
    sudo ip netns add vhost6
    sudo ip netns add vhost7
    sudo ip netns add vhost8
    
    sudo ip netns exec vhost1 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost2 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost3 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost4 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost5 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost6 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost7 ifconfig lo 127.0.0.1
    sudo ip netns exec vhost8 ifconfig lo 127.0.0.1

    sudo ip link set vlink1-0 netns vhost1
    sudo ip link set vlink2-0 netns vhost2
    sudo ip link set vlink3-0 netns vhost3
    sudo ip link set vlink4-0 netns vhost4
    sudo ip link set vlink6-0 netns vhost5
    sudo ip link set vlink7-0 netns vhost6
    sudo ip link set vlink8-0 netns vhost7
    sudo ip link set vlink9-0 netns vhost8
    
    sudo ip netns exec vhost1 ifconfig vlink1-0 10.0.1.1/16
    sudo ip netns exec vhost2 ifconfig vlink2-0 10.0.1.2/16
    sudo ip netns exec vhost3 ifconfig vlink3-0 10.0.1.3/16
    sudo ip netns exec vhost4 ifconfig vlink4-0 10.0.1.4/16
    sudo ip netns exec vhost5 ifconfig vlink6-0 10.0.1.5/16
    sudo ip netns exec vhost6 ifconfig vlink7-0 10.0.1.6/16
    sudo ip netns exec vhost7 ifconfig vlink8-0 10.0.1.7/16
    sudo ip netns exec vhost8 ifconfig vlink9-0 10.0.1.8/16
    
    sudo ovs-vsctl add-port vswitch1 vlink5-0
    sudo ovs-vsctl add-port vswitch1 vlink5-2
    sudo ovs-vsctl add-port vswitch1 vlink5-4
    sudo ovs-vsctl add-port vswitch1 vlink1-1
    sudo ovs-vsctl add-port vswitch1 vlink2-1
    
    sudo ovs-vsctl add-port vswitch2 vlink5-1
    sudo ovs-vsctl add-port vswitch2 vlink3-1
    sudo ovs-vsctl add-port vswitch2 vlink4-1

    sudo ovs-vsctl add-port vswitch3 vlink5-3
    sudo ovs-vsctl add-port vswitch3 vlink6-1
    sudo ovs-vsctl add-port vswitch3 vlink7-1

    sudo ovs-vsctl add-port vswitch4 vlink5-5
    sudo ovs-vsctl add-port vswitch4 vlink8-1
    sudo ovs-vsctl add-port vswitch4 vlink9-1

    sudo ip link set vlink5-0 up
    sudo ip link set vlink5-1 up
    sudo ip link set vlink5-2 up
    sudo ip link set vlink5-3 up
    sudo ip link set vlink5-4 up
    sudo ip link set vlink5-5 up

#    ovs-vsctl add-port vswitch1 vxlan1 tag=10 -- set interface vxlan1 type=vxlan options:key=10 options:remote_ip=192.168.56.202
#    ovs-vsctl add-port vswitch1 vxlan2 tag=20 -- set interface vxlan2 type=vxlan options:key=20 options:remote_ip=192.168.56.203
#    ovs-vsctl add-port vswitch1 vxlan3 tag=30 -- set interface vxlan3 type=vxlan options:key=30 options:remote_ip=192.168.56.204

}

case "$1" in
add)
    set -x
    add
    ;;
delete)
    delete > /dev/null 2>&1
    ;;
*)
    echo "usage: $0 {add|delete}"
esac
