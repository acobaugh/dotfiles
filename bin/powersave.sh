echo powersave | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
sudo powertop --auto-tune
