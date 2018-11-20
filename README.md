# prep4ud<br>

UPDATE Nov 16, 2018: Added a separate package cache to prevent potential issues between updates. Added "No updates available" capability.

A bash script for faster pacman updates. Pre-downloads up-datable packages. <br>
This script was created to avoid the pitfalls of a "partial upgrade" (1) IE: (pacman -Syuw ) (2). <br>
Does NOT perform unattended system update. Requires user to manually run updates (pacman -Syu). <br>

(1): https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported <br>
(2): https://www.reddit.com/r/archlinux/comments/9gy7gk/-/e683akq/ <br>
And: https://www.reddit.com/r/archlinux/comments/9hs7c0/pacman_updates_downloadonly_script_without/ <br>
 
The script copies pacman databases to /tmp, checks for system update availability, creates update list, downloads updates to a separate package cache (/var/cache/pacman/prep4ud/) without installing anything. It then prints a report named 'current date' to ~/Desktop/prep4ud.dir/. 

You MUST transfer downloaded new packages to pacman's cache prior to updating, to be able to install them. <br>

I've updated my shell alias as follows to transfer packages automatically: <br>
alias Syu=' sudo mv /var/cache/pacman/prep4ud/\*pkg\* /var/cache/pacman/pkg/ ; sudo pacman --color=always -Syu' <br>

I've also set up prep4ud to auto run daily via cron. <br>

Screenshot prep4ud: 
![Screenshot 01](https://cody-learner.github.io/prep4ud.html) <br>
Report prep4ud: https://cody-learner.github.io/prep4ud-report.html <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
![doc-holliday-warning130](https://user-images.githubusercontent.com/36802396/46517446-22060d80-c824-11e8-8c2d-9de5d900c938.png)
