# gnotdsWebsiteTester

Unser Tool zum Testen von Webseiten. Es bietet ein zusätzliches Frontend für den Website Evidence Collector. Diese Dokumentation liefert zusätzöiche Hinweise zur Installation und zum Betrieb.

## Hinweise für den Nutzer ##

* Eigentlich erklärt unser Skript alle Einzelschritte. Aber es sollte trotzdem erwähnt sein, dass der Webseite Evidence Collector die Ergebnisse immer in den selben Ordnern `\output` und `\output-with-cookies` ablegt. **Lasse ich das Skript erneut laufen, werden alte Ergebnisse überschrieben.** Möchte man also mehrere Webseiten nacheinander prüfen, muss man die Ergebnisse (z.B. die Datei `inspection.json`) immer erst manuell aus dem Ordner kopieren.
* Nach dem Durchlaufen des Skriptes die entsprechenden Dateien im Odoo hochladen.
* Sollten Fehler beim Durchlaufen des WEC geworfen werden, kann man sich die gesamte Konsolenausgabe nach Durchlaufen des Programms anzeigen lassen, da im `\output`-Ordner die Datei `inspection.log` angelegt wird.

## Administration
Die Installationsanleitung findet sich in [dieser Datei](install.md)

### Website Evidece Collector Quellen
Es gibt mehrere Seiten, auf denen man den WEC finden kann.

* Die zentrale Stelle (zu bevorzugen) ist das [Öffentliche Git auf code.europa.eu](https://code.europa.eu/EDPS/website-evidence-collector). Hier wird man immer die tagesaktuelle Version der Software finden.

* Die ["offizielle" Internetseite des Programms](https://www.edps.europa.eu/edps-inspection-software_en) beim Europäischen Datenschutzbeauftragten ist auf Englisch und hat immer nur die aktuellste Version der Software hinter dem Downloadbutton. (nicht benötigt, da wir über Befehl installieren)

* Alternativ kann die Software in unterschiedlichen Versionen von der Webseite [Interoperable Europe](https://interoperable-europe.ec.europa.eu/collection/free-and-open-source-software/solution/website-evidence-collector) herunter geladen werden. Sehr hilfreich, wenn man eine ganz bestimmte Version haben möchte.

⚠️ **Achtung:** Google findet auch immer ein [öffentliches GitHub-Repository](https://github.com/EU-EDPS/website-evidence-collector). Dieses ist veraltet! Das Projekt ist auf das EU-eigene GitLab (erster Link oben) umgezogen. Im GitHub findet man nur eine veraltete Version mit Stand Juni 2024. **Diese Quelle also nicht verwenden!**

Dies sind nur die Quellen, aber eigentlich benötigt man diese Internetseiten gar nicht: Der WEC wird immer aus der Konsole heraus installiert.

### Planned Features ##

* Weil Windows doof ist musste das Ganze erstmal als Batch-Datei erstellt werden. Nice-to-have wäre ein Python-Programm, das ein wirkliches Frontend anbietet. (unnötig, wenn das Skript später aus anderer Software heraus ausgeführt werden soll)
