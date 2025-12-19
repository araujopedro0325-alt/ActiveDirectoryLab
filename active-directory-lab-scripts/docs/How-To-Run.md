# How to run the scripts (Beginner-friendly)

## Recommended: Run on the Domain Controller (Server 2019)
These scripts use the **ActiveDirectory** PowerShell module, which is typically available on a Domain Controller after installing AD DS.

## Before you run anything
1. Log into your Domain Controller VM
2. Open **PowerShell ISE** as Administrator
   - Start Menu → type **PowerShell ISE**
   - Right-click → **Run as administrator**
3. Confirm the AD module is available:

```powershell
Get-Module -ListAvailable ActiveDirectory
```

If you see results, you're good.

## Safe test mode (recommended)
Scripts in this repo support `-WhatIf` so you can preview changes first:

```powershell
.\scripts\02-Create-Users-FromFile.ps1 -WhatIf
```

## Running scripts in PowerShell ISE
Option A (easiest):
- Click a script in GitHub → copy the code → paste into ISE → save → run

Option B:
- Download the repo as ZIP → unzip → open the `.ps1` files in ISE
