<h1 align="center">Active Directory Home Lab (VirtualBox)</h1>

<p align="center">
A beginner-friendly home lab that teaches the fundamentals of <b>Active Directory</b> by building a real Windows Server Domain Controller, configuring DNS + networking, creating users/OUs, and joining a Windows 10 client to the domain.
</p>

<p align="center">
  <a href="https://www.virtualbox.org/wiki/Downloads">VirtualBox</a> •
  <a href="https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019">Server 2019 ISO</a> •
  <a href="https://www.microsoft.com/en-us/software-download/windows10ISO">Windows 10 ISO</a>
</p>

---

## Table of Contents
- [What this lab is](#what-this-lab-is)
- [What you’ll learn](#what-youll-learn)
- [Tools & environments](#tools--environments)
- [Lab overview (plain English)](#lab-overview-plain-english)
- [Step-by-step walkthrough](#step-by-step-walkthrough)
  - [1) Downloads](#1-downloads)
  - [2) Create the Server VM](#2-create-the-server-vm)
  - [3) Configure networking (NAT + Internal)](#3-configure-networking-nat--internal)
  - [4) Install Windows Server 2019 (Desktop Experience)](#4-install-windows-server-2019-desktop-experience)
  - [5) Install VirtualBox Guest Additions](#5-install-virtualbox-guest-additions)
  - [6) Assign a static IP to the domain controller](#6-assign-a-static-ip-to-the-domain-controller)
  - [7) Install AD DS and promote to Domain Controller](#7-install-ad-ds-and-promote-to-domain-controller)
  - [8) Create OU + user and add to Domain Admins](#8-create-ou--user-and-add-to-domain-admins)
  - [9) Install and configure RRAS (NAT)](#9-install-and-configure-rras-nat)
- [Troubleshooting](#troubleshooting)
- [Roadmap / Next steps](#roadmap--next-steps)
- [Disclaimer](#disclaimer)

---

## What this lab is
This project is a **home lab** built in **Oracle VirtualBox** that simulates a real enterprise setup:

- A **Windows Server 2019** virtual machine becomes the **Domain Controller (DC)**
- The DC provides **Active Directory Domain Services (AD DS)** and **DNS**
- The DC has **two network adapters**:
  - **Adapter 1 (NAT)**: gives the server internet access
  - **Adapter 2 (Internal Network)**: creates a private lab network for domain traffic
- A **Windows 10** client VM will later be joined to the domain to validate authentication and connectivity

---

## What you’ll learn
Even if you’re not “tech savvy,” this lab teaches core IT concepts used in most corporate networks:

- What a **Domain Controller** is and why companies use it
- How **DNS** helps computers find services like a domain controller
- How to create **Organizational Units (OUs)** and **Users**
- How **domain authentication** works (logging in with domain accounts)
- Why labs often use **NAT + Internal networks** to safely isolate environments

---

## Tools & environments
### Languages / Utilities
- **PowerShell** (light usage; mostly Windows GUI steps)

### Environment
- **Windows Server 2019**
- **Windows 10 (21H2)**
- **Oracle VirtualBox**

---

## Lab overview 
You’re building a “mini company network” on your computer:

1. Create a Server VM
2. Install Windows Server
3. Give the Server a **static IP** on the internal network
4. Install **Active Directory Domain Services**
5. Promote the server to a Domain Controller (creates your domain)
6. Create users and admin accounts
7. Enable **RRAS/NAT** so internal clients can reach the internet if needed
8. (Next) Join a Windows 10 VM to the domain

---

# Step-by-step walkthrough

## 1) Downloads
- [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Windows Server 2019 ISO](https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019)
- [Windows 10 ISO](https://www.microsoft.com/en-us/software-download/windows10ISO)

---

## 2) Create the Server VM
Create a new VM for Windows Server 2019.

<img width="694" height="410" alt="Create VM" src="https://github.com/user-attachments/assets/02dc6406-0f3d-439f-83c2-a4766ead083c" />

---

## 3) Configure networking (NAT + Internal)
### VM hardware settings
> Tip: RAM and CPU can be increased based on your computer’s resources.

<img width="1051" height="751" alt="VM memory and CPU" src="https://github.com/user-attachments/assets/945a264b-9d3b-49b1-a37a-5988feb05474" />
<img width="581" height="382" alt="General VM settings" src="https://github.com/user-attachments/assets/521aab9a-2c92-44a0-940a-9a7c64d7d7b3" />
<img width="1156" height="765" alt="Additional VM settings" src="https://github.com/user-attachments/assets/5df47082-6441-4132-a086-efbc93f334b2" />

### VirtualBox Network adapters
- **Adapter 1:** NAT (internet access)
- **Adapter 2:** Internal Network (private lab network)

<img width="580" height="385" alt="Network VM" src="https://github.com/user-attachments/assets/057f8e73-2b1b-4483-898e-da66e59ecea3" />

---

## 4) Install Windows Server 2019 (Desktop Experience)
Start the VM:

<img width="560" height="548" alt="Start VM" src="https://github.com/user-attachments/assets/40e2d2fa-c9c5-47c8-a241-85d05a565172" />

Mount the Server 2019 ISO:

<img width="487" height="176" alt="Server 2019 ISO mount" src="https://github.com/user-attachments/assets/55ada9b3-b2b0-4268-82a1-4e9edc065bab" />

✅ **Important:** Select **Desktop Experience** (GUI).  
If you select the non-GUI option, you’ll get a command-line-only server.

<img width="1022" height="786" alt="Desktop Experience selection" src="https://github.com/user-attachments/assets/0325d003-0563-4f21-9cad-1280d4c39c96" />

Choose **Custom: Install Windows only (Advanced)**:

<img width="1026" height="790" alt="Custom install" src="https://github.com/user-attachments/assets/ef49be39-3718-4911-a2ef-0a1bed7cb58e" />

After the restart: **don’t press any keys**—let it boot to Windows.

<img width="1021" height="786" alt="Let it boot" src="https://github.com/user-attachments/assets/2a69c235-f5ac-46a0-844c-c9d596ed8b49" />

Set the local Administrator password:

<img width="1020" height="789" alt="Administrator password" src="https://github.com/user-attachments/assets/3df77c6c-b9a4-4a29-959b-088c9f488aa8" />

Send Ctrl+Alt+Del via VirtualBox:

<img width="1919" height="1124" alt="Ctrl+Alt+Del" src="https://github.com/user-attachments/assets/d8a3311c-f42f-4ad8-bb33-ba0599f0508b" />

Log in:

<img width="1019" height="789" alt="Log in" src="https://github.com/user-attachments/assets/f5db666b-24ef-4cb2-b58f-c7682c2c7756" />

---

## 5) Install VirtualBox Guest Additions
This improves screen resizing, mouse integration, and overall VM performance.

Devices → **Insert Guest Additions CD Image**:

<img width="1919" height="1129" alt="Guest Additions" src="https://github.com/user-attachments/assets/88059558-6653-4e41-8c4f-c4fb99fe20b9" />

Open **This PC → CD Drive (D) VirtualBox Guest Additions**:

<img width="1236" height="839" alt="Guest Additions drive" src="https://github.com/user-attachments/assets/c32938cb-3a77-41aa-b140-223086a26dae" />

Run the **amd64** installer, complete the setup, then **Reboot later**, shut down the VM, and start it again:

<img width="1241" height="845" alt="Guest Additions installer" src="https://github.com/user-attachments/assets/489541b6-4152-4e08-a3f0-8d4dac86394b" />

---

## 6) Assign a static IP to the domain controller
A domain controller should use a static internal IP so clients can always find it.

Open network settings and go to **Change adapter options**:

<img width="1752" height="938" alt="Network settings" src="https://github.com/user-attachments/assets/c2cc4ac3-c7a4-4857-b43f-166637528f7f" />
<img width="1022" height="799" alt="Change adapter options" src="https://github.com/user-attachments/assets/fd923f3f-a5f5-4937-9fed-b1f568576b8b" />

Rename adapters:
- Ethernet (NAT) → **Internet**
- Ethernet (Internal) → **X_Internal_X**

<img width="1408" height="801" alt="Rename adapters" src="https://github.com/user-attachments/assets/5b54cd63-a653-4e0f-b62e-17d5f7ab2ec2" />

Open properties for **X_Internal_X** and edit IPv4:

<img width="1710" height="841" alt="IPv4 properties" src="https://github.com/user-attachments/assets/dd653ce0-b48a-4bc7-9eda-9cd8ea5afa32" />

Example lab IP settings:
- IP: **172.16.0.1**
- Subnet: **255.255.255.0**
- DNS: **127.0.0.1** (loopback; points back to this server’s DNS service)

<img width="398" height="454" alt="Static IP example" src="https://github.com/user-attachments/assets/37809d0a-7473-456a-a21f-c77ff5bd9f3b" />

---

## 7) Install AD DS and promote to Domain Controller
Open **Server Manager** → **Add roles and features**:

<img width="1754" height="936" alt="Add roles and features" src="https://github.com/user-attachments/assets/a8cbcb22-b827-41d0-928e-51685e246b06" />

Select **Active Directory Domain Services**:

<img width="785" height="561" alt="Select AD DS" src="https://github.com/user-attachments/assets/612412ad-e43c-45bd-a3ab-03efe7f924d7" />

Install, then in Server Manager click the **flag** → **Promote this server to a domain controller**:

<img width="1755" height="938" alt="Promote to domain controller" src="https://github.com/user-attachments/assets/3146bbaf-e8cc-4afd-bf2d-5e8ea2e4799d" />

Choose **Add a new forest** and create a root domain name (example: `mydomain.com`):

<img width="759" height="562" alt="New forest" src="https://github.com/user-attachments/assets/82c83f66-286b-43b7-a4bc-87e2ebfc1198" />

Set the Directory Services Restore Mode (DSRM) password, continue, then install:

<img width="239" height="176" alt="DSRM password" src="https://github.com/user-attachments/assets/c0785af8-6ab1-45b4-b2ab-3f63bba88243" />

After the reboot/sign-out, your login will show:
`DOMAIN\Administrator` (use your original Administrator password)

<img width="1753" height="934" alt="Domain login" src="https://github.com/user-attachments/assets/df1238b8-9b2d-4987-9171-d5ff040faafd" />

---

## 8) Create OU + user and add to Domain Admins
Open **Active Directory Users and Computers**:

<img width="1283" height="685" alt="AD Users and Computers" src="https://github.com/user-attachments/assets/b7d17fde-7176-46c7-9248-6f9cc6a76cbb" />

Create an OU named `_ADMINS`:

<img width="1280" height="667" alt="Create OU" src="https://github.com/user-attachments/assets/f2f0583c-5371-478e-a7f4-0ca8bab9da06" />

Create a new user inside `_ADMINS`:

<img width="1283" height="661" alt="Create user" src="https://github.com/user-attachments/assets/16984a17-f4fb-4dfb-92b6-63f0d292f904" />

Naming idea for lab users:
- `a-firstinitiallastname` (example: `a-paraujo`)

<img width="317" height="272" alt="User logon name" src="https://github.com/user-attachments/assets/d9762078-9444-4877-b18d-51135a26d994" />

For lab simplicity:
- Uncheck **User must change password at next login**
- Check **Password never expires**

<img width="320" height="273" alt="Password options" src="https://github.com/user-attachments/assets/ffca9bc0-0795-4dc7-a9b4-119820be791e" />

Add the user to **Domain Admins**:
User Properties → **Member Of** → add `Domain Admins`

<img width="452" height="248" alt="Member Of domain admins" src="https://github.com/user-attachments/assets/2b681082-5252-4240-8028-f2069273a267" />

Sign out and log in with the new domain user:

<img width="473" height="498" alt="Sign out" src="https://github.com/user-attachments/assets/659d7b61-34b3-407f-8f48-0b28bb9fb186" />
<img width="1283" height="678" alt="Other user login" src="https://github.com/user-attachments/assets/8fed75bc-7388-4b02-9859-8fcbddd9113f" />

---

## 9) Install and configure RRAS (NAT)
RRAS helps internal clients route out to the internet (useful for updates/tools), while keeping the lab network isolated.

Server Manager → Add roles and features → select **Remote Access**:

<img width="922" height="688" alt="Remote access role" src="https://github.com/user-attachments/assets/5609071a-5e64-4be2-adca-005dd44e3e12" />

Under Role Services, select **Routing** (it may also check DirectAccess/VPN):

<img width="573" height="407" alt="Routing role service" src="https://github.com/user-attachments/assets/1185a5ed-28af-4921-938c-a089bc1d0477" />

Server Manager → Tools → **Routing and Remote Access**:

<img width="1284" height="665" alt="Routing and remote access tool" src="https://github.com/user-attachments/assets/7d8e7c24-9a1d-4d28-bf53-5d974ae0a1f3" />

Right-click your server → **Configure and Enable Routing and Remote Access**:

<img width="621" height="442" alt="Configure RRAS" src="https://github.com/user-attachments/assets/045d98b9-7c9f-4675-955a-a10f324da4a4" />

Install NAT to allow internal clients to connect to the Internet using one public IP address.

<img width="498" height="421" alt="Screenshot 2025-12-19 102022" src="https://github.com/user-attachments/assets/a350cfaa-c9c2-4223-9999-372c5a860d62" />

Click on Use this public Interface to connect to the internet: choose _INTERNET then click next  (If the box is grayed out, close the window and repeat the steps to get back on this page)

<img width="497" height="424" alt="Screenshot 2025-12-19 102525" src="https://github.com/user-attachments/assets/a4d14315-a328-4282-a2c4-d1ad9960cc08" />

After you click finish, you will see a green arrow on the created server. 
<img width="622" height="442" alt="Screenshot 2025-12-19 114933" src="https://github.com/user-attachments/assets/deb8847e-9deb-4f6b-88ef-66414bbf24ad" />
## 10) Installing a DHCP server 
With an DHCP, clients that connect to the internet will receive an IP address that would allow them to connect to the internet. 

On the server manager, click add roles and features. Click Next until you get to server roles then add DHCP then keep clicking next until the install button pops up. 


<img width="495" height="351" alt="Screenshot 2025-12-19 115720" src="https://github.com/user-attachments/assets/d5115306-cfa3-464a-b326-686dc86bf189" />

After the DHCP install is complete and you are back inside Server Manager, click Tools on the top right then click DHCP to create the Scope.
In DHCP, a scope is basically the range of IP addresses and network settings that a DHCP server is allowed to hand out to devices on a specific network (usually one subnet).

<img width="1754" height="933" alt="Screenshot 2025-12-19 120303" src="https://github.com/user-attachments/assets/c256d3a3-6203-495a-aac1-52c678172b53" />

Right Click on IPv4 and click New Scope. 

<img width="1150" height="769" alt="Screenshot 2025-12-19 120603" src="https://github.com/user-attachments/assets/7d058fb5-6fa6-41b8-b11c-8c3edfd7f2c8" />

For Lab purposes we'll create the scope name 172.16.0.100-200 but you can set name it whatever you want. 

<img width="516" height="420" alt="Screenshot 2025-12-19 120732" src="https://github.com/user-attachments/assets/3a37f06c-08f2-4554-bb41-91ac2d150ddd" />

Again for lab purposes we"ll set up the Start IP Address to 172.16.0.100. Set the End I.P Address to 172.16.0.200. Set lenght to 24 and Subnet mask to 255.255.255.0.

<img width="515" height="424" alt="Screenshot 2025-12-19 121039" src="https://github.com/user-attachments/assets/5750f39e-451d-4bc9-b1a9-579616ec0a2a" />

Keep clicking Next until you get to Lease Duration and you can set it for as long as you want. What lease duration means is that the DHCP will give you an IP address and that IP address will expire after that duration is finished. For example when you log in the wifi for example a cafe, the DHCP will give your device an IP address with a lease duration. So the Cafe doesn't run out of IP addresses, it will most likely have an IP address lease duration for a week and no one can have that same IP address until the lease expires. 

<img width="321" height="268" alt="Screenshot 2025-12-19 121650" src="https://github.com/user-attachments/assets/8e287eaf-04f5-485f-80b6-71003baf9e41" />

Keep clicking Next until you get to Router (Default Gateway). Type in 172.16.0.1 and make sure you click Add before clicking Next. Then keep clicking Next and Finish. Then right click the DHCP server and click authorize then right click it again and click Refresh. 

<img width="1051" height="549" alt="Screenshot 2025-12-19 122905" src="https://github.com/user-attachments/assets/844163e2-f1f4-4b3c-bdfa-470934d68813" />

## 10) Adding Clients to the Active Directory Domain

download this folder https://codeload.github.com/araujopedro0325-alt/ActiveDirectoryLab/zip/refs/heads/main


Open up Internet Explorer, Paste link and save the file to Desktop 

<br /> 

Click the Windows button then right click on Windows Powershell ISE and Run as Administrator 


<img width="1920" height="955" alt="VirtualBox_DC _01_01_2026_12_13_57" src="https://github.com/user-attachments/assets/5a115a8b-2ebd-44ee-89a0-2ccbe2176a0a" />

Once you are inside Powershel open the saved file and click on 1_CREATE_USERS 

<img width="630" height="342" alt="Screenshot 2025-12-20 165939" src="https://github.com/user-attachments/assets/52447245-3a49-4d36-ab46-45a8bf676834" />

Now to be able to Run all scripts we need to run and execution ( For Lab purposes only, we are going to bypass this security feature to run scripts in your powershell, it is not advisable to run scripts from Internet into your PC)
Write: Set-ExecutionPolicy Unrestricted 
Then click Yes to All

<img width="1920" height="955" alt="VirtualBox_DC _01_01_2026_12_27_56" src="https://github.com/user-attachments/assets/5b89ced6-f5cb-48c8-9ca7-b333940d41d8" /> 

Before Running the script, we need to go inside the folder where the script is at. Type cd for (change directory) then write  C:\Users\your username\Desktop\AD_PS-master. 
For instance, i'll type cd  C:\Users\a_paraujo\Desktop\AD_PS-master to open my script location. 

<img width="1920" height="955" alt="cd" src="https://github.com/user-attachments/assets/30d8e96d-9485-42fd-97d3-c535a1999b67" />

After you are inside the script location click the Play button to run then click Run once and it will begin creating the users to the domain. 

<img width="1920" height="955" alt="run script" src="https://github.com/user-attachments/assets/0be2f175-4301-4c11-9945-025e2724bbe0" />

Now when you open the active directory, you will notice that a _USERS folder has been opened with all the users we created in Powershell. 

<img width="1920" height="955" alt="Users" src="https://github.com/user-attachments/assets/0def1ed2-ca47-4a50-bf93-55b944b52141" />

## 11) Creating the Client VM 

 Go back to Oracle VIrtualBox Manager and Click New. Then Name it CLient 1, make sure OS is Microsoft Windows and that OS Version is Windows 10 (64 bit) and click Finish.

 
<img width="781" height="557" alt="Screenshot 2026-01-01 125500" src="https://github.com/user-attachments/assets/deba5a1d-071b-406e-8037-eb46ae61801a" />

Right click on Client 1 and change any system to preference then on Network change attached to Internal Network and press OK when finished. 

<img width="778" height="519" alt="Screenshot 2026-01-01 125637" src="https://github.com/user-attachments/assets/bbb87050-8dea-473a-8b42-204f5501d326" />

Run the Client 1 VM and when the boot windows opens up, click on the windows 10 iso. Remember that the Windows 10 ISO is different than the windows server 2019 ISO.

<img width="766" height="531" alt="Screenshot 2026-01-01 131128" src="https://github.com/user-attachments/assets/fb0b3a63-2414-492e-96e8-db691649315d" />

After it boots, click Next then Install. 

<img width="744" height="573" alt="Screenshot 2026-01-01 131351" src="https://github.com/user-attachments/assets/f65fd91d-e886-4d03-8e91-e25c0a28570a" />

Once It installs, click on I Dont have product key then install windows 10 Pro 

<img width="1025" height="785" alt="Screenshot 2026-01-01 131522" src="https://github.com/user-attachments/assets/ac3bfb28-68e7-4c48-ad84-759e25e1ac94" />

Accept Terms then click on Custom: Windows Install Only (advanced) then click Next to Install.

<img width="746" height="572" alt="Screenshot 2026-01-01 131707" src="https://github.com/user-attachments/assets/1dd3b005-6e45-4293-bb9b-0ecbd4ea5c4e" />

After it Installs, Click On wherever region you are in then 

---

## Troubleshooting
**1) I can’t find the domain controller from the client**
- Make sure the client VM is on the **Internal Network** (Adapter 2)
- Client DNS should point to the DC’s internal IP (example: `172.16.0.1`)

**2) No internet in the lab**
- Ensure Adapter 1 is **NAT**
- Ensure RRAS NAT is configured on the **Internet/NAT** interface

**3) Accidentally installed Server Core (no GUI)**
- Reinstall and choose **Desktop Experience**

---

## Roadmap / Next steps
To make this lab stand out even more, here are strong “resume-ready” additions:

- [ ] **Create the Windows 10 client VM** and join it to the domain
- [ ] Create additional OUs: `_WORKSTATIONS`, `_USERS`, `_SERVERS`
- [ ] Add **Group Policy (GPO)** examples:
  - Password policy
  - Disable Control Panel
  - Map a network drive
  - Deploy a desktop wallpaper
- [ ] Enable **DHCP** for the internal network
- [ ] Create a file share + permissions (NTFS + share permissions)
- [ ] Add a simple **PowerShell script** to bulk-create users from CSV
- [ ] Add a basic **network diagram** (even a simple image is fine)

---

## Disclaimer
This lab is for learning and testing in a controlled environment. Do not expose these VMs directly to the public internet.
