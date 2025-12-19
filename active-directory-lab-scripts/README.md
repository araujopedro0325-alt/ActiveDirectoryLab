# Active Directory Lab Scripts (PowerShell)

Beginner-friendly PowerShell scripts for an **Active Directory home lab** (Windows Server 2019 / AD DS).
Each script is **click-to-view** on GitHub and **PowerShell ISE ready**.

## What’s inside
- Create common OUs (like `_USERS` and `_EMPLOYEES`)
- Create users from a **names list** (first + last per line)
- Generate random users for scale testing (GPO / admin tools practice)

## Folder layout
- **[scripts/](./scripts/)** → PowerShell scripts (click a script to view the code)
- **data/** → input files used by scripts (example: `names.txt`)
- **docs/** → beginner instructions

> Names list included in `data/names.txt`.  

## Quick start (PowerShell ISE)
1. Log into your **Domain Controller** (Server 2019 VM)
2. Open **PowerShell ISE** as Administrator
3. Download this repo (Code → Download ZIP) and unzip it
4. Run in **preview mode** first:

```powershell
cd .\active-directory-lab-scripts
.\scripts\02-Create-Users-FromFile.ps1 -WhatIf
```

5. When it looks right, run without `-WhatIf`:

```powershell
.\scripts\02-Create-Users-FromFile.ps1
```

## Scripts (click to view)
1. **[01-Create-OU.ps1](./scripts/01-Create-OU.ps1)** — Creates an OU (safe to re-run)
2. **[02-Create-Users-FromFile.ps1](./scripts/02-Create-Users-FromFile.ps1)** — Creates users from `data/names.txt`
3. **[03-Create-RandomUsers.ps1](./scripts/03-Create-RandomUsers.ps1)** — Generates random lab users

## Notes for beginners
- If you want to “download just one script”: click the script → click **Raw** → save as `.ps1` → open in PowerShell ISE.
- These scripts change Active Directory. Use `-WhatIf` first whenever possible.

## Requirements
- Run on a machine with the **ActiveDirectory** PowerShell module (recommended: the Domain Controller)
- Account running the script should have permission to create OUs and users

## Documentation
- **[How to run the scripts](./docs/How-To-Run.md)**

## License
MIT
