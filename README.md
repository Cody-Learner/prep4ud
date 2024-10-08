# prep4ud<br>

A bash script for faster pacman updates. Pre-downloads up-datable packages. <br>
This script was created to avoid the pitfalls of a "partial upgrade" (1) IE: (pacman -Syuw ) (2). <br>
Does NOT perform unattended system update. Requires user to manually run updates (pacman -Syu). <br>

(1): https://wiki.archlinux.org/index.php/System_maintenance#Partial_upgrades_are_unsupported <br>
(2): https://www.reddit.com/r/archlinux/comments/9gy7gk/-/e683akq/ <br>
And: https://www.reddit.com/r/archlinux/comments/9hs7c0/pacman_updates_downloadonly_script_without/ <br>
 
The script copies pacman databases to /tmp, checks for system update availability, creates update list, downloads updates to /var/cache/pacman/pkg/ without installing anything. It then prints a report named 'current date' to ~/Desktop/prep4ud.dir/. 

I've set up prep4ud to auto run daily via cron. <br>

![prep4ud-2020-12-05](https://user-images.githubusercontent.com/36802396/101270322-b7ff9080-372c-11eb-9af6-c4aa0af80a98.png)

Screenshot prep4ud: https://cody-learner.github.io/prep4ud.html <br>
Report prep4ud: https://cody-learner.github.io/prep4ud-report.html <br>
<br>
<br>
NEWS/UPDATE INFO:<br>
<br>
UPDATE Oct 07, 2024: <br>
Reverted change to Uzr variable.  <br>


UPDATE Sep 28, 2024: <br>
prep4ud: <br>
Added '+x' to temp dirs to work with changes in pacman 7.0. <br>
Added a set of missing double quotes to appease shellcheck. <br>
Use $UID in place of hardcoded user 1000 for Uzr variable.  <br>


UPDATE July 26, 2024: <br>
prep4ud: <br>
Added 'Destdir' variable. <br>
Added check/create Destdir if missing. <br>
Redirected 'stderr' to /dev/null for 'find' command in setting 'Count' variable. <br>


UPDATE June 16, 2021: <br>
Added capacity to send temp db sync errors to report. <br>
Added pacman '--color=never' to temp db sync operation to remove color codes in report. <br>
Added '$1" "' to:  'awk '/downloading/ {print $1" "$2}' "${tmpDir}"/pacSw. Now works with pacman 6.0 'downloading packages' format. <br>
Clean up and carify comments. <br>


UPDATE Feb 11, 2021: <br>
Line containing 'pacman -Sw redirection to pacSw file': Fixed issue causing error printed to that file. <br>
Fixed grep pattern matches to eliminate term that was part of a package name, <br>
and to more accurately reflect desired result printing errors/issues to report. <br>


UPDATE Dec 07, 2020: <br>
Tee 'pacman -Sw' output to terminal to show whats going on when running manually.


UPDATE Dec 05, 2020: <br>
Added date and more detailed transaction info in prep4ud report. <br>
Refined find command to handle subdir's presence in report directory. <br>
Switched order of if statement used to send report. <br>
Implemented mktmp use for directories to simplify cleanup. <br>
Switched all uppercase use in var's to Up/lower case. <br>
Implemented parameter expansion in array usage.<br>
Eliminate downloading updates for "ignored packages". <br>


UPDATE Oct 29, 2019:
Fix for pacman 5.2 change of date format in pacman.log


NEWS FOR Oct 29, 2019: <br>
The functionality of prep4ud has now been added (nearly same method and code) in an official repo package, in the checkupdates script.
Checkupdates is available in the pacman-contrib package. Shout out to Eli Schwartz for the contribution! <br>
Notable differences being additional information provided in prep4ud reports <br>
and checkupdates omits downloading packages listed in ignore section, in /etc/pacman.conf. <br>


UPDATE Feb 13, 2019:
Eliminated separate package cache. Updated packages are downloaded to pacman package cache /var/cache/pacman/pkg/.
Use pacman -Syu to update.


UPDATE Nov 16, 2018:
Added a separate package cache to prevent potential issues between updates. Added "No updates available" capability.

