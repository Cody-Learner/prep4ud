#!/bin/bash
# prep4ud 2024-10-07
# attribute Lastud awk code:  Trilby https://bbs.archlinux.org/viewtopic.php?pid=1775384#p1775384
# shellcheck disable=SC2004,SC2024,SC2129

Date=$(date '+%Y-%m-%d')
Uzr=$(getent passwd 1000 | awk -F':' '{print $1}')								# Set <user>      to send report
Destdir="/home/${Uzr}/Desktop/prep4ud.dir"									# Set Destdir <directory>
Sendto="/home/${Uzr}/Desktop/prep4ud.dir/prep4ud-${Date}"							# Set <file> to send report
Lastrb=$(uptime -p | awk '{$1=""; print}')									# Last reboot
Count=$(find /home/"${Uzr}"/Desktop/prep4ud.dir/* -maxdepth 0 -type f  2>/dev/null | wc -l)			# Count reports in <directory>
tmpDir=$(mktemp -d)												# Create /tmp/<directory> for files
tmpDB=$(mktemp -d)												# Create /tmp/<directory> for DB's
#=============================================================================================#
Lastud=$(awk -F'[][ :-]' ' /upgrade$/ {gsub (/T/, " ") ; last = mktime($2 " " $3 " " $4 " " $5 " " $6 " 00")} 	# Added:   gsub (/T/, " ") ;
	END	{	s = systime() - last;									# for pacman.log date format change
			d = int(s / 86400);
			h = int((s - d * 86400) / 3600)
			m = int((s - d * 86400 - h * 3600) / 60)
			printf "%d days, %d hours, %d minutes ago\n", d, h, m
		}     ' /var/log/pacman.log)
#=============================================================================================#

	sudo chmod +x "${tmpDir}"
	sudo chmod +x "${tmpDB}"

	[[ ! -d ${Destdir} ]] && mkdir -p "${Destdir}"								# Check/create Destdir

if	(($Count >= 5)) ; then
	rm "$(find /home/"${Uzr}"/Desktop/prep4ud.dir/* -maxdepth 0 -type f | sort | head -n -4 | xargs)"	# Maintain 5 reports in <directory>
fi
	trap 'sudo rm -rd --interactive=never "${tmpDir}" "${tmpDB}"' INT TERM EXIT				# Clean up
	cp -r /var/lib/pacman/* "${tmpDB}"									# Copy pacman DB to "${tmpDB}"
	sudo pacman -Syy --color=never --dbpath "${tmpDB}" 2> "${tmpDir}"/pacSyy				# Update pacman DB in "${tmpDB}"
														# Redirect pacman errors to report

	readarray -t updates < <(pacman -Qu --dbpath "${tmpDB}" |& tee -a 2>"${Sendto}" | tee >(grep '\[*\]' > "${tmpDir}"/ignored) | grep -v '\[*\]' )

if	[[ -n "${updates[*]}" ]] ; then										# Above: Create updateable pkg array
														# Redirect pacman errors to report

	if	! sudo pacman -Spw --needed --noconfirm --dbpath "${tmpDB}" "${updates[@]%% *}" &> "${tmpDir}"/pacSpw ; then
		grep -E 'WARNING:|warning:|error:|:: Replace' "${tmpDir}"/pacSpw >> "${Sendto}"
	fi													# Above:
														# Print list, "file:" & "https:" pkgs
														# Send pacman errors to report

	if	! sudo pacman -Sw  --needed --noconfirm --dbpath "${tmpDB}" "${updates[@]%% *}" |& tee "${tmpDir}"/pacSw ; then
		grep -E 'WARNING:|warning:|error:|:: Replace' "${tmpDir}"/pacSw >> "${Sendto}"
	fi													# Above: 
														# Download updates w/o installing
														# Send pacman errors to report

	echo "Prep4ud report : $(date '+%b %d %Y %I:%M %p')"				>> "${Sendto}"		# Everything below here is for
	echo "Last update    : ${Lastud}"						>> "${Sendto}"		# printing reports and
	echo "Last reboot    :${Lastrb} ago"						>> "${Sendto}"		# changing report permissions
	grep -E 'WARNING:|warning:|error:|:: Replace' "${tmpDir}"/pacSyy 		>> "${Sendto}"
	echo										>> "${Sendto}"
	echo "Updates available:"							>> "${Sendto}"
	printf "%s\n" "${updates[@]}" | nl | column -t					>> "${Sendto}"
	echo										>> "${Sendto}"
	echo "Updates available, not downloaded:"					>> "${Sendto}"
	awk '{print "--  "$0}' "${tmpDir}"/ignored | column -t				>> "${Sendto}"
	echo										>> "${Sendto}"
	echo "Updates available locally:"						>> "${Sendto}"
	awk -F '/' '/file:/ {print $8}' "${tmpDir}"/pacSpw |sort|nl -n'ln' -s' ' -w3	>> "${Sendto}"
	echo										>> "${Sendto}"
	echo "Downloaded packages:"							>> "${Sendto}"
	awk '/downloading/ {print $1" "$2}' "${tmpDir}"/pacSw |sort|nl -n'ln' -s' ' -w3	>> "${Sendto}"
	chown "$Uzr" "${Sendto}"
    else
	echo "Last update  : ${Lastud}"		 				|& tee -a "${Sendto}"
	echo "Last reboot  :${Lastrb} ago"					|& tee -a "${Sendto}"
	grep -E 'WARNING:|warning:|error:|:: Replace' "${tmpDir}"/pacSyy 	|& tee -a "${Sendto}"
	echo "No updates available  $(date '+%b %d %Y')"			|& tee -a "${Sendto}"
	chown "$Uzr" "${Sendto}"
	exit
fi
