<h1>Active Directory Home Lab</h1>

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
Search For 2019 Server ISO then click on Mount and Retry Boot : <br/>
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
<br />
<br />
Right click on the new X_Internal_X and click on Properties. Then click on TCP/IPv4 to give it an IP Address.
<img width="1710" height="841" alt="Screenshot 2025-12-18 113640" src="https://github.com/user-attachments/assets/dd653ce0-b48a-4bc7-9eda-9cd8ea5afa32" />
<br /> 
<br /> 
For practice purposes, lets make the IP Address 172.16.0.1 The Subnet Mask to 255.255.255.0 And the DNS as loopback address of 127.0.0.1<br />
<img width="398" height="454" alt="Screenshot 2025-12-18 113908" src="https://github.com/user-attachments/assets/37809d0a-7473-456a-a21f-c77ff5bd9f3b" />
<br /> 
<br />
<h2 style="color:red;">Creating the Active Directory Domain Services</h2>
<br /> 
<br /> 
Open Server Manager and click on Roles and features
<img width="1754" height="936" alt="Screenshot 2025-12-18 143921" src="https://github.com/user-attachments/assets/a8cbcb22-b827-41d0-928e-51685e246b06" /> 
<br />
<br />
Keep clicking Next until you get to Select Server Roles. Then click on Active Directory Domain Services. 
<img width="785" height="561" alt="Screenshot 2025-12-18 144733" src="https://github.com/user-attachments/assets/612412ad-e43c-45bd-a3ab-03efe7f924d7" /> 
<br />
<br />
Keep clicking Next until you can click on the install button and Install the ACDS then close it once it is done installing.
<img width="783" height="559" alt="Screenshot 2025-12-18 145544" src="https://github.com/user-attachments/assets/1f20d14d-6c84-4fcf-b78c-e46877acdefc" />
<br />
<br />
On the top right of Server Manager. Click on the flag and click on "Promote this server to a domain controller" to create the Domain. <br /> 
<img width="1755" height="938" alt="Screenshot 2025-12-18 161933" src="https://github.com/user-attachments/assets/3146bbaf-e8cc-4afd-bf2d-5e8ea2e4799d" />
<br />
<br />
Click Add a new forest and create your root domain name. Example I"ll create mine to be mydomain.com Then click Next<br />
<img width="759" height="562" alt="Screenshot 2025-12-18 162611" src="https://github.com/user-attachments/assets/82c83f66-286b-43b7-a4bc-87e2ebfc1198" />
<br />
<br />
Create a password for your domain restore mode then keep clicking Next until the Install button pops up then click on it. 
<img width="239" height="176" alt="Screenshot 2025-12-18 163212" src="https://github.com/user-attachments/assets/c0785af8-6ab1-45b4-b2ab-3f63bba88243" />
<br />
<br />
It will sign you out to create the domain. When you log back in and your user name will change to the domain name you created/Administrator but still use original administrator password.
<img width="1753" height="934" alt="Screenshot 2025-12-18 164338" src="https://github.com/user-attachments/assets/df1238b8-9b2d-4987-9171-d5ff040faafd" />
<br />
<br />
Now that you are logged in, Click on the windows button at the bottom left and look for Active Directory Users and Computers.
<img width="1283" height="685" alt="Screenshot 2025-12-18 185648" src="https://github.com/user-attachments/assets/b7d17fde-7176-46c7-9248-6f9cc6a76cbb" />
<br />
<br />
Then right click on your domain and click "New" then click "Organizational Unit" then Name it _ADMINS and click Ok. 
<img width="1280" height="667" alt="Screenshot 2025-12-18 203956" src="https://github.com/user-attachments/assets/f2f0583c-5371-478e-a7f4-0ca8bab9da06" />
<br />
<br />
Right click on the new created Organizational Unit then click "New" then "User" <br />
<img width="1283" height="661" alt="Screenshot 2025-12-18 210452" src="https://github.com/user-attachments/assets/16984a17-f4fb-4dfb-92b6-63f0d292f904" />
<br />
<br />
Put in your First and Last name. For lab purposes, inside User logon name put a- then your first intial of your first name along with your last name. (For example, a-paraujo) then click Next <br />
<img width="317" height="272" alt="Screenshot 2025-12-18 210925" src="https://github.com/user-attachments/assets/d9762078-9444-4877-b18d-51135a26d994" />
<br />
<br />
Create a password for your new user account then Uncheck "User must change password at next login" box and check the "Password never expires" box. Then click Next until the Finish button pops up and click on it<br />
<img width="320" height="273" alt="Screenshot 2025-12-18 212400" src="https://github.com/user-attachments/assets/ffca9bc0-0795-4dc7-a9b4-119820be791e" />
<br />
<br />
Now to make the new created user an admin, Right click on the user name and choose Properties. Then look for the "Member Of" tab and Write " domain admins " inside of "enter the object names to select (examples). Then click Ok then "Apply" then Ok <br />
<img width="452" height="248" alt="Screenshot 2025-12-18 212648" src="https://github.com/user-attachments/assets/2b681082-5252-4240-8028-f2069273a267" />
<br />
<br />
Then click on the Windows button then at the User Icon and Sign Out <br />
<img width="473" height="498" alt="Screenshot 2025-12-18 220856" src="https://github.com/user-attachments/assets/659d7b61-34b3-407f-8f48-0b28bb9fb186" />
<br />
<br />
Now that you are back into the log in page, click on the botton left where it says Other User and put in your new user name and password. For example, my username would be a-paraujo<br />
<img width="1283" height="678" alt="Screenshot 2025-12-18 221255" src="https://github.com/user-attachments/assets/8fed75bc-7388-4b02-9859-8fcbddd9113f" />
<br />
<br />
<h2 style="color:red;">Installing RAS/NAS (Remote Access Network/Network Address Translation)</h2>
<br />
<br />
Open Up Server Manager and click on "Add roles and features" then click Next until you get to the Select server roles page. Then look for "Remote Access" and click on it then keep pressing Next Until you get to "Role Services" 
<img width="922" height="688" alt="Screenshot 2025-12-18 222454" src="https://github.com/user-attachments/assets/5609071a-5e64-4be2-adca-005dd44e3e12" />
<br />
<br />
Once you get to Role Services, click on Routing box and it will also check the DirectAcess and VPN(RAS) box then click next twice then install. 
<img width="573" height="407" alt="Screenshot 2025-12-18 223610" src="https://github.com/user-attachments/assets/1185a5ed-28af-4921-938c-a089bc1d0477" />
<br />
<br />
Once you are back in Server Manager, on the top right click tools then Routing and Remote Acess <br />
<img width="1284" height="665" alt="Screenshot 2025-12-18 230458" src="https://github.com/user-attachments/assets/7d8e7c24-9a1d-4d28-bf53-5d974ae0a1f3" />
<br />
<br />
Once you are inside Routing and Remote Access, right click on your server then click on Configurate and Enable Routing and Remote Access <br />
<img width="621" height="442" alt="Screenshot 2025-12-18 230925" src="https://github.com/user-attachments/assets/045d98b9-7c9f-4675-955a-a10f324da4a4" />
<br />
<br />
Once you are inside configuration

