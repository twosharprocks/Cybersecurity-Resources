# Electronic Attacks
## BadUSB

[Broad overview of malicious USB attacks](https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/)
* General [https://www.gdatasoftware.com/blog/2021/11/usb-drives-still-a-danger](https://www.gdatasoftware.com/blog/2021/11/usb-drives-still-a-danger)
* USB Attack Vectors [https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/](https://elie.net/blog/security/what-are-malicious-usb-keys-and-how-to-create-a-realistic-one/)
* [USBvalve - Raspberry Pico device checks USBs for malicious filesystem activity](https://github.com/cecio/USBvalve)

### Payloads
* [Hak5 Payload Library](https://github.com/hak5/usbrubberducky-payloads)
* [Rubber Ducky Use](https://blog.teamascend.com/rubber-ducky)
* [Ducky Reverse-Shell](https://github.com/TeaPixl/Pico-NetCat-Reverse-Shell)
* [3-Second Reverse Shell](https://shop.hak5.org/blogs/usb-rubber-ducky/the-3-second-reverse-shell-with-a-usb-rubber-ducky)

### Converted USBs
* [USB Firmware Resource](https://www.usbdev.ru/files/#gsc.tab=0)
* [Phison 2251-03 microcontroller USBs](https://hackmag.com/security/rubber-ducky/)
* [GitHub - Creating a ducky with Phison 2251-03](https://github.com/brandonlw/Psychson)
* [Phison 2251-03 to Ducky walkthrough](https://null-byte.wonderhowto.com/how-to/make-your-own-bad-usb-0165419/) 
* [Alternate microprocessor BadUSB](https://github.com/krakrukra/PocketAdmin)

### HID USBs
* [Hak5 Rubber Ducky](https://shop.hak5.org/products/usb-rubber-ducky) 
    * [Modify the USB Rubber Ducky with Custom Firmware](https://null-byte.wonderhowto.com/how-to/modify-usb-rubber-ducky-with-custom-firmware-0177335/)
* [Pwnie Cactus](https://pwnieexpres.com/en-au/products/cactus-whid-wifi-hid-injector-an-usb-rubberducky) - HID Injector, Key Logger & WiFi
* [Cactus WHiD - Cheap from China](https://www.tindie.com/products/aprbrother/cactus-whid-wifi-hid-injector-usb-rubberducky/)
* [Hak5 O.MG Plug](https://hak5.org/collections/omg-row2/products/omg-plug) - Standard cable with HID Injector, Wifi & Key Logger
    * [Verge Article on O.MG cable](https://www.theverge.com/23321517/omg-elite-cable-hacker-tool-review-defcon) 

### Disguised Microprocessor USB's
* Bash Bunny - [Buy](https://shop.hak5.org/products/bash-bunny) & [Official Documentation [Huge resource]](https://docs.hak5.org/bash-bunny/)
   * [Cron.dk - Poor Man’s Bash Bunny](https://www.cron.dk/poor-mans-bash-bunny/)
* Pi Zero based (similar to BashBunny) 
   * [P4wnP1 - Official Wiki [Huge resource]](https://p4wnp1.readthedocs.io/en/latest/) & [P4wnP1 - Full build and setup ](https://gideonwolfe.com/posts/security/p4wnp1/)
   * [P4wnP1-Bilby](https://wjmccann.github.io/blog/2017/11/09/Introducing-the-P4wnP1-Bilby) [Australian P4wnp1 variant]
   * [P4wnP1_aloa](https://github.com/RoganDawes/P4wnP1_aloa) [Updated version of P4wnp1]
   * [P4wnP1 to attack routers](https://github.com/tenable/router_badusb/blob/master/README.md)
   * [BadPI - Pi Zero W](https://www-users.york.ac.uk/~mjf5/bad_pi/index.html)
   * [Raspberry Pi Zero Wifi Hacking Tool](https://thesmashy.medium.com/raspberry-pi-zero-w-wifi-hacking-gadget-63e3fa1c3c8d)
   * [Pico-Ducky - Pico based Ducky](https://github.com/dbisu/pico-ducky)
   * [Pico to Ducky](https://github.com/OCEANOFANYTHINGOFFICIAL/RPI-PICO-TO-BAD-USB-CONVERTER)
   * [PoisonTap - Raspberry Pi-based C2 Agent for WiFi & Unencrypted Data](https://www.dailydot.com/debug/poisontap-hacking-tool/)

Arduino
* [ATMEGA32U4 Leonardo BadUSB](https://github.com/asciiterminal/CJMCU_ATMEGA32U4_BADUSB)
   * Upload [Duckduino-MicroSD.ino](https://www.arduino.cc/en/software) sketch to Leonardo via [Ardunio IDE](https://www.arduino.cc/en/software)
      * Upload issues? Click reset button on Leonardo **after** starting sketch upload
   * Use microSD card reader to copy Ducky payloads into "script.txt" on microSD card (not the Leonardo itself)
   * [OverThruster - HID Attack Sketch Generator (Python) for ATMEGA32U4](https://github.com/RedLectroid/OverThruster)}

Hardware
* [Buy Raspberry Pi Zero ](https://core-electronics.com.au/raspberry-pi-pico.html)
* [Banana Pi BPI M2 Zero - AliExpress](https://www.aliexpress.com/item/32839074880.html) (Pi Zero Alternative)
* [Buy Raspberry Pi Pico](https://raspberry.piaustralia.com.au/products/raspberry-pi-pico-w?src=raspberrypi)
* [Buy Raspberry Pi Pico wireless](https://core-electronics.com.au/raspberry-pi-pico-w-wireless-wifi.html)

### USB Port Killers
* [Buy USB Killer](https://usbkill.com/) 
* [General Overview of USB Killers](https://www.darkreading.com/endpoint/rule-of-thumb-usb-killers-pose-real-threat)

## Other Devices
* Raspberry Pi
   * [Make a Hacking machine with Raspberry pi ](https://maker.pro/raspberry-pi/projects/hacking-machine-with-raspberry-pi)
   * [Hacking Kit with Raspberry Pi - SSH Instructions](https://gbhackers.com/raspberry-pi-and-kali-linux/)
   * [Beginner Hacking Kit with the Raspberry Pi 3 - Many Ideas](https://null-byte.wonderhowto.com/how-to/build-beginner-hacking-kit-with-raspberry-pi-3-model-b-0184144/)
   * [SwissArmyPi Converts your Raspberry Pi into a Strong Hacking Tool](https://medevel.com/swissarmypi/)
   * [Rogue AP with the Raspberry Pi Zero W](https://jerryryle.github.io/rogue_ap/)
   * [Damn Vulnerable Raspberry Pi](https://whitedome.com.au/re4son/sticky-fingers-dv-pi/)
* [Flipper Zero](https://flipperzero.one/) - Penetration multi-tool
    * Sub 1GHz for wireless access control (garage door, booms, remote keys)
    * 125kHz RFID Reader/Emulator
    * NFC Reader/Emulator
    * Bluetooth
    * BadUSB/RubberDucky
    * Infrared Transceiver & Learning
    * 1-wire Contact key
* [WiPhone](https://www.wiphone.io/) - Open source WiFi phone
