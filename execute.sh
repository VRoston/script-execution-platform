#!/bin/bash

echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir /sys/fs/cgroup/$1
echo $2 > /sys/fs/cgroup/$1/cpuset.cpus
echo $3 > /sys/fs/cgroup/$1/cpu.weight
echo "$4 100000" > /sys/fs/cgroup/$1/cpu.max
echo $$ > /sys/fs/cgroup/$1/sub/cgroup.procs
unshare -C --mount-proc /bin/bash
gcc -g -o $1 $1.c && ./$1 > output.txt 2>&1
exit

