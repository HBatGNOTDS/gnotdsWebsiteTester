# Installationshinweise WEC

Die Installationsanleitung für den WEC im offiziellen Repo beschränkt sich auf Linux-Systeme und ist nicht 1:1 auf Windows anwendbar. Hier ist die angepasste Installationsanleitung.

#### 0. Dieses Repo herunterladen
* Dieses Repo als ```.zip``` herunterladen.

## Abhängigkeiten installieren

#### 1. Auf dem Gerät muss Node.js installiert sein
* Node-Installer herunterladen: https://nodejs.org/en/download 
* Bei der Installation darauf achten, dass NPM mit installiert wird (vorausgewählt).
* Bei ```Automatically install the necessary tools. ...``` muss ein Häkchen gesetzt werden.
* Nach dem Durchlaufen des Windows Installers für Node.js öffnet sich eine Powershell für die Installation der zusätzlichen Softwarepackages. Einfach durchklicken.

#### 2. Git installieren
* Damit der WEC nachher aus dem Git-Repository installiert werden kann, muss Git installiert sein: https://git-scm.com/downloads
* einfach durch den Installer klicken, hier ist nichts weiter zu beachten.

#### 3. Überprüfen ob die Installation geklappt hat
* im Terminal ```node -v```, ```npm -v```, ```git -v``` eingeben und schauen, ob für alle eine Versionsnummer zurück kommt. Dann hat die Installation geklappt.

## WEC installieren

#### 4. EDPS dem Nodepackage hinzufügen
* im Ordner ```C:\Users\<Username>\``` muss die Datei ```.npmrc``` abgelegt werden. 
* Die Datei findet sich im heruntergeladenen Zip dieses Repos.
* Sollte diese Datei noch nicht dort sein, einfach die Datei aus diesem Repo herunterladen. Achtung: Nicht als ```.txt```!

#### 5. WEC installieren
* folgenden Befehl als Nutzer, nicht als Admin, im Terminal ausführen: 
```bash
npm install --global @EDPS/website-evidence-collector
```
* Zuschauen und staunen. (es passiert quasi gar nix)

#### 6. Installation testen
* Nach dem Abschluss der Installation einfach folgenden Befehl in ein Terminal kopieren und mit Enter bestätigen:
```
website-evidence-collector http://www.gnotds.de --overwrite
```
* Danach sollte im Ordner ```C:\Users\<Username>\output``` eine aktuelle Überprüfung unserer Webseite sichtbar sein.

## Unser Skript hinzufügen

#### 7. Unser Skript startklar machen
* Kopiere die Datei ```run-wec.bat``` aus dem Zip-Ordner auf den Desktop.

#### 8. Testlauf
* Doppelklick auf die ```run-wec.bat```-Datei öffnet ein Terminal.
* einfach irgendeine Webseite testen, z.B. einfach diese URL hineinkopieren:
```
https://www.google.de
```
* das Ergebnis wird im Ordner ```\output\``` abgelegt. Der Ordner wird in dem Ordner erzeugt, in dem auch die Datei ```run-wec.bat``` liegt, also z.B. auf dem Desktop.
* Hinweis: Da der Ordner ```\output``` bis zum erstmaligen Ausführen der ```run-wec.bat``` noch nicht existierte wird jetzt ein Explorer-Fenster mit dem Ordner "Eigene Dokumente" angezeigt. Bei jedem weiteren Durchlauf wird der Ordner ```\output``` mit den Ergebnissen angezeigt werden.