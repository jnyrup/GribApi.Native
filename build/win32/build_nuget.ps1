:: build_nuget.ps1 [x.x.x]

SET _VERSION=%1
if "%1"=="" SET _VERSION=0.0.0-beta

if ((Get-Command "nuget.exe" -ErrorAction SilentlyContinue) -eq $null)
{
  ECHO "nuget.exe was not found in the PATH"
  ECHO "Download nuget.exe and add it to PATH"
  EXIT /B 1
}

RD %~dp0..\..\nuget.package\content /S /Q

xcopy %~dp0..\..\bin\Release\Grib.Api\lib\win\x64\Grib.Api.Native.dll %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x64\Release\ /S /Y /Q
xcopy %~dp0..\..\bin\Release\Grib.Api\lib\win\x64\Grib.Api.Native.pdb %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x64\Release\ /S /Y /Q
xcopy %~dp0..\..\bin\Debug\Grib.Api\lib\win\x64\Grib.Api.Native.dll %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x64\Debug\ /S /Y /Q
xcopy %~dp0..\..\bin\Debug\Grib.Api\lib\win\x64\Grib.Api.Native.pdb %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x64\Debug\ /S /Y /Q

xcopy %~dp0..\..\bin\Release\Grib.Api\lib\win\x86\Grib.Api.Native.dll %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x86\Release\ /S /Y /Q
xcopy %~dp0..\..\bin\Release\Grib.Api\lib\win\x86\Grib.Api.Native.pdb %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x86\Release\ /S /Y /Q
xcopy %~dp0..\..\bin\Debug\Grib.Api\lib\win\x86\Grib.Api.Native.dll %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x86\Debug\ /S /Y /Q
xcopy %~dp0..\..\bin\Debug\Grib.Api\lib\win\x86\Grib.Api.Native.pdb %~dp0..\..\nuget.package\content\net45\Grib.Api\lib\win\x86\Debug\ /S /Y /Q

xcopy %~dp0..\..\GribApi.XP\grib_api\definitions %~dp0..\..\nuget.package\content\net45\Grib.Api\definitions\ /S /d /I /Q /Y

pushd %~dp0..\..\nuget.package
nuget.exe pack Grib.Api.Native.nuspec -Version %_VERSION%
popd