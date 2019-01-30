#!/bin/bash

 echo 'min_power' > '/sys/class/scsi_host/host1/link_power_management_policy';
 echo 'min_power' > '/sys/class/scsi_host/host2/link_power_management_policy';
 echo 'min_power' > '/sys/class/scsi_host/host0/link_power_management_policy';

 echo '1' > '/sys/module/snd_hda_intel/parameters/power_save';

 echo 'auto' > '/sys/bus/i2c/devices/i2c-2/device/power/control';
 echo 'auto' > '/sys/bus/i2c/devices/i2c-3/device/power/control';
 echo 'auto' > '/sys/bus/i2c/devices/i2c-6/device/power/control';
 echo 'auto' > '/sys/bus/i2c/devices/i2c-1/device/power/control';
 echo 'auto' > '/sys/bus/i2c/devices/i2c-4/device/power/control';
 echo 'auto' > '/sys/bus/i2c/devices/i2c-5/device/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:03.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:03:00.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:02:00.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1b.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:16.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:19.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1c.1/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1d.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:02.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control';
 echo 'auto' > '/sys/bus/pci/devices/0000:00:1f.2/power/control';

 echo 'enabled' > '/sys/class/net/wlp3s0/device/power/wakeup';
 echo 'enabled' > '/sys/bus/usb/devices/usb3/power/wakeup';
 echo 'enabled' > '/sys/bus/usb/devices/usb1/power/wakeup';
 echo 'enabled' > '/sys/bus/usb/devices/usb2/power/wakeup';
 echo 'enabled' > '/sys/bus/usb/devices/1-1/power/wakeup';
