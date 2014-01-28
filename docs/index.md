---
title: MediaCategorizer
subtitle: Projekt-Website
...

![][logo]

Eine Windows-Anwendung zur Verschriftlichung und Kategorisierung von Videos mit gesprochenem Inhalt.

Diese Anwendung ist das Ergebnis eines Forschungsprojektes an der [Fachhochschule Brandenburg][fhb] mit dem Namen "Online Lehr- und Lernhilfsmittel" (OLL). Das Projekt wurde gefördert mit Mitteln des Europäischen Fonds für Regionalentwicklung (EFRE) in der Bewirtschaftung des MWFK Programms "e-learning und e-knowledge".

**Projektleiter:** Friedhelm Mündemann <muendemann@fh-brandenburg.de>  
**Mitarbeiter:** Tobias Kiertscher <kiertscher@fh-brandenburg.de>  
**Bearbeitungszeit:** 07.2013 - 01.2014  

**Download:** <https://github.com/mastersign/mediacategorizer/releases>  
**Quelltexte:** <https://github.com/mastersign/mediacategorizer>  
**Lizenz:** [MIT License][mit-lic]  

# Funktionalität

* Die Tonspur aus einer Anzahl von Videos herauslösen
* und diese mit Hilfe eines Spracherkennungssystems verschriftlichen
* Eine Gruppe von Kategorien durch Beispieltexte definieren
* Die Videos den Kategorien zuordnen
* Die Ergebnisse als XML und als HTML5-WebSite ausgeben

# Dokumentation

* [Forschungsbericht][report]
* [Benutzerhandbuch][handbook]
* [Sprecherprofilverwaltung][profiles]
* [Systemarchitektur][architecture]
* [Ergebniswebseitenstruktur][site-structure]
* [Intermediate Data Structures][intermediates]

# Screenshots

![Die Fortschrittsanzeige während der Bearbeitung eines Projektes][ui-page-process]

![Die Details eines erkannten Wortes][video-word]

![Die Übereinstimmungsmatrix zwischen Kategorien und Videos][matrix]

---

Copyright &copy; Tobias Kiertscher, Fachhochschule Brandenburg 2014.

[logo]: images/MediaCategorizer.png
[ui-page-process]: images/ui-page-process.png
[video-word]: images/video_word.png
[matrix]: images/matrix.png

[report]: Forschungsergebnisse.html
[handbook]: Benutzerhandbuch.html
[profiles]: Sprecherprofilverwaltung.html
[architecture]: Systemarchitektur.html
[site-structure]: Webseitenstruktur.html
[intermediates]: intermediate-data-structures.html

[fhb]: http://www.fh-brandenburg.de/
[mit-lic]: http://opensource.org/licenses/MIT


*[EFRE]: Europäischer Fonds für regionale Entwicklung
*[MWFK]: Ministerium für Wissenschaft, Forschung und Kultur
*[HTML]: Hyper Text Markup Language
*[XML]: eXtensible Markup Language