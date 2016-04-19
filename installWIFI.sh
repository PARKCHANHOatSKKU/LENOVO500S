#!/bin/bash

clear
echo ""
echo "                      ***//*                      "
sleep 0.05
echo "                    //////*//*                    "
sleep 0.05
echo "                  *////////////                   "
sleep 0.05
echo "      /*          **/////* ////*          //      "
sleep 0.05
echo "    *//           /***//   /////          *//*    "
sleep 0.05
echo "   ///           /*    *////////           *///   "
sleep 0.05
echo "  ///*/          *         /////*           *///  "
sleep 0.05
echo " *////// *//// **          /////*           *//// "
sleep 0.05
echo "  /*///*/*/////*   **//***///*////**///*    /////*"
sleep 0.05
echo "   /*/////*////**/*/////////////////////** /*/////"
sleep 0.05
echo ""
sleep 0.05
echo "+ -- -- -- -- -- --=[ TEAM SAVE's LENOVO500S v0.1 ]"
echo ""


sleep 0.1
# LENOVO WIFI SOLUTION for IDEAPAD 500S 
echo -n "Check user ... "
if [ $EUID = 0 ];
then
	echo "";
	echo "  You are root. Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
else
	echo "[ok]"
fi

sleep 0.1

dpkg -L git >/dev/null 2>&1
if [ $(echo $?) -eq 0 ];
then
	echo [ok]
else
	echo ""
	echo "  You have to install git."
	echo -n "  Do you want to continue? [y/n] "
	read ANSWER
	case $ANSWER in
		y|Y)
			sudo apt-get install git
			if [ $? -ne 0 ];
			then
				echo "  Abort."
				exit 1
			fi
			;;
		*)
			echo "  Abort."
			exit 1;;
	esac
fi



# Reference is http://ubuntuforums.org/showthread.php?t=2304250

echo -n "install the wifi module... "
sudo apt-get update

echo ""
echo "  You have to install linux-headers-generic and  build-essential"
echo -n "  Do you want to continue? [y/n] "
read ANSWER
case $ANSWER in
	y|Y)
		sudo apt-get install linux-headers-generic build-essential
		if [ $? -ne 0 ];
		then
			echo "  Abort."
			exit 1
		fi
		;;
	*)
		echo "  Abort."
		exit 1;;
esac

# GANJI
sleep 0.1
# GANJI

echo ""
echo " Now Download Kernel file... "
echo -n "  Do you want to continue? [y/n] "
read ANSWER
case $ANSWER in
	y|Y)
		wget https://www.kernel.org/pub/linux/kernel/projects/backports/2015/11/20/backports-20151120.tar.gz
		tar -zxvf backports-20151120.tar.gz
		cd backports-20151120
		if [ $? -ne 0 ];
		then
			echo "  Abort."
			exit 1
		fi
		;;
	*)
		echo "  Abort."
		exit 1;;
esac

# GANJI
sleep 0.1
# GANJI

echo ""
echo " Make and install the Kernel file... "
echo -n "  Do you want to continue? [y/n] "
read ANSWER
case $ANSWER in
	y|Y)
		make defconfig-ath10k
		make
		sudo make install
		if [ $? -ne 0 ];
		then
			echo "  Abort."
			exit 1
		fi
		;;
	*)
		echo "  Abort."
		exit 1;;
esac

# GANJI
sleep 0.1
# GANJI

echo ""
echo " install the WIFI DRIVER"
echo -n "  Do you want to continue? [y/n] "
read ANSWER
case $ANSWER in
	y|Y)
		sudo mkdir /lib/firmware/ath10k/QCA9377/
		sudo mkdir /lib/firmware/ath10k/QCA9377/hw1.0
		sudo mkdir /lib/firmware/ath10k/QCA9377/hw1.1
		git clone https://github.com/kvalo/ath10k-firmware.git
		cd ath10k-firmware/QCA9377/hw1.0
		sudo cp board.bin /lib/firmware/ath10k/QCA9377/hw1.0
		sudo cp firmware-5.bin_WLAN.TF.1.0-00267-1 /lib/firmware/ath10k/QCA9377/hw1.0/firmware-5.bin
		sudo modprobe -r ath10k_pci
		sudo modprobe ath10k_pci
		sudo mkdir /lib/firmware/ath10k/QCA9377/hw1.1
		sudo cp /lib/firmware/ath10k/QCA9377/hw1.0/* /lib/firmware/ath10k/QCA9377/hw1.1
		if [ $? -ne 0 ];
		then
			echo "  Abort."
			exit 1
		fi
		;;
	*)
		echo "  Abort."
		exit 1;;
esac

# GANJI
sleep 0.1
# GANJI


echo ""
echo " install TEST FILE"
echo -n "  Do you want to continue? [y/n] "
read ANSWER
case $ANSWER in
	y|Y)
		sudo apt-get install mesa-utils
		glxgears
		if [ $? -ne 0 ];
		then
			echo "  Abort."
			exit 1
		fi
		;;
	*)
		echo "  Abort."
		exit 1;;
esac

echo "please change the settign INTEL<->NVIDIA"

nvidia-settings

echo " please reboot the Linux..."
echo " you need to compare the FPS between NVIDIA and INTEL"
echo " you can check FPS by thping "glxgears" on a terminal"
echo " SAVE TEAM"
echo ""
