<#
.SYNOPSIS
Generates random users in Active Directory for lab testing.

.DESCRIPTION
Creates a specified number of randomly generated user accounts in an OU.
Useful for testing login, group policy, and admin tools at scale.

.PARAMETER Count
Number of users to create.

.PARAMETER OUName
Target OU for new users (default: _EMPLOYEES).

.PARAMETER DefaultPassword
Default password assigned to each created user.

.EXAMPLE
.\03-Create-RandomUsers.ps1 -Count 100

.EXAMPLE
.\03-Create-RandomUsers.ps1 -Count 500 -OUName "_EMPLOYEES" -DefaultPassword "Password1" -WhatIf
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [ValidateRange(1, 50000)]
    [int]$Count = 100,

    [string]$OUName = "_EMPLOYEES",

    [string]$DefaultPassword = "Password1"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

Import-Module ActiveDirectory -ErrorAction Stop

function New-RandomName {
    param(
        [ValidateRange(3, 10)]
        [int]$MinLength = 3,

        [ValidateRange(3, 12)]
        [int]$MaxLength = 8
    )

    $consonants = @('b','c','d','f','g','h','j','k','l','m','n','p','r','s','t','v','w','x','z')
    $vowels     = @('a','e','i','o','u','y')

    $len = Get-Random -Minimum $MinLength -Maximum ($MaxLength + 1)
    $name = ""

    for ($i = 0; $i -lt $len; $i++) {
        if ($i % 2 -eq 0) { $name += $consonants[(Get-Random -Maximum $consonants.Count)] }
        else             { $name += $vowels[(Get-Random -Maximum $vowels.Count)] }
    }

    # Capitalize first letter
    return ($name.Substring(0,1).ToUpper() + $name.Substring(1))
}

$domain = Get-ADDomain
$domainDN = $domain.DistinguishedName
$upnSuffix = $domain.DNSRoot

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

$created = 0
for ($i = 1; $i -le $Count; $i++) {
    $first = New-RandomName
    $last  = New-RandomName
    $sam   = (($first.Substring(0,1)) + $last).ToLower()

    # Make collisions less likely by appending digits if needed
    $attempt = 0
    $candidate = $sam
    while (Get-ADUser -Filter "SamAccountName -eq '$candidate'" -ErrorAction SilentlyContinue) {
        $attempt++
        $candidate = "$sam$attempt"
        if ($attempt -ge 50) { throw "Too many username collisions around: $sam" }
    }
    $sam = $candidate

    $display = "$first $last"
    $upn = "$sam@$upnSuffix"

    if ($PSCmdlet.ShouldProcess($sam, "Create random user in $ouDN")) {
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

        $created++
        if ($i % 25 -eq 0) {
            Write-Host "Progress: $i / $Count (created: $created)" -ForegroundColor Cyan
        }
    }
}

Write-Host ""
Write-Host "Done. Created $created users in $ouDN" -ForegroundColor Green
