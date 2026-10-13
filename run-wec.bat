::<by Hannes Breuer, GNotDS, hannes.breuer@gnotds.de, 2025>

::Dieses Skript fragt einmal eine URL ab und laesst den Website Evidence Collector
::dann zweimal darauf laufen: einmal normal (Ordner "output") und einmal mit vorab
::akzeptierten Cookies (Ordner "output-with-cookies"), damit auch sichtbar wird, was
::eine Webseite erst NACH Zustimmung zum Cookie-Banner nachlaedt.
::Website Evidence Collector muss extra installiert werden: https://code.europa.eu/EDPS/website-evidence-collector
::Fuer den zweiten Durchlauf wird zusaetzlich die Chrome/Firefox-Extension
::"Get cookies.txt LOCALLY" benoetigt (exportiert Cookies im Netscape-cookies.txt-Format):
::https://github.com/kairi003/Get-cookies.txt-Locally
::Fehlt beim Start eine passende Cookie-Datei im Downloads-Ordner, wird NUR der zweite
::Durchlauf uebersprungen - der erste (normale) Durchlauf findet trotzdem statt.



@echo off
setlocal enabledelayedexpansion

::ESC-Zeichen fuer farbige Hinweise ermitteln (ueber den Umweg "prompt $E", da
::sich das Steuerzeichen selbst nicht direkt in eine Batch-Datei tippen laesst)
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"

::Ins Verzeichnis dieser Datei wechseln, egal wie das Skript gestartet wurde
::(Doppelklick setzt das automatisch, Start ueber die Windows-Suche z.B. nicht)
cd /d "%~dp0"
echo ======================================================================================================================
echo.
echo.
echo WILLKOMMEN BEI UNSEREM WEBSEITENTESTTOOL
echo.
echo.
echo ======================================================================================================================
echo.
echo.
echo Anleitung
echo.
echo 1. Optional, aber empfohlen: Zielwebseite im Browser oeffnen, Cookie-Banner aktiv
echo    bestaetigen (alle Cookies akzeptieren), und mit der Extension "Get cookies.txt
echo    LOCALLY" ueber den Export-Button die Cookies dieser Seite in den normalen
echo    Downloads-Ordner herunterladen.
echo 2. URL der Webseite aus dem Browser kopieren.
echo Beachte: das "http://" oder "https://" muss enthalten sein.
echo Beispiel: https://www.beispiel-notar.de
echo 3. Url hier einfuegen.
echo 4. Enter druecken.
echo 5. Das Skript arbeitet und laesst den WEC zweimal laufen.
echo 6. Danach beendet sich das Programm und dieses Fenster schliesst sich.
echo 7. Die Ergebnisse findest du in den Ordnern "output" und "output-with-cookies"
echo    auf deinem Desktop.
echo.
echo.
set /p url="Maus in dieses Fenster bewegen und ein mal die rechte Maustaste druecken, um die URL einzufuegen und dann ENTER druecken "

::===================================================================
:: Durchlauf 1: normaler Scan ohne Cookies
::===================================================================
echo.
echo ======================================================================================================================
echo DURCHLAUF 1 von 2: normaler Scan (ohne Cookies)
echo ======================================================================================================================

::Führe den WEC aus
::(call ist hier zwingend noetig: website-evidence-collector ist selbst eine .cmd-Datei,
:: ohne call kehrt die Kontrolle nie zu diesem Skript zurueck)
call website-evidence-collector %url% --overwrite

::===================================================================
:: Durchlauf 2: Scan mit vorab akzeptierten Cookies
::===================================================================
echo.
echo ======================================================================================================================
echo DURCHLAUF 2 von 2: Scan mit Cookie-Zustimmung
echo ======================================================================================================================

::Hostnamen aus der eingegebenen URL herausloesen (z.B. "www.notardeboer.de" aus
::"https://www.notardeboer.de/"), um gleich NUR nach einer zu dieser Website
::passenden Cookie-Datei zu suchen - nicht nach irgendeiner beliebigen
set "urlhost=%url%"
set "urlhost=%urlhost:https://=%"
set "urlhost=%urlhost:http://=%"
for /f "delims=/" %%h in ("%urlhost%") do set "urlhost=%%h"

::Neueste zu dieser Website passende Cookie-Datei im Downloads-Ordner suchen
::(Muster "%urlhost%_cookies*.txt" deckt von Windows bei Namenskollisionen
:: automatisch angehaengte " (1)", " (2)" usw. ab; sortiert nach Aenderungsdatum
:: absteigend, damit bei mehreren alten Exporten immer der neueste genommen wird.
:: Die Extension "Get cookies.txt LOCALLY" benennt ihre Exporte immer nach dem
:: Hostnamen der Seite, auf der man exportiert hat - daher reicht dieser
:: einfache Namensabgleich, um eine Cookie-Datei der falschen Website zu
:: erkennen und nicht versehentlich zu verwenden)
set "COOKIEFILE="
for /f "delims=" %%f in ('dir /b /o-d "%USERPROFILE%\Downloads\%urlhost%_cookies*.txt" 2^>nul') do (
    if not defined COOKIEFILE set "COOKIEFILE=%USERPROFILE%\Downloads\%%f"
)

if not defined COOKIEFILE (
    set "ANYCOOKIEFILE="
    for /f "delims=" %%f in ('dir /b /o-d "%USERPROFILE%\Downloads\*_cookies*.txt" 2^>nul') do (
        if not defined ANYCOOKIEFILE set "ANYCOOKIEFILE=%%f"
    )
    echo.
    if defined ANYCOOKIEFILE (
        echo %ESC%[38;2;255;140;0mHINWEIS: Es wurde eine Cookie-Datei gefunden ^(!ANYCOOKIEFILE!^), aber sie passt
        echo nicht zu der gerade eingegebenen Website ^(%urlhost%^). Vermutlich noch eine
        echo alte Datei von einer frueher getesteten Seite.
    ) else (
        echo %ESC%[38;2;255;140;0mHINWEIS: Keine Cookie-Datei im Downloads-Ordner gefunden.
    )
    echo Durchlauf 2 wird uebersprungen. Durchlauf 1 ^(ohne Cookies^) wurde trotzdem
    echo bereits durchgefuehrt, die Ergebnisse dazu liegen im Ordner "output".
    echo.
    echo Falls gewuenscht: mit der Extension "Get cookies.txt LOCALLY" die Cookies
    echo dieser Seite exportieren und das Skript danach erneut starten.%ESC%[0m
    goto :ende
)

::Frischeprüfung: die gefundene Cookie-Datei darf hoechstens 2 Stunden alt sein,
::damit nicht versehentlich ein laengst veralteter Export fuer diese Website
::verwendet wird. Das Alter wird ueber PowerShell berechnet, da reine
::Batch-Datumsarithmetik je nach Windows-Ländereinstellung unzuverlaessig ist.
for /f %%a in ('powershell -NoProfile -Command "[int]((Get-Date) - (Get-Item '!COOKIEFILE!').LastWriteTime).TotalMinutes"') do set "COOKIEFILE_AGE_MIN=%%a"

::Ist die Datei aelter als 2 Stunden, wird Durchlauf 2 NICHT abgebrochen - der
::Auditor weiss oft selbst, ob sich die Website seit dem letzten Export
::veraendert hat. Stattdessen nur ein bestaetigungspflichtiger Hinweis, damit
::er bewusst entscheidet statt es zu uebersehen.
if !COOKIEFILE_AGE_MIN! GTR 120 (
    echo.
    echo %ESC%[38;2;255;140;0mHINWEIS: Die gefundene Cookie-Datei ^(!COOKIEFILE!^) ist bereits
    echo !COOKIEFILE_AGE_MIN! Minuten alt ^(aelter als 2 Stunden^).
    echo.
    echo Falls sich diese Website seitdem NICHT veraendert hat, kannst du einfach
    echo fortfahren. Falls du dir nicht sicher bist: dieses Fenster schliessen,
    echo eine frische Cookie-Datei exportieren und das Skript erneut starten.%ESC%[0m
    echo.
    set /p "_confirm=Druecke ENTER, um trotzdem mit dieser Cookie-Datei fortzufahren... "
)

echo.
echo Verwende Cookie-Datei: !COOKIEFILE!
echo.

::Führe den WEC aus, mit vorab gesetzten Cookies und eigenem Ausgabeordner (ueberschreibt NICHT
::den Ordner "output" von Durchlauf 1)
::(call auch hier zwingend noetig - sonst wird !COOKIEFILE! nicht korrekt an node
:: weitergereicht und WEC erkennt die Cookie-Datei nicht)
echo Aufruf: website-evidence-collector %url% --overwrite --output output-with-cookies --set-cookie "!COOKIEFILE!"
call website-evidence-collector %url% --overwrite --output output-with-cookies --set-cookie "!COOKIEFILE!"

:ende
::Fenster offen halten, damit eine eventuelle Fehlermeldung lesbar bleibt
::(ohne dieses schliesst sich das Fenster bei einem Fehler sofort wieder;
:: eigener Prompt statt "pause", damit kein "Sie" von Windows reinrutscht)
echo.
set /p "_ende=Druecke ENTER zum Beenden... "

::"set /p" setzt bei leerer Eingabe (nur ENTER) selbst einen Exit-Code von 1.
::Da das die letzte Zeile ist, wuerde dieser Exit-Code sonst zum Exit-Code des
::gesamten Skripts werden - manche Terminals (z.B. VS Code) zeigen dann eine
::"fehlgeschlagen"-Meldung statt sauber zu schliessen. Deshalb hier explizit
::auf 0 zuruecksetzen.
exit /b 0
