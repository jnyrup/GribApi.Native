param(
    [switch]$Rebuild,
	[switch]$Verbose,
	[string]$PlatformToolset = "v142",
    [string]$PackageVersion
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$scriptDir = Split-Path $script:MyInvocation.MyCommand.Path

If ((Get-Command "msbuild.exe" -ErrorAction SilentlyContinue) -eq $null) {
  Write-Warning "msbuild.exe was not found in the PATH. "
  Write-Warning "Run this script from an Developer Powershell For VS"
  Write-Warning "or have msbuild.exe in your PATH"
  exit 1
}

Write-Host "Building debug"
& "$scriptDir\build_gribapi_config_type.ps1" -Rebuild:$Rebuild -PlatformToolset:$PlatformToolset -Verbose:$Verbose -Debug

Write-Host "Building release"
& "$scriptDir\build_gribapi_config_type.ps1" -Rebuild:$Rebuild -PlatformToolset:$PlatformToolset -Verbose:$Verbose

If ($PackageVersion) {
  Write-Host "Packaging nuget"
  & "$scriptDir\build_nuget.ps1" $PackageVersion
}