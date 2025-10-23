#!/bin/bash
echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir -p /sys/fs/cgroup/$1/
echo $2 > /sys/fs/cgroup/$1/cpuset.cpus
echo $3 > /sys/fs/cgroup/$1/cpu.weight
echo "$4 100000" > /sys/fs/cgroup/$1/cpu.max
echo $$ > /sys/fs/cgroup/$1/cgroup.procs
gcc -g -o /vagrant/$1 /vagrant/$1.c
unshare -C --mount-proc /vagrant/$1 > /vagrant/output.txt 2>&1 &