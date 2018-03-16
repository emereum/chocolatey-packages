$ErrorActionPreference = "Stop"

$packageName = "postgresql"
$pp = Get-PackageParameters
$password = $pp["Password"]

if(!$password)
{
    $password = Read-Host "Specify a password to be assigned to the postgres user:" -AsSecureString
    $password = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))
}

if(!$password)
{
    throw "Please specify a password to be assigned to the postgres user."
}

$silentArgs = @(
    "--mode unattended",
    "--unattendedmodeui none",
    "--serverport 5432",
    "--superpassword $($password)",
    "--enable_acledit 1",
    "--install_runtimes 0"
) -join " "

$packageArgs = @{
    packageName = $packageName
    fileType = "exe"
    softwareName = "PostgreSQL"
    url64bit = "https://get.enterprisedb.com/postgresql/postgresql-9.6.8-1-windows-x64.exe"
    checksum64 = "8884b5415bfc3bcdbbffc7d8cf2bd063461e67d21359a04415cd517dd131c611"
    checksumType64 = "sha256"
    silentArgs = $silentArgs
    validExitCodes = @(0)
}

Install-ChocolateyPackage @packageArgs
Install-ChocolateyPath "$($env:SystemDrive)\Program Files\PostgreSQL\9.6\bin" -PathType 'Machine'