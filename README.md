# JankPack
A janky, hence the name, basis for a portable streaming solution based on an Raspberry Pi 4 running DietPi.  
Designed with low parts complexity in mind.

Out of the box it simply allows the use of a GoPro in webcam mode as a video device.  
Configuration/installation of other software needs to be done by the user.

![image](https://github.com/ThisIsntTheWay/jank-pack/assets/13659371/b5938bf8-1000-47ab-8742-8ee458a638b7)

## Components
- Raspberry Pi 4 (2GB is enough)
- GoPro Hero 8

> [!NOTE]  
> The JankPack has only been tested with the GoPro 8!

## Usage
Connect GoPro per USB with the SBC.  
Afterwards, connect to the system with VNC and do your thing.

> [!WARNING]  
> The OS likes to take its time to start services.  
> Neither VNC nor GoPros webcam mode will be immediately available.

## Installation
1. [Download DietPi](https://dietpi.com/downloads/images/DietPi_RPi-ARMv8-Bookworm.img.xz) for the RPi.
2. Flash image onto SD card.
3. If needed, edit `dietpi_template.txt` and execute `generate-key.sh`.
4. Copy the now generated `dietpi.txt` to your SDs `/boot/dietpi.txt`.
5. Boot SBC, wait until initial setup is complete.
   - Once finished, the system will reboot.
   - The system will execute `install-script.sh` after initial setup.
     With its default settings, the script will be downloaded off this repository.  
     To execute it locally instead, copy the script to `/boot/Automation_Custom_Script.sh` and set `AUTO_SETUP_CUSTOM_SCRIPT_EXEC=0`.
7. Connect GoPro 8 with device, it should enter webcam mode.
8. Connect to device with VNC/SSH for further setup.
   - Connect to VNC session at index 1: `<IP-of-pi>:1`

As an alternative to the installation script, an ansible playbook is provided:
```bash
# Adjust if changed in dietpi.txt
USERNAME=dietpi
RPI_IP=10.0.1.50

docker run --rm -v "$(pwd):/ansible" pad92/ansible-alpine:9.1.0 ansible-playbook -i "$RPI_IP," -u $USERNAME --private-key=/ansible/ansible_key /ansible/playbook.yaml
```
