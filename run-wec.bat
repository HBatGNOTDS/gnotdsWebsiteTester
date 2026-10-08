::<by Hannes Breuer, GNotDS, hannes.breuer@gnotds.de, 2025>

::Dieses Skript öffnet den Website Evidence Collector und lässt ihn auf eine abgefragte URL starten
::Website Evidence Collector muss extra installiert werden: https://code.europa.eu/EDPS/website-evidence-collector



@echo off
::Ins Verzeichnis dieser Datei wechseln, egal wie das Skript gestartet wurde
::(Doppelklick setzt das automatisch, Start ueber die Windows-Suche z.B. nicht)
cd /d "%~dp0"
echo ======================================================================================================================
echo.
echo.
echo WILLIKOMMEN BEI UNSEREM WEBSEITENTESTTOOL
echo.
echo.
echo ======================================================================================================================
echo.
echo.
echo Anleitung
echo.
echo 1. URL der Webseite aus dem Browser kopieren.
echo Beachte: das "http://" oder "https://" muss enthalten sein.
echo Beispiel: https://www.beispiel-notar.de
echo 2. Url hier einfuegen.
echo 3. Enter druecken.
echo 4. Das Skript arbeitet.
echo 5. Danach beendet sich das Programm und dieses Fenster schliesst sich.
echo 6. Die Ergebnisse findest du im Ordner namens "output" auf deinem Desktop.
echo.
echo.
set /p url="Maus in dieses Fenster bewegen und ein mal die rechte Maustaste druecken, um die URL einzufuegen und dann ENTER druecken "

::Öffne Ordner mit den Ergebnissen im Explorer
%SystemRoot%\explorer.exe ".\output"

::Führe den WEC aus
website-evidence-collector %url% --overwrite