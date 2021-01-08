# inhibit-standby
A script to inhibit power-saving whilst the system is under load.

This script uses xdotool to move your mouse for 100px and back immediately when your system is under load.
My intention was that my gentoo box would hibernate during lengthy compile jobs (firefox, libreoffice) if there was no user input.
Even if you are present and the script is moving your mouse, it should not interfere with everyday tasks should you forget to stop it.
As the mouse cursor is moved 100px away and immediately back, it does at least not disturb browsing the web.

The action to take can be easily changed, e.g. if you have no GUI and no mouse to move - just let it simulate a keypress.

Once the system load drops below a configurable threshold, the input (user) simulation stops and the system is able to go to sleep.
It does output the date and time everytime it places an action (delay configurable) so you can see at which time it stopped the simulation.
