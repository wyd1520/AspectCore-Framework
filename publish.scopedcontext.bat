@echo off

if not exist packages (
    md packages
)

for /R "packages" %%s in (*) do (
    del %%s
)

dotnet pack src/AspectCore.Extensions.ScopedContext --configuration Release --output ../../packages

for /R "packages" %%s in (*symbols.nupkg) do (
    del %%s
)

set /p key=input key:
set source=https://www.myget.org/F/aspectcore/api/v2/package

call nuget.exe setApiKey %key% -Source %source%  
rem using nuget v4.x
for /R "packages" %%s in (*.nupkg) do ( 
    call nuget.exe push %%s -Source %source%  
)

pause