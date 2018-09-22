# prep4ud<br>

A bash script for faster pacman updates. Pre-downloads updatable packages. <br>
This script was created to avoid the pitfalls of a "partial upgrade" (see 1) ie: (pacman -Syuw ) (see 2). <br>
Does NOT perform unattended system update. User still required to manually run updates (pacman -Syu). <br>

(1) https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported <br>
(2) https://www.reddit.com/r/archlinux/comments/9gy7gk/-/e683akq/ <br>
And: https://www.reddit.com/r/archlinux/comments/9hs7c0/pacman_updates_downloadonly_script_without/ <br>
 
The script copies pacman databases to /tmp, checks for system update availability, creates update list, downloads updates without installing. If updates are available, prints text to ~/Desktop/prep4ud-"${DATE}". 

Set the script to auto run via cron or systemd timer.
