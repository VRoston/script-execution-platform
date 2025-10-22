#!/bin/bash

echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir /sys/fs/cgroup/execute1
echo $1 > /sys/fs/cgroup/execute1/cpuset.cpus
echo $2 > /sys/fs/cgroup/execute1/cpu.weight
echo "$3 100000" > /sys/fs/cgroup/execute1/cpu.max
echo $$ > /sys/fs/cgroup/freezer/sub/cgroup.procs
unshare -C --mount-proc /bin/bash
gcc -g -o execute1 execute1.c && ./execute1 > output.txt
exit
