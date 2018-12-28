swig -csharp -c++ -dllimport Grib.Api.Native.dll -o Grib_Api_Native.cpp -outdir %~dp0..\..\..\GribApi.NET\src\GribApi.NET\Grib.Api\Interop\SWIG -DSWIG_CSHARP_NO_IMCLASS_STATIC_CONSTRUCTOR -I%~dp0..\..\..\GribApi.XP\grib_api\src grib_api.i

if %errorlevel% neq 0 exit /b %errorlevel%

move %~dp0Grib_Api_Native.cpp %~dp0..\..\src\Grib_Api_Native.cpp