# WSL Launcher
# The VMLinux file at ~ is a custom kernel that enables the MON Capture Card.
# It is compiled from WSL, using the tutorial described in HP/NET/WIFU
# To enable SL mode in Kali desktop, add this rule https://x410.dev/cookbook/wsl/protecting-x410-public-access-for-wsl2-via-windows-defender-firewall/
# And also add the following executable to the firewall exceptions on all TCP and UDP ports.
# \\wsl$\kali-linux\usr\lib\win-kex\VcXsrv\vcxsrv.exe
# with edge traversal set to defer to user.
#
# Finally, to avoid the terrible desktop background on kali, kill xfce-desktop from the Task Manager, or simply call
# pkill xfdesktop
# from your .zshrc
#
# Parse command-line flags
if ($args[0] -eq "--wireless") {
  wsl -- echo "Enabling usbpid device..."
  usbipd wsl attach --busid=2-7

  wsl bash -c "
    echo 'Enabling drivers...';
    sudo modprobe cfg80211 && sudo modprobe 88XXau;

    echo 'Setting interface to monitor mode...';
    sudo airmon-ng start wlan0;
    echo 'SUCCESS' && clear;
    exec zsh;
  "
} elseif ($args[0] -eq "--desktop") {
  # Code for --desktop flag
  # Run the server
  # NO LONGER NEEDED SINCE WE'VE ADDED THE FW RULE
  # & "$env:ProgramFiles/VcXsrv/vcxsrv.exe" -ac -multiwindow -clipboard;
  # if ($?) {
    wsl -d kali-linux kex --sl --wtstart -s
  # }
  exit;
} else {
  # Handle invalid flags or missing arguments
  Write-Host "Invalid flag or missing argument. Please use either --wireless or --desktop."
  exit;
}
