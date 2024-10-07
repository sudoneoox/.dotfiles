## Dual Boot Troubleshooting: Restoring Windows Boot Option

### Issue
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
