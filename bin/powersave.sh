echo 1 > /sys/devices/system/cpu/sched_mc_power_savings 
echo 1 > /sys/module/snd_hda_intel/parameters/power_save
echo 0 > /proc/sys/kernel/nmi_watchdog 
ethtool -s em1 wol d

