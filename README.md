# prep4ud<br>

A bash script for faster pacman updates. Pre-downloads up-datable packages. <br>
This script was created to avoid the pitfalls of a "partial upgrade" (1) IE: (pacman -Syuw ) (2). <br>
Does NOT perform unattended system update. Requires user to manually run updates (pacman -Syu). <br>

(1): https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported <br>
(2): https://www.reddit.com/r/archlinux/comments/9gy7gk/-/e683akq/ <br>
And: https://www.reddit.com/r/archlinux/comments/9hs7c0/pacman_updates_downloadonly_script_without/ <br>
 
The script copies pacman databases to /tmp, checks for system update availability, creates update list, downloads updates to default pacman package cache (/var/cache/pacman/pkg/) without installing. If updates are available, prints text to ~/Desktop. 
Running pacman -Syu immediately following prep4ud script running would result in eliminating the need to download packages.

Set the script to auto run via cron or a systemd timer prior to your normal update schedule.

Screenshot: https://cody-learner.github.io/prep4ud.html
![doc-holliday-warning130](https://user-images.githubusercontent.com/36802396/46517446-22060d80-c824-11e8-8c2d-9de5d900c938.png)
