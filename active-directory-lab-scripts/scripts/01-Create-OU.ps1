<#
.SYNOPSIS
Creates an Organizational Unit (OU) in Active Directory (safe to re-run).

.DESCRIPTION
This script creates an OU in the current domain if it does not already exist.
Designed for Active Directory home lab practice.

.PARAMETER OUName
The name of the OU to create (example: _USERS).

.PARAMETER DisableAccidentalDeletionProtection
If set, disables "Protect object from accidental deletion" on the OU.

.EXAMPLE
.\01-Create-OU.ps1 -OUName "_USERS"

.EXAMPLE
.\01-Create-OU.ps1 -OUName "_EMPLOYEES" -DisableAccidentalDeletionProtection
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [Parameter(Mandatory = $true)]
    [ValidateNotNullOrEmpty()]
    [string]$OUName,

    [switch]$DisableAccidentalDeletionProtection
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

# Ensure AD module is available
Import-Module ActiveDirectory -ErrorAction Stop

$domainDN = ([ADSI]"").distinguishedName
$ouDN = "OU=$OUName,$domainDN"

$existing = Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ouDN'" -ErrorAction SilentlyContinue

if ($null -ne $existing) {
    Write-Host "OU already exists: $ouDN" -ForegroundColor Yellow
    if ($DisableAccidentalDeletionProtection) {
        if ($PSCmdlet.ShouldProcess($ouDN, "Disable accidental deletion protection")) {
            Set-ADOrganizationalUnit -Identity $existing.DistinguishedName -ProtectedFromAccidentalDeletion $false
            Write-Host "Protection disabled on: $ouDN" -ForegroundColor Green
        }
    }
    return
}

if ($PSCmdlet.ShouldProcess($ouDN, "Create OU")) {
    New-ADOrganizationalUnit -Name $OUName -Path $domainDN | Out-Null
    Write-Host "Created OU: $ouDN" -ForegroundColor Green

    if ($DisableAccidentalDeletionProtection) {
        Set-ADOrganizationalUnit -Identity $ouDN -ProtectedFromAccidentalDeletion $false
        Write-Host "Protection disabled on: $ouDN" -ForegroundColor Green
    }
}
