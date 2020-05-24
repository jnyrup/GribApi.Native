Set-StrictMode -Version 3.0
$scriptDir = Split-Path $script:MyInvocation.MyCommand.Path

swig -csharp -c++ -dllimport Grib.Api.Native.dll -o Grib_Api_Native.cpp -namespace Grib.Api.Interop.SWIG -outdir "$scriptDir\..\..\..\GribApi.NET\src\GribApi.NET\Grib.Api\Interop\SWIG" -DSWIG_CSHARP_NO_IMCLASS_STATIC_CONSTRUCTOR -I"$scriptDir\..\..\..\GribApi.XP\grib_api\src grib_api.i"

if (!$?) {
  Write-Warning "SWIG failed"
  exit 1
}

move "$scriptDir\Grib_Api_Native.cpp" "$scriptDir\..\..\src\Grib_Api_Native.cpp"