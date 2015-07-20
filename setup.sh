#!/bin/bash
# camToggle Indicator - indicator applet for enabling/disabling the webcam
# Copyright (C) 2015 Deepak Srivastav
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

if [[ $EUID -ne 0 ]]; then
	echo "This script must be run using sudo" 2>&1
	exit 1
else
	mkdir -p /usr/lib/camToggle
	cp camToggle-indicator /usr/bin/
	chown root:root /usr/bin/camToggle-indicator
	chmod 755 /usr/bin/camToggle-indicator
	cp camon /usr/lib/camToggle/
	cp camoff /usr/lib/camToggle/
	cp camon.png /usr/lib/camToggle/
	cp camoff.png /usr/lib/camToggle/
	chmod a+r /usr/lib/camToggle/*.png
	chown root:root /usr/lib/camToggle/camon
	chown root:root /usr/lib/camToggle/camoff
	chmod a+x /usr/lib/camToggle/camon
	chmod a+x /usr/lib/camToggle/camoff
	cp camToggle-indicator-sudoers /etc/sudoers.d/
	chmod 644 /etc/sudoers.d/camToggle-indicator-sudoers

	read -n1 -p "Autostart camToggle Indicator? (y/N) "
	echo $USER
	if [[ $REPLY == [yY] ]]; then
		mkdir -p $HOME/.config/autostart
		cp camToggle-indicator.desktop $HOME/.config/autostart
        chown $SUDO_USER:$SUDO_USER $HOME/.config/autostart
        chown $SUDO_USER:$SUDO_USER $HOME/.config/autostart/camToggle-indicator.desktop
	else
		rm -f $HOME/.config/autostart/camToggle-indicator.desktop
	fi
fi
