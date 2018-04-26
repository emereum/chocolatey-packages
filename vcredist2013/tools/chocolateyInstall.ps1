$packageName = 'vcredist2013'
$installerType = 'exe'
$url = 'https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x86.exe'
$checksum = '89f4e593ea5541d1c53f983923124f9fd061a1c0c967339109e375c661573c17'
$checksumType = 'sha256'
$url64 = 'https://download.microsoft.com/download/0/5/6/056dcda9-d667-4e27-8001-8a0c6971d6b1/vcredist_x64.exe'
$checksum64 = '20e2645b7cd5873b1fa3462b99a665ac8d6e14aae83ded9d875fea35ffdd7d7e'
$checksumType64 = 'sha256'
$silentArgs = '/Q /norestart'
$validExitCodes = @(0,3010)  # http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

Install-ChocolateyPackage -PackageName "$packageName" `
                          -FileType "$installerType" `
                          -Url "$url" `
                          -Url64bit "$url64" `
                          -SilentArgs "$silentArgs" `
                          -ValidExitCodes $validExitCodes `
                          -Checksum "$checksum" `
                          -ChecksumType "$checksumType" `
                          -Checksum64 "$checksum64" `
                          -ChecksumType64 "$checksumType64"

if (Get-ProcessorBits 64) {
  Install-ChocolateyPackage -PackageName "$packageName" `
                            -FileType "$installerType" `
                            -Url "$url" `
                            -SilentArgs "$silentArgs" `
                            -ValidExitCodes $validExitCodes `
                            -Checksum "$checksum" `
                            -ChecksumType "$checksumType"
}