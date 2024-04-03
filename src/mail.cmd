FOR /F "TOKENS=2,* SKIP=2" %%F IN ('REG QUERY "HKCU\SOFTWARE\Clients\Mail" /VE') DO SET APP=%%G
IF "[%APP%]" == "[]" (
FOR /F "TOKENS=2,* SKIP=2" %%F IN ('REG QUERY "HKLM\SOFTWARE\Clients\Mail" /VE') DO SET APP=%%G
)

REM No default mail application is set
IF "[%APP%]" == "[]" EXIT /B 1


REM Assume that the entry in MAIL matches %APP%
REM Assume that ApplicationIcon is set

FOR /F "TOKENS=2,* SKIP=2" %%F IN ('REG QUERY "HKCU\SOFTWARE\Clients\Mail\%APP%\Capabilities" /V ApplicationIcon') DO SET "RPATH=%%G"
IF "[%RPATH%]" == "[]" (
FOR /F "TOKENS=2,* SKIP=2" %%F IN ('REG QUERY "HKLM\SOFTWARE\Clients\Mail\%APP%\Capabilities" /V ApplicationIcon') DO SET "RPATH=%%G"
)

REM ApplicationIcon not found
IF "[%RPATH%]" == "[]" EXIT /B 2

FOR /F "DELIMS=," %%F IN ("%RPATH%") DO SET "EXEPATH=%%F"
REM TODO FOR /F "TOKENS=2 DELIMS=," %%F IN ("%EXEPATH%") DO IF NOT "[%%F]"=="[exe]" EXIT /B 3
START "%APP%" "%EXEPATH%"
EXIT /B 0
