@echo off
setlocal enabledelayedexpansion


:: get current timestamp
for /f "tokens=1-3 delims=/ " %%a in ('date /t') do set date=%%b-%%a-%%c
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set time=%%a:%%b
set datetime=%date% %time%

:: Remove invalid characters from the timestamp
set datetime=%datetime::=-%
set datetime=%datetime:/=-%
set datetime=%datetime: =_%

:menu
cls
color 0A
echo.
echo ================================================
echo               DivineTracker v0.1
echo ================================================
echo.
echo Welcome to the Abyss... Your journey starts here.
echo.
echo [1] Start a New Trip Log
echo [2] View Information
echo [3] Exit (If you're brave enough...)
echo.
set /p choice="Choose your path: "

if "%choice%"=="1" goto newlog
if "%choice%"=="2" goto info
if "%choice%"=="3" exit

:: start a new log entry
:newlog
cls
color 0C
echo.
echo ================================================
echo        TRIP LOG - NEW ENTRY
echo ================================================
echo.
echo Choose your weight system (You're not special, just pick one):
echo [1] Pounds (lbs)
echo [2] Kilograms (kg)
set /p weight_system="Your choice (1 or 2): "

if "%weight_system%"=="1" goto weight_lbs
if "%weight_system%"=="2" goto weight_kg

:: weight in pounds
:weight_lbs
cls
set weight_unit=lbs
set /p weight="Enter your weight in pounds (If you even care): "
goto log_details

:: weight in kilograms
:weight_kg
cls
set weight_unit=kg
set /p weight="Enter your weight in kilograms (Just don't mess it up): "
goto log_details

:: log details for substance and dosage
:log_details
cls
set /p substance="Enter the substance you are using (e.g., DXM, DPH, etc.): "
cls
set /p dosage="Enter the dosage in milligrams (Don't fuck this up): "
echo.

:: ask for the log file name (if left blank, use default format)
cls
set /p logfile_name="Enter the log file name (Leave it blank for the default): "

:: if no name is provided, use the default timestamped name
if "%logfile_name%"=="" (
    set logfile=trip_log_%datetime%.txt
) else (
    :: remove invalid characters for filename
    set logfile_name=%logfile_name:\=-%
    set logfile_name=%logfile_name:/=-%
    set logfile_name=%logfile_name::=-%
    set logfile_name=%logfile_name:?=-%
    set logfile_name=%logfile_name:<=-%
    set logfile_name=%logfile_name:>=-%
    set logfile_name=%logfile_name: =_%

    set logfile=%logfile_name%.txt
)

:: creating the log file with details (only written to file not shown in cmd)
echo =============================================== >> "!logfile!"
echo [START LOG] Trip Log started at !datetime! >> "!logfile!"
echo =============================================== >> "!logfile!"
echo Substance: !substance! >> "!logfile!"
echo Weight: !weight! !weight_unit! >> "!logfile!"
echo Dosage: !dosage! mg >> "!logfile!"
echo =============================================== >> "!logfile!"
echo. >> "!logfile!"

:: start trip update loop
:logloop
cls
echo.
echo ================================================
echo        CURRENT TRIP LOG - LIVE FEED
echo ================================================
echo.

:: display current trip details and updates
type "!logfile!"
echo.
echo Give us your soul... err, update (or type 'exit' to stop logging):
set /p update=""

if /i "!update!"=="exit" goto end

:: get current timestamp
for /f "tokens=1-2 delims=: " %%a in ('time /t') do set time=%%a:%%b
set datetime=%date% %time%

:: remove invalid characters from the timestamp
set datetime=%datetime::=-%
set datetime=%datetime:/=-%
set datetime=%datetime: =_% 

:: log the update with timestamp (substance info already in the log file so just add the update)
echo [!datetime!] - !update! >> "!logfile!"

:: prompt for next entry
goto logloop

:end
cls
color 0F
echo.
echo ================================================
echo   LOG COMPLETED - END OF THE ROAD
echo ================================================
echo Log saved in !logfile!
pause
goto menu

:info
cls
color 0E
echo ================================================
echo               DivineTracker INFO
echo ================================================
echo.
echo Created by:
echo * u/DivineEgotrip - Yeah, it's me. You're in for a ride.
echo.
echo **USE AT YOUR OWN RISK. THIS SHIT IS REAL.**
echo.
echo **WHAT THIS TOOL DOES:**
echo * Log every fucked-up step of your trip. Substances, dosages, and your weight - it's all tracked.
echo * Keeps track of the chaos as it unfolds. Because you're gonna forget most of it.
echo * Saves it in a file so you can look back and ask, "What the hell happened?"
echo.
echo **IF YOU'RE DOING DPH:**
echo * Seriously, I've seen too many people disappear on r/dph. People I actually talked to. 
echo   They didn't listen. Now they're gone. Don't make that mistake.
echo * You think you're untouchable? You're not. Know your limit. Quit before it's too late.
echo.
echo **DISCLAIMER:**
echo * You control your actions, but not the consequences. 
echo * This tool just tracks your moves. What happens after is on you.
echo * Don't play with fire if you don't understand the burn.
echo.
echo **REAL TALK:**
echo * Start small, or don't start at all. This isn't a game.
echo * Track your journey, 'cause when shit hits, you'll wanna know what went down.
echo * Understand what you're taking. Don't be another statistic.
echo.
echo **A HARD TRUTH:**
echo "You're not special. Just another person running from reality. Stay sharp."
echo.
pause
goto menu