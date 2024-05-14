# JankPack
A DIY streamer backpack based on an SBC running DietPi.  
Designed to have low parts complexity.

## Components
- Rasbperry Pi 4 (2GB is enough)
- GoPro Hero 8

## Usage
Connect 

## Installation
1. [Download DietPi](https://dietpi.com/downloads/images/DietPi_RPi-ARMv8-Bookworm.img.xz) for the RPi.
2. Flash image onto SD card.
3. Execute `generate-key.sh`.
4. If needed, further edit `dietpi.txt` and copy to `/boot/dietpi.txt`.
5. Boot SBC, wait until SSH is ready.
6. Run ansible playbook.
   ```bash
   # Adjust if changed in dietpi.txt
   USERNAME=dietpi
   RPI_IP=10.0.1.20

   docker run --rm -v "$(pwd):/ansible" cytopia/ansible:latest ansible-playbook -i $RPI_IP, -u $USERNAME --private-key=/ansible/ansible_key /ansible/playbook.yaml
   ```

7. Connect GoPro 8 with device, it should enter webcam mode.
8. Connect to device with VNC for further setup.