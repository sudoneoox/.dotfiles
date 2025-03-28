## Dual Boot Troubleshooting: Restoring Windows Boot Option

### Common Issue
After reinstalling Arch Linux on a system with Windows on a separate drive, the Windows boot option is no longer available in the boot menu. The Windows installation is still present on the other drive, but it's not recognized by the boot loader.

### Solution
To restore the Windows boot option, you need to rebuild the Boot Configuration Data (BCD) store using the bcdboot command in the Windows recovery environment.

Steps:
1. Boot into the Windows recovery environment:
2. Open Command Prompt:
  - Navigate to "Troubleshoot" > "Advanced options" > "Command Prompt"
3. Identify drive letters:
```bash
diskpart
list volume 
select volume x
assign letter=:C
exit
```
4. Run the bcdboot command:
```bash
bcdboot C:\Windows /s C: /f ALL
```
5. Restart computer the windows boot option should now be visible


## Brother Printer Issue USB

### ✅ How to Make Brother MFC-J805DW Work via USB on Arch (IPP-over-USB)

#### 1. Install Required Packages
```
sudo pacman -S ipp-usb avahi cups cups-filters
```

#### 2. Enable Required Services
```
sudo systemctl enable --now cups
sudo systemctl enable --now ipp-usb
sudo systemctl enable --now avahi-daemon
```

#### 3. Plug in the Printer via USB
- Do **not manually add** the printer in CUPS.
- Wait a few seconds — `ipp-usb` will expose the printer at `localhost:60000`.

#### 4. (Optional) Add the Printer Manually via IPP-over-USB
```
sudo lpadmin -p Brother_MFC -E -v ipp://localhost:60000/ipp/print -m everywhere
```

#### 5. Set as Default Printer
```
lpoptions -d Brother_MFC
```

#### ✅ Done!
- Now the printer works via **IPP-over-USB**, even when connected by USB.
- Confirm it's added at: [http://localhost:631/printers](http://localhost:631/printers)
- URI should be `ipp://localhost:60000/ipp/print`
