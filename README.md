# prep4ud<br>

A bash script for faster pacman updates. Pre-downloads up-datable packages. <br>
This script was created to avoid the pitfalls of a "partial upgrade" (1) IE: (pacman -Syuw ) (2). <br>
Does NOT perform unattended system update. Requires user to manually run updates (pacman -Syu). <br>

(1): https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported <br>
(2): https://www.reddit.com/r/archlinux/comments/9gy7gk/-/e683akq/ <br>
And: https://www.reddit.com/r/archlinux/comments/9hs7c0/pacman_updates_downloadonly_script_without/ <br>
 
The script copies pacman databases to /tmp, checks for system update availability, creates update list, downloads updates to /var/cache/pacman/pkg/ without installing anything. It then prints a report named 'current date' to ~/Desktop/prep4ud.dir/. 

I've set up prep4ud to auto run daily via cron. <br>

Screenshot prep4ud: https://cody-learner.github.io/prep4ud.html <br>
Report prep4ud: https://cody-learner.github.io/prep4ud-report.html <br>
<br>
<br>
NEWS:<br>
FOR Oct 29, 2019: <br>
The functionality of prep4ud has now been added (with nearly same method and code) in the checkupdates script. <br>
Thank you and shout out to Eli Schwartz for the addition! Checkupdates is available in the pacman-contrib package. <br>
Notable differences being additional information provided in prep4ud logs <br>
and checkupdates omits downloading packages listed in /etc/pacman.conf ignore section. <br>
<br>
<br>
UPDATE INFO: <br>
UPDATE Oct 29, 2019:
Fix for pacman 5.2 change of date format in pacman.log


UPDATE Feb 13, 2019:
Eliminated separate package cache. Updated packages are downloaded to pacman package cache /var/cache/pacman/pkg/.
Use pacman -Syu to update.


UPDATE Nov 16, 2018:
Added a separate package cache to prevent potential issues between updates. Added "No updates available" capability.

