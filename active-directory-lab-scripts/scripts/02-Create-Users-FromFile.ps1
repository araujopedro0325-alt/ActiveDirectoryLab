<#
.SYNOPSIS
Creates Active Directory users from a names file (First Last per line).

.DESCRIPTION
Reads a list of names and creates AD user accounts in a target OU.
Usernames are generated as: first initial + last name (example: "Pedro Araujo" -> "paraujo").

Designed for a Windows Server / Active Directory home lab.

.PARAMETER NamesFile
Path to a text file where each line contains "First Last".

.PARAMETER OUName
Name of the OU where users will be created (default: _USERS).

.PARAMETER DefaultPassword
Default password assigned to each created user.

.PARAMETER UPNDomain
Optional UPN suffix (example: mydomain.com). If omitted, uses the current domain DNS root.

.EXAMPLE
.\02-Create-Users-FromFile.ps1

.EXAMPLE
.\02-Create-Users-FromFile.ps1 -NamesFile .\data\names.txt -OUName "_USERS" -DefaultPassword "Password1" -WhatIf
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$NamesFile = ".\data\names.txt",

    [string]$OUName = "_USERS",

    [string]$DefaultPassword = "Password1",

    [string]$UPNDomain
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory -ErrorAction Stop

if (-not (Test-Path -LiteralPath $NamesFile)) {
    throw "Names file not found: $NamesFile"
}

$domain = Get-ADDomain
$domainDN = $domain.DistinguishedName
$upnSuffix = if ($UPNDomain) { $UPNDomain } else { $domain.DNSRoot }

# Ensure OU exists
$ouDN = "OU=$OUName,$domainDN"
$ou = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouDN'" -ErrorAction SilentlyContinue
if ($null -eq $ou) {
    Write-Host "OU not found. Creating: $ouDN" -ForegroundColor Yellow
    if ($PSCmdlet.ShouldProcess($ouDN, "Create OU")) {
        New-ADOrganizationalUnit -Name $OUName -Path $domainDN -ProtectedFromAccidentalDeletion $false | Out-Null
    }
}

$password = ConvertTo-SecureString $DefaultPassword -AsPlainText -Force

$lines = Get-Content -LiteralPath $NamesFile | Where-Object { $_.Trim() -ne "" }

$created = 0
$skipped = 0

foreach ($line in $lines) {
    $parts = $line.Trim() -split "\s+"
    if ($parts.Count -lt 2) {
        Write-Warning "Skipping invalid name (need 'First Last'): $line"
        $skipped++
        continue
    }

    $first = $parts[0]
    $last  = $parts[1]

    $sam = (($first.Substring(0,1)) + $last).ToLower()
    $display = "$first $last"
    $upn = "$sam@$upnSuffix"

    $existing = Get-ADUser -Filter "SamAccountName -eq '$sam'" -ErrorAction SilentlyContinue
    if ($null -ne $existing) {
        Write-Host "Skipping (already exists): $sam" -ForegroundColor Yellow
        $skipped++
        continue
    }

    $action = "Create user $sam in $ouDN"
    if ($PSCmdlet.ShouldProcess($sam, $action)) {
        New-ADUser `
            -SamAccountName $sam `
            -UserPrincipalName $upn `
            -GivenName $first `
            -Surname $last `
            -Name $display `
            -DisplayName $display `
            -AccountPassword $password `
            -Enabled $true `
            -PasswordNeverExpires $true `
            -Path $ouDN | Out-Null

        Write-Host "Created user: $sam" -ForegroundColor Green
        $created++
    }
}

Write-Host ""
Write-Host "Done." -ForegroundColor Cyan
Write-Host "Created: $created | Skipped: $skipped" -ForegroundColor Cyan
