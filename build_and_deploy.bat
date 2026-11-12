@echo off
rem Bien dich Java va copy 2 ung dung vao Tomcat cua XAMPP.
rem Chay lai file nay moi khi sua code (Java hoac JSP).
set TOMCAT=C:\xampp\tomcat

if not exist build\classes mkdir build\classes
javac -encoding UTF-8 --release 8 -d build\classes src\restman\model\*.java src\restman\dao\*.java
if errorlevel 1 (
    echo Loi bien dich Java!
    exit /b 1
)

call :deploy manager restman-quanly
call :deploy customer restman-khach
echo.
echo Quan ly  : http://localhost:8080/restman-quanly/
echo Khach    : http://localhost:8080/restman-khach/
exit /b 0

:deploy
set APP=%TOMCAT%\webapps\%2
xcopy /E /I /Y %1\webapp "%APP%" >nul
xcopy /E /I /Y common\css "%APP%\css" >nul
xcopy /E /I /Y build\classes "%APP%\WEB-INF\classes" >nul
xcopy /I /Y lib\*.jar "%APP%\WEB-INF\lib" >nul
rem sua gio web.xml de Tomcat tu nap lai ung dung
powershell -NoProfile -Command "(Get-Item '%APP%\WEB-INF\web.xml').LastWriteTime = Get-Date"
exit /b 0
