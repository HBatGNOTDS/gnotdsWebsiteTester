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

## Alte Installation des WEC deinstallieren

Möchte ich eine cleane Installation ohne irgendwelche alten Dependencies oder dergleichen kann es sinnvoll sein, die alte Installation des WEC vor der Installation einer neuen Version zu deinstallieren.

#### 1. WEC-Paket entfernen

```bash
npm uninstall -g @EDPS/website-evidence-collector
```

#### 2. Prüfen, ob es wirklich weg ist
```bash
npm list -g --depth=0
where website-evidence-collector
```
Die Konsole sollte "nicht gefunden" ausgeben

#### Optional, nur für eine komplett saubere Neuinstallation

z. B. bei Verdacht auf eine kaputte Browser-Version: den Browser-Cache zusätzlich löschen.
```bash
%USERPROFILE%\.cache\puppeteer\
```
Jetzt einfach neu installieren.

## WEC installieren

#### 1. EDPS dem Nodepackage hinzufügen
* im Ordner ```C:\Users\<Username>\``` muss die Datei ```.npmrc``` abgelegt werden. 
* Die Datei findet sich im heruntergeladenen Zip dieses Repos.
* Sollte diese Datei noch nicht dort sein, einfach die Datei aus diesem Repo herunterladen. Achtung: Nicht als ```.txt```!

#### 2. WEC installieren
* folgenden Befehl als Nutzer, nicht als Admin, im Terminal ausführen: 
```bash
npm install --global @EDPS/website-evidence-collector
```
* Zuschauen und staunen. (es passiert quasi gar nix)

#### 3. Installation testen
* Nach dem Abschluss der Installation einfach folgenden Befehl in ein Terminal kopieren und mit Enter bestätigen:
```
website-evidence-collector http://www.gnotds.de --overwrite
```
* Danach sollte im Ordner ```C:\Users\<Username>\output``` eine aktuelle Überprüfung unserer Webseite sichtbar sein.

## Unser Skript hinzufügen

#### 1. Unser Skript startklar machen
* Kopiere die Datei ```run-wec.bat``` aus dem Zip-Ordner auf den Desktop.
* Installiere die notwendige Browser-Extension ["Get cookies.txt LOCALLY" für Chrome aus dem Chrome Web Store](https://chromewebstore.google.com/detail/get-cookiestxt-locally/cclelndahbckbenkjhflpdbgdldlbecc) und aktiviere diese. Am besten auch die Stecknadel anklicken, damit der User nachher ganz einfach die Extension findet.

#### 2. Testlauf
* Bitte kopiere die folgende URL: 
```
https://www.google.de
```
* besuche die Internetseite und klicke die Extension an. Klicke dann auf den Button "Export" um die Liste aller Cookies der Webseite lokal abzuspeichern.
* Doppelklick auf die ```run-wec.bat```-Datei auf dem Desktop öffnet ein Terminal.
* einfach die URL hineinkopieren.
* Mit ENTER bestätigen.
* das Ergebnis wird in den Ordnern ```\output\``` und ```\output-with-cookies\``` abgelegt. Diese Ordner werden am selben Ort erzeugt, an dem sich auch die Datei ```run-wec.bat``` befindet, also z.B. auf dem Desktop.