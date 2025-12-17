<h1>Active Directory Home Lab</h1>

 ### [YouTube Demonstration](https://youtu.be/7eJexJVCqJo)

<h2>Description</h2>
VirtualBox-based AD DS lab featuring a Windows Server domain controller, DNS-based domain services, isolated virtual networking, user account management, and a Windows client VM domain join to validate authentication and connectivity.
<br />


<h2>Languages and Utilities Used</h2>

- <b>PowerShell</b> 

<h2>Environments Used </h2>

- <b>Windows 10</b> (21H2)
- <b>Server 2019</b>

<h2>Program walk-through:</h2>


### Downloads
- [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Windows Server 2019 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019)
- [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10ISO)


Create VM:  <br/>
<img width="694" height="410" alt="create VM" src="https://github.com/user-attachments/assets/02dc6406-0f3d-439f-83c2-a4766ead083c" />

>
<br />
<br />
Configurate VM Settings: For memory you can expand depending on your RAM and that will also go for your Processor(GPU) <br/>
<img width="1051" height="751" alt="Screenshot 2025-12-17 135041" src="https://github.com/user-attachments/assets/945a264b-9d3b-49b1-a37a-5988feb05474" />

<img width="581" height="382" alt="General VM settings " src="https://github.com/user-attachments/assets/521aab9a-2c92-44a0-940a-9a7c64d7d7b3" />

<img width="1156" height="765" alt="Screenshot 2025-12-17 135227" src="https://github.com/user-attachments/assets/5df47082-6441-4132-a086-efbc93f334b2" />
<br />
<br />
In Network, Keep Adapter 1 as NAT. Enable and change Adapter 2 to Internal then click OK: <br/>
<img width="580" height="385" alt="Network VM" src="https://github.com/user-attachments/assets/057f8e73-2b1b-4483-898e-da66e59ecea3" />
<br />
<br />
Start VM: <br/>
<img width="560" height="548" alt="Start VM" src="https://github.com/user-attachments/assets/40e2d2fa-c9c5-47c8-a241-85d05a565172" />
<br />
<br />
Search For 2019 Server ISO: <br/>
<img width="487" height="176" alt="Server 2019 ISO" src="https://github.com/user-attachments/assets/55ada9b3-b2b0-4268-82a1-4e9edc065bab" />
<br />
<br />
Click Next Then Install then on Windows Setup make sure you click start DeskTop Experience or you will be stuck in the cmd mode with no GUI: <br/> 
<img width="1022" height="786" alt="Screenshot 2025-12-17 144201" src="https://github.com/user-attachments/assets/0325d003-0563-4f21-9cad-1280d4c39c96" />
<br />
<br />
Click Next on Everything Until you get to this Window then click Custom: Install Windows Only(Advanced): <br/>
<img width="1026" height="790" alt="Screenshot 2025-12-17 144840" src="https://github.com/user-attachments/assets/ef49be39-3718-4911-a2ef-0a1bed7cb58e" />
<br />
<br />
Click Next then you will get to this window. WHEN THE MACHINE RESTARTS LET IT LOAD DONT CLICK ANYTHING AND IT WILL GO TO WINDOWS: <br/>
<img width="1021" height="786" alt="Screenshot 2025-12-17 145534" src="https://github.com/user-attachments/assets/2a69c235-f5ac-46a0-844c-c9d596ed8b49" />
<br />
<br />
Create an Administrator Password: <br/>
<img width="1020" height="789" alt="Screenshot 2025-12-17 150417" src="https://github.com/user-attachments/assets/3df77c6c-b9a4-4a29-959b-088c9f488aa8" />
<br />
<br />
On top click Input and search for Ctrl+Alt+Del: <br/>
<img width="1919" height="1124" alt="Screenshot 2025-12-17 150842" src="https://github.com/user-attachments/assets/d8a3311c-f42f-4ad8-bb33-ba0599f0508b" /> 
<br />
<br /> 
Then Log In with Administrator Password you created earlier: <br/>
<img width="1019" height="789" alt="Screenshot 2025-12-17 151343" src="https://github.com/user-attachments/assets/f5db666b-24ef-4cb2-b58f-c7682c2c7756" />
<br />
<br />
After it logs you in, to enhance VM expererience, On top click Devices then click Insert Guess Additions CD Image..: <br/>
<img width="1919" height="1129" alt="Screenshot 2025-12-17 151823" src="https://github.com/user-attachments/assets/88059558-6653-4e41-8c4f-c4fb99fe20b9" />
<br />
<br /> 
Then Click on File Explorer on the botton then Click This PC then click on CD Drive (D)VirtualBox Guest Additions :
<img width="1236" height="839" alt="Screenshot 2025-12-17 152250" src="https://github.com/user-attachments/assets/c32938cb-3a77-41aa-b140-223086a26dae" />
<br />
<br /> 
When CD Drive (D)VirtualBox Guest Additions opens click on the amd 64 version then click Next and Install it. When it fisnishes installing make sure you put REBOOT LATER then shut down the VM and Start it up Again:<br/> 
<img width="1241" height="845" alt="Screenshot 2025-12-17 152358" src="https://github.com/user-attachments/assets/489541b6-4152-4e08-a3f0-8d4dac86394b" />
<br/>
<h2 style="color:red;">Give Domain an IP Address</h2>
<br/>
<br/>
Log in back to your VM then on the bottom right click the internet icon and double click on Network: 
<img width="1752" height="938" alt="Screenshot 2025-12-17 154335" src="https://github.com/user-attachments/assets/c2cc4ac3-c7a4-4857-b43f-166637528f7f" />
<br/>
<br/> 
Click on ethernet then click on Change adapters option
<img width="1022" height="799" alt="Screenshot 2025-12-17 155147" src="https://github.com/user-attachments/assets/fd923f3f-a5f5-4937-9fed-b1f568576b8b" />
<br/> 
<br/>
Change Ethernet 1 to Internet then change Ethernet 2 to X_Internal_X. 
<img width="1408" height="801" alt="Screenshot 2025-12-17 155111" src="https://github.com/user-attachments/assets/5b54cd63-a653-4e0f-b62e-17d5f7ab2ec2" />
: <br/>
<br />
Confirm your selection:  <br/>
<img src="https://i.imgur.com/cdFHBiU.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Wait for process to complete (may take some time):  <br/>
<img src="https://i.imgur.com/JL945Ga.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Sanitization complete:  <br/>
<img src="https://i.imgur.com/K71yaM2.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
<br />
<br />
Observe the wiped disk:  <br/>
<img src="https://i.imgur.com/AeZkvFQ.png" height="80%" width="80%" alt="Disk Sanitization Steps"/>
</p>

<!--
 ```diff
- text in red
+ text in green
! text in orange
# text in gray
@@ text in purple (and bold)@@
```
--!>
