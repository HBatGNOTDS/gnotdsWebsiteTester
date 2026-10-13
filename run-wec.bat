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

::Neueste exportierte Cookie-Datei im Downloads-Ordner suchen
::(Muster *_cookies*.txt deckt sowohl den Hostnamen im Dateinamen als auch von Windows bei
:: Namenskollisionen automatisch angehaengte " (1)", " (2)" usw. ab; sortiert nach Aenderungsdatum
:: absteigend, damit bei mehreren alten Exporten immer der neueste genommen wird)
set "COOKIEFILE="
for /f "delims=" %%f in ('dir /b /o-d "%USERPROFILE%\Downloads\*_cookies*.txt" 2^>nul') do (
    if not defined COOKIEFILE set "COOKIEFILE=%USERPROFILE%\Downloads\%%f"
)

if not defined COOKIEFILE (
    echo.
    echo HINWEIS: Keine Cookie-Datei im Downloads-Ordner gefunden.
    echo Durchlauf 2 wird uebersprungen. Durchlauf 1 ^(ohne Cookies^) wurde trotzdem
    echo bereits durchgefuehrt, die Ergebnisse dazu liegen im Ordner "output".
    echo.
    echo Falls gewuenscht: mit der Extension "Get cookies.txt LOCALLY" die Cookies
    echo dieser Seite exportieren und das Skript danach erneut starten.
    goto :ende
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
