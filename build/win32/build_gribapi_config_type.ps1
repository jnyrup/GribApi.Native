param(
    [switch]$Rebuild,
    [switch]$Debug,
	[switch]$Verbose,
	[string]$PlatformToolset = "v142"
)

Set-StrictMode -Version 3.0
$ErrorActionPreference = "Stop"

$build = If ($Rebuild) {"Clean,Build"} Else {"Build"}
$config = If ($Debug) {"Debug"} Else {"Release"}
$output = if ($Verbose) {'Out-Default'} else {'Out-Null'}

$scriptDir = Split-Path $script:MyInvocation.MyCommand.Path
$baseDir = "$scriptDir\..\.."

If ($Rebuild) {
  Remove-Item -Recurse -Force -ErrorAction Ignore "$baseDir\bin"
}

Write-Host "Building GribApi.XP"
Push-Location "$baseDir\GribApi.XP"
& "build\win32\build_gribapi.ps1" -Rebuild:$Rebuild -Debug:$Debug -PlatformToolset:$PlatformToolset -Verbose:$Verbose
Pop-Location

If (!$?) {
  Write-Warning "Building Grib.Api.XP failed"
  exit 1
}

Write-Host "Building GribApi.Native x64"
msbuild "$baseDir\src\Grib.Api.Native.vcxproj" /p:Configuration="$config" /p:Platform="x64" /p:PlatformToolset="$PlatformToolset" /t:"$build" | & $output

If (!$?) {
  Write-Warning "Building Grib.Api x64 failed"
  exit 1
}

Write-Host "building GribApi.Native x86"
msbuild "$baseDir\src\Grib.Api.Native.vcxproj" /p:Configuration="$config" /p:Platform="Win32" /p:PlatformToolset="$PlatformToolset" /t:"$build" | & $output

If (!$?) {
  Write-Warning "Building Grib.Api x86 failed"
  exit 1
}