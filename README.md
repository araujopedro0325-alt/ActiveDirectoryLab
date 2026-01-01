<h1 align="center">Active Directory Home Lab (VirtualBox)</h1>

<p align="center">
A beginner-friendly home lab that teaches the fundamentals of <b>Active Directory</b> by building a real Windows Server Domain Controller, configuring DNS + routing, deploying DHCP, creating users/OUs with PowerShell, and joining a Windows 10 client to the domain.
</p>

<p align="center">
  <a href="https://www.virtualbox.org/wiki/Downloads">VirtualBox</a> •
  <a href="https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019">Server 2019 ISO</a> •
  <a href="https://www.microsoft.com/en-us/software-download/windows10ISO">Windows 10 ISO</a>
</p>

<p align="center">
  <a href="https://github.com/araujopedro0325-alt/ActiveDirectoryLab/archive/refs/heads/main.zip"><b>⬇️ Download Repo (ZIP)</b></a>
  &nbsp;•&nbsp;
  <a href="https://codeload.github.com/araujopedro0325-alt/ActiveDirectoryLab/zip/refs/heads/main"><b>⬇️ Direct Download (Codeload)</b></a>
</p>

---

## Table of Contents
- [What this lab is](#what-this-lab-is)
- [What you’ll learn](#what-youll-learn)
- [Tools & environments](#tools--environments)
- [Lab overview](#lab-overview)
- [Network layout (simple diagram)](#network-layout-simple-diagram)
- [Step-by-step walkthrough](#step-by-step-walkthrough)
  - [1) Downloads](#1-downloads)
  - [2) Create the Server VM](#2-create-the-server-vm)
  - [3) Configure networking (NAT + Internal)](#3-configure-networking-nat--internal)
  - [4) Install Windows Server 2019 (Desktop Experience)](#4-install-windows-server-2019-desktop-experience)
  - [5) Install VirtualBox Guest Additions](#5-install-virtualbox-guest-additions)
  - [6) Assign a static IP to the Domain Controller](#6-assign-a-static-ip-to-the-domain-controller)
  - [7) Install AD DS and promote to Domain Controller](#7-install-ad-ds-and-promote-to-domain-controller)
  - [8) Create OU and user, then add to Domain Admins](#step-8)
  - [9) Configure RRAS (NAT)](#9-configure-rras-nat)
  - [10) Install DHCP + Create a Scope](#10-install-dhcp--create-a-scope)
  - [11) Create bulk users with PowerShell](#11-create-bulk-users-with-powershell)
  - [12) Create the Windows 10 Client VM](#12-create-the-windows-10-client-vm)
  - [13) Join the Client to the Domain](#13-join-the-client-to-the-domain)
- [Scripts (click to view)](#scripts-click-to-view)
- [Project structure](#project-structure)
- [Troubleshooting](#troubleshooting)
- [Roadmap / Next steps](#roadmap--next-steps)
- [Disclaimer](#disclaimer)

---

## What this lab is
This project simulates a real business network using VirtualBox:

- A **Windows Server 2019** VM becomes the **Domain Controller (DC)**
- The DC provides **Active Directory Domain Services (AD DS)** and **DNS**
- The DC uses **two network adapters**:
  - **Adapter 1 (NAT)**: internet access for the server
  - **Adapter 2 (Internal Network)**: isolated lab network for domain traffic
- A **Windows 10** VM is created and **joined to the domain**

---

## What you’ll learn
- What a **Domain Controller** is and why organizations use it
- How **DNS** enables domain authentication and service discovery
- How to create **OUs**, **users**, and **admin groups**
- How **RRAS (NAT)** routes internal traffic to the internet
- How **DHCP** assigns IP addresses automatically to clients
- How to run beginner-friendly **PowerShell scripts** to bulk-create users

---

## Tools & environments
### Languages / Utilities
- **PowerShell** (used for bulk user creation)

### Environment
- **Windows Server 2019**
- **Windows 10 (21H2)**
- **Oracle VirtualBox**

---

## Lab overview
You’re building a “mini company network” on your computer:

1. Create a Server VM
2. Install Windows Server
3. Assign a **static IP** on the internal network
4. Install **AD DS** and promote to a Domain Controller
5. Create OUs + users (manual + PowerShell)
6. Configure **RRAS/NAT**
7. Install **DHCP** and create a scope
8. Create a Windows 10 client and **join it to the domain**

---

## Network layout (simple diagram)
**Why two adapters?** NAT gives internet. Internal Network keeps the lab isolated and realistic.

            (Internet)
               |
          [NAT Adapter]
               |
  +---------------------------+
  |  Windows Server 2019 DC   |
  |  AD DS + DNS + RRAS + DHCP|
  |  Internal IP: 172.16.0.1  |
  +---------------------------+
               |
      [Internal Network]
               |
  +---------------------------+
  |     Windows 10 Client     |
  | Gets IP from DHCP scope   |
  | Joins mydomain.com        |
  +---------------------------+

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

<img width="1022" height="786" alt="Desktop Experience selection" src="https://github.com/user-attachments/assets/0325d003-0563-4f21-9cad-1280d4c39c96" />

Choose **Custom: Install Windows only (Advanced)**:

<img width="1026" height="790" alt="Custom install" src="https://github.com/user-attachments/assets/ef49be39-3718-4911-a2ef-0a1bed7cb58e" />

After restart: **don’t press keys**—let it boot into Windows.

<img width="1021" height="786" alt="Let it boot" src="https://github.com/user-attachments/assets/2a69c235-f5ac-46a0-844c-c9d596ed8b49" />

Set the local Administrator password:

<img width="1020" height="789" alt="Administrator password" src="https://github.com/user-attachments/assets/3df77c6c-b9a4-4a29-959b-088c9f488aa8" />

Send Ctrl+Alt+Del via VirtualBox:

<img width="1919" height="1124" alt="Ctrl+Alt+Del" src="https://github.com/user-attachments/assets/d8a3311c-f42f-4ad8-bb33-ba0599f0508b" />

Log in:

<img width="1019" height="789" alt="Log in" src="https://github.com/user-attachments/assets/f5db666b-24ef-4cb2-b58f-c7682c2c7756" />

---

## 5) Install VirtualBox Guest Additions
Devices → **Insert Guest Additions CD Image**:

<img width="1919" height="1129" alt="Guest Additions" src="https://github.com/user-attachments/assets/88059558-6653-4e41-8c4f-c4fb99fe20b9" />

Open **This PC → CD Drive (D) VirtualBox Guest Additions**:

<img width="1236" height="839" alt="Guest Additions drive" src="https://github.com/user-attachments/assets/c32938cb-3a77-41aa-b140-223086a26dae" />

Run the **amd64** installer, then reboot the VM:

<img width="1241" height="845" alt="Guest Additions installer" src="https://github.com/user-attachments/assets/489541b6-4152-4e08-a3f0-8d4dac86394b" />

---

## 6) Assign a static IP to the Domain Controller

Open network settings → **Change adapter options**:

<img width="1752" height="938" alt="Network settings" src="https://github.com/user-attachments/assets/c2cc4ac3-c7a4-4857-b43f-166637528f7f" />
<img width="1022" height="799" alt="Change adapter options" src="https://github.com/user-attachments/assets/fd923f3f-a5f5-4937-9fed-b1f568576b8b" />

Rename adapters:
- Ethernet (NAT) → **Internet**
- Ethernet (Internal) → **X_Internal_X**

<img width="1408" height="801" alt="Rename adapters" src="https://github.com/user-attachments/assets/5b54cd63-a653-4e0f-b62e-17d5f7ab2ec2" />

Set IPv4 on **X_Internal_X**:

<img width="1710" height="841" alt="IPv4 properties" src="https://github.com/user-attachments/assets/dd653ce0-b48a-4bc7-9eda-9cd8ea5afa32" />

Example lab settings:
- IP: **172.16.0.1**
- Subnet: **255.255.255.0**
- DNS: **127.0.0.1**

<img width="398" height="454" alt="Static IP example" src="https://github.com/user-attachments/assets/37809d0a-7473-456a-a21f-c77ff5bd9f3b" />

---

## 7) Install AD DS and promote to Domain Controller

Server Manager → **Add roles and features**:

<img width="1754" height="936" alt="Add roles and features" src="https://github.com/user-attachments/assets/a8cbcb22-b827-41d0-928e-51685e246b06" />

Select **Active Directory Domain Services**:

<img width="785" height="561" alt="Select AD DS" src="https://github.com/user-attachments/assets/612412ad-e43c-45bd-a3ab-03efe7f924d7" />

Server Manager flag → **Promote this server to a domain controller**:

<img width="1755" height="938" alt="Promote to domain controller" src="https://github.com/user-attachments/assets/3146bbaf-e8cc-4afd-bf2d-5e8ea2e4799d" />

Create a new forest (example `mydomain.com`):

<img width="759" height="562" alt="New forest" src="https://github.com/user-attachments/assets/82c83f66-286b-43b7-a4bc-87e2ebfc1198" />

Set DSRM password and install:

<img width="239" height="176" alt="DSRM password" src="https://github.com/user-attachments/assets/c0785af8-6ab1-45b4-b2ab-3f63bba88243" />

Login format becomes `DOMAIN\Administrator`:

<img width="1753" height="934" alt="Domain login" src="https://github.com/user-attachments/assets/df1238b8-9b2d-4987-9171-d5ff040faafd" />

---
<a id="step-8"></a>

8) Create OU and user, then add to Domain Admins

Open Active Directory Users and Computers:

<img width="1283" height="685" alt="AD Users and Computers" src="https://github.com/user-attachments/assets/b7d17fde-7176-46c7-9248-6f9cc6a76cbb" />

Create OU _ADMINS:

<img width="1280" height="667" alt="Create OU" src="https://github.com/user-attachments/assets/f2f0583c-5371-478e-a7f4-0ca8bab9da06" />

Create user inside _ADMINS:

<img width="1283" height="661" alt="Create user" src="https://github.com/user-attachments/assets/16984a17-f4fb-4dfb-92b6-63f0d292f904" />

Example naming:

a-firstinitiallastname (example: a-paraujo)

<img width="317" height="272" alt="User logon name" src="https://github.com/user-attachments/assets/d9762078-9444-4877-b18d-51135a26d994" />

Set password options:

<img width="320" height="273" alt="Password options" src="https://github.com/user-attachments/assets/ffca9bc0-0795-4dc7-a9b4-119820be791e" />

Add to Domain Admins:

<img width="452" height="248" alt="Member Of domain admins" src="https://github.com/user-attachments/assets/2b681082-5252-4240-8028-f2069273a267" />

Sign out and log in as the new domain user:

<img width="473" height="498" alt="Sign out" src="https://github.com/user-attachments/assets/659d7b61-34b3-407f-8f48-0b28bb9fb186" /> <img width="1283" height="678" alt="Other user login" src="https://github.com/user-attachments/assets/8fed75bc-7388-4b02-9859-8fcbddd9113f" /> ```
---

## 9) Configure RRAS (NAT)

Server Manager → Add roles → **Remote Access**:

<img width="922" height="688" alt="Remote access role" src="https://github.com/user-attachments/assets/5609071a-5e64-4be2-adca-005dd44e3e12" />

Select **Routing**:

<img width="573" height="407" alt="Routing role service" src="https://github.com/user-attachments/assets/1185a5ed-28af-4921-938c-a089bc1d0477" />

Tools → **Routing and Remote Access**:

<img width="1284" height="665" alt="Routing and remote access tool" src="https://github.com/user-attachments/assets/7d8e7c24-9a1d-4d28-bf53-5d974ae0a1f3" />

Configure and enable:

<img width="621" height="442" alt="Configure RRAS" src="https://github.com/user-attachments/assets/045d98b9-7c9f-4675-955a-a10f324da4a4" />

Choose **NAT**:

<img width="498" height="421" alt="NAT wizard" src="https://github.com/user-attachments/assets/a350cfaa-c9c2-4223-9999-372c5a860d62" />

Select **Use this public interface to connect to the Internet** → choose **Internet** → Next  
> If the box is grayed out, close the wizard and repeat the RRAS steps.

<img width="497" height="424" alt="Public interface selection" src="https://github.com/user-attachments/assets/a4d14315-a328-4282-a2c4-d1ad9960cc08" />

Green arrow confirms RRAS is running:

<img width="622" height="442" alt="RRAS running" src="https://github.com/user-attachments/assets/deb8847e-9deb-4f6b-88ef-66414bbf24ad" />

---

## 10) Install DHCP + Create a Scope

Server Manager → Add roles → **DHCP Server** → Install.

<img width="495" height="351" alt="Install DHCP" src="https://github.com/user-attachments/assets/d5115306-cfa3-464a-b326-686dc86bf189" />

Tools → **DHCP** → create scope under IPv4.

<img width="1754" height="933" alt="DHCP tool" src="https://github.com/user-attachments/assets/c256d3a3-6203-495a-aac1-52c678172b53" />

Right click **IPv4** → **New Scope**:

<img width="1150" height="769" alt="New scope" src="https://github.com/user-attachments/assets/7d058fb5-6fa6-41b8-b11c-8c3edfd7f2c8" />

Example scope name:

<img width="516" height="420" alt="Scope name" src="https://github.com/user-attachments/assets/3a37f06c-08f2-4554-bb41-91ac2d150ddd" />

Example scope range:
- Start: **172.16.0.100**
- End: **172.16.0.200**
- Mask: **255.255.255.0**

<img width="515" height="424" alt="Scope range" src="https://github.com/user-attachments/assets/5750f39e-451d-4bc9-b1a9-579616ec0a2a" />

Lease duration explanation:

<img width="321" height="268" alt="Lease duration" src="https://github.com/user-attachments/assets/8e287eaf-04f5-485f-80b6-71003baf9e41" />

Router (Default Gateway): **172.16.0.1** → click **Add** → Finish.  
Then **Authorize** the DHCP server and **Refresh**.

<img width="1051" height="549" alt="Authorize DHCP" src="https://github.com/user-attachments/assets/844163e2-f1f4-4b3c-bdfa-470934d68813" />

---

## 11) Create bulk users with PowerShell

Download the repo ZIP:
- https://codeload.github.com/araujopedro0325-alt/ActiveDirectoryLab/zip/refs/heads/main

Open the extracted folder and edit `names.txt` (add first + last names), then save:

<img width="629" height="116" alt="Open names.txt" src="https://github.com/user-attachments/assets/2e738ee6-c307-42cb-bd7a-f5b0d0a7b7c2" />
<img width="1430" height="706" alt="Edit names.txt" src="https://github.com/user-attachments/assets/de0ef38e-88db-40be-89b8-261cbd3fb00e" />

Run **PowerShell ISE as Administrator**:

<img width="1920" height="955" alt="Run ISE as admin" src="https://github.com/user-attachments/assets/5a115a8b-2ebd-44ee-89a0-2ccbe2176a0a" />

Open `1_CREATE_USERS.ps1`:

<img width="630" height="342" alt="Open script" src="https://github.com/user-attachments/assets/52447245-3a49-4d36-ab46-45a8bf676834" />

### Execution Policy (Lab note)
For lab use only (don’t do this on a real production machine):
```powershell```
Set-ExecutionPolicy Unrestricted 

Change directory to your extracted script folder (example):
cd C:\Users\<your-username>\Desktop\AD_PS-master

<img width="1920" height="955" alt="cd" src="https://github.com/user-attachments/assets/30d8e96d-9485-42fd-97d3-c535a1999b67" />

Run the script:

<img width="1920" height="955" alt="run script" src="https://github.com/user-attachments/assets/0be2f175-4301-4c11-9945-025e2724bbe0" />

Verify _USERS OU is created and populated:

<img width="1920" height="955" alt="Users" src="https://github.com/user-attachments/assets/0def1ed2-ca47-4a50-bf93-55b944b52141" /> ```
---

## 12) Create the Windows 10 Client VM

Create a new VM named `Client 1` (Windows 10 64-bit):

<img width="781" height="557" alt="Create client VM" src="https://github.com/user-attachments/assets/deba5a1d-071b-406e-8037-eb46ae61801a" />

Set network to **Internal Network**:

<img width="778" height="519" alt="Client internal network" src="https://github.com/user-attachments/assets/bbb87050-8dea-473a-8b42-204f5501d326" />

Mount Windows 10 ISO (not Server ISO):

<img width="766" height="531" alt="Select Win10 ISO" src="https://github.com/user-attachments/assets/fb0b3a63-2414-492e-96e8-db691649315d" />

Install steps:

<img width="744" height="573" alt="Install Win10" src="https://github.com/user-attachments/assets/f65fd91d-e886-4d03-8e91-e25c0a28570a" />
<img width="1025" height="785" alt="No product key" src="https://github.com/user-attachments/assets/ac3bfb28-68e7-4c48-ad84-759e25e1ac94" />
<img width="746" height="572" alt="Custom install" src="https://github.com/user-attachments/assets/1dd3b005-6e45-4293-bb9b-0ecbd4ea5c4e" />

Offline setup:

<img width="747" height="573" alt="Region" src="https://github.com/user-attachments/assets/71538ec7-7c1c-4687-80b6-71003baf9e41" />
<img width="748" height="573" alt="No internet" src="https://github.com/user-attachments/assets/fb21a699-8e20-45dd-8f72-ca3e1ab1b0fb" />
<img width="746" height="575" alt="Limited setup" src="https://github.com/user-attachments/assets/2f840e62-9c57-499e-aec5-851198dc2f16" />
<img width="744" height="576" alt="Local user" src="https://github.com/user-attachments/assets/05bf11bd-b24f-49dd-ab48-b24a9d7bfbc8" />
<img width="744" height="573" alt="Finish setup" src="https://github.com/user-attachments/assets/2f840e62-9c57-499e-aec5-851198dc2f16" />

---

## 13) Join the Client to the Domain

Open System settings:

<img width="1024" height="768" alt="System" src="https://github.com/user-attachments/assets/103ea906-be3f-4788-93c7-18b65250fa8d" />

Rename this PC (advanced):

<img width="1024" height="768" alt="Rename advanced" src="https://github.com/user-attachments/assets/6b38abf3-3e0f-43dd-8d0a-cfb40ee93109" />

Change → rename `Client 1` and join your domain (example `mydomain.com`):

<img width="297" height="340" alt="Join domain" src="https://github.com/user-attachments/assets/87388399-7457-4cbd-89fe-3b0e812594a4" />
<img width="297" height="338" alt="Domain name" src="https://github.com/user-attachments/assets/b36072d4-6feb-4482-ba39-4cc0fb73ffdd" />

When prompted, sign in with a domain user created earlier.  
> In this lab script, the password is set to `Password1` for learning purposes.

<img width="328" height="216" alt="Domain login prompt" src="https://github.com/user-attachments/assets/8f73a2b5-46a9-4524-9b90-75ddd8afb8a0" />

While restarting, verify the DHCP lease (Scope → Address Leases):

<img width="838" height="560" alt="DHCP lease" src="https://github.com/user-attachments/assets/b929ffdb-9cde-42c2-bdb7-e181c96a3fe3" />

Log in to the client using **Other user** and your domain credentials:

<img width="745" height="577" alt="Other user domain" src="https://github.com/user-attachments/assets/ab3bb858-6977-4c25-888d-f1f5dbaf5973" />
<img width="745" height="576" alt="Login" src="https://github.com/user-attachments/assets/456d3565-e4ca-4c34-9aa8-0ac08afb4c05" />

Success:

<img width="745" height="576" alt="Domain joined" src="https://github.com/user-attachments/assets/9c17c706-9c39-4362-af18-9dc39a2ecf6a" />

---

## Scripts (click to view)

> ⚠️ If this README is inside the `active-directory-lab-scripts` folder, keep these links as-is.
> If your README is at the repo root, update the links to: `./active-directory-lab-scripts/scripts/`

- **Scripts folder:** [Open here](./scripts/)
- **Example script:** [Create Users](./scripts/1_CREATE_USERS.ps1)

> Tip: You can open any `.ps1` file on GitHub and click **Raw** to download it.

---

## Project structure
ActiveDirectoryLab/
├── active-directory-lab-scripts/
│ ├── scripts/
│ ├── data/
│ └── docs/
└── README.md

---

## Troubleshooting
**1) Client can’t find the domain**
- Confirm Client NIC is **Internal Network**
- Confirm Client DNS points to **172.16.0.1**
- Confirm DC internal adapter is set to **172.16.0.1/24**

**2) Client gets no IP**
- Confirm DHCP server is **Authorized**
- Confirm scope is **Active**
- Confirm client is on the same internal network

**3) No internet**
- DC Adapter 1 must be **NAT**
- RRAS must be configured with **Internet** as the public interface

---

## Roadmap / Next steps
- [ ] Add OUs: `_WORKSTATIONS`, `_SERVERS`
- [ ] Add basic GPOs (password policy, mapped drive, wallpaper)
- [ ] Add file server share + NTFS permissions
- [ ] Add CSV-based user provisioning with PowerShell
- [ ] Add a simple diagram image (draw.io) to replace the ASCII diagram

---

## Disclaimer
This lab is for learning/testing in a controlled environment. Do not expose these VMs directly to the public internet.







