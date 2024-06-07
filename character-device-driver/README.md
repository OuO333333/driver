# Character-device-driver
How to use:  
  &nbsp;&nbsp;&nbsp;&nbsp;In driver:  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. sudo make clean  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. sudo make  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. sudo insmod mychardev.ko  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. sed -n '/^Character/, /^$/ { /^$/ !p }' /proc/devices  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;5. sudo rmmod mychardev.ko  
  &nbsp;&nbsp;&nbsp;&nbsp;In test/dev.c:  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. sudo make  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. sudo make check  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. sudo tail -n50 /var/log/kern.log  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. ./dev ...  
  &nbsp;&nbsp;&nbsp;&nbsp;In test/pthread.c:  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1. sudo make  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2. sudo make check  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3. sudo tail -n50 /var/log/kern.log  
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4. sudo taskset --cpu-list 0 ./pthread
  
What it do:  
&nbsp;&nbsp;&nbsp;&nbsp;init operation:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;implement static & dynamic methods to register device region  
&nbsp;&nbsp;&nbsp;&nbsp;open/release operation:   
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Linux Device Drivers, 3rd Edition, Restricting Access to a Single User at a Time  
&nbsp;&nbsp;&nbsp;&nbsp;R/W operation:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;maintain a buffer and perform r/w operations on it  
&nbsp;&nbsp;&nbsp;&nbsp;ioctl operation:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;use ioctl operation for more customized behavior on devices  
  
Reference:  
    &nbsp;&nbsp;&nbsp;&nbsp;character device drivers:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://linux-kernel-labs.github.io/refs/heads/master/labs/device_drivers.html  
    &nbsp;&nbsp;&nbsp;&nbsp;MKDEV(MAJOR, MINOR):  
    &nbsp;&nbsp;&nbsp;&nbsp;https://www.cnblogs.com/lilto/p/11878288.html  
    &nbsp;&nbsp;&nbsp;&nbsp;alloc_chrdev_region:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://blog.csdn.net/kangear/article/details/13746091  
    &nbsp;&nbsp;&nbsp;&nbsp;gcc obj to exec:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://stackoverflow.com/questions/1846913/how-to-make-an-executable-file-from-a-c-object-file  
    &nbsp;&nbsp;&nbsp;&nbsp;PHONY:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://blog.csdn.net/lxq19980430/article/details/84800916  
    &nbsp;&nbsp;&nbsp;&nbsp;atomic example:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://www.hitchhikersguidetolearning.com/2021/01/03/linux-kernel-atomic-operations-sample-code/  
    &nbsp;&nbsp;&nbsp;&nbsp;-Wimplicit-function-declaration:  
    &nbsp;&nbsp;&nbsp;&nbsp;https://hackmd.io/@unis/44455566  
    &nbsp;&nbsp;&nbsp;&nbsp;Blocking open & Non Blocking open  
    &nbsp;&nbsp;&nbsp;&nbsp;https://www.makelinux.net/ldd3/chp-6-sect-6.shtml
