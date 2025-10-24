#!/bin/bash
echo "+cpu +cpuset" > /sys/fs/cgroup/cgroup.subtree_control
mkdir -p /sys/fs/cgroup/$1/
echo $2 > /sys/fs/cgroup/$1/cpuset.cpus
cat /sys/fs/cgroup/$1/cpuset.cpus > /vagrant/logs/execute.log
echo $3 > /sys/fs/cgroup/$1/cpu.weight
cat /sys/fs/cgroup/$1/cpu.weight >> /vagrant/logs/execute.log
echo "$4 100000" > /sys/fs/cgroup/$1/cpu.max
cat /sys/fs/cgroup/$1/cpu.max >> /vagrant/logs/execute.log
echo $$ > /sys/fs/cgroup/$1/cgroup.procs
cat /sys/fs/cgroup/$1/cgroup.procs >> /vagrant/logs/execute.log
gcc -g -o /home/vagrant/scripts/$1 /home/vagrant/scripts/$1.c
chmod +x /home/vagrant/scripts/$1
unshare -C --mount-proc /home/vagrant/scripts/$1 > /vagrant/output.txt 2>&1 &
