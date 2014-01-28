MediaCategorizer
================

![MediaCategorizer][logo]

Eine Windows-Anwendung zur Verschriftlichung und Kategorisierung von Videos mit gesprochenem Inhalt.

Diese Anwendung ist das Ergebnis eines Forschungsprojektes an der [Fachhochschule Brandenburg][fhb] mit dem Namen "Online Lehr- und Lernhilfsmittel" (OLL). Das Projekt wurde gefördert mit Mitteln des Europäischen Fonds für Regionalentwicklung (EFRE) in der Bewirtschaftung des MWFK Programms "e-learning und e-knowledge".

* **Projektleiter:** Friedhelm Mündemann <muendemann@fh-brandenburg.de>
* **Mitarbeiter:** Tobias Kiertscher <kiertscher@fh-brandenburg.de>
* **Bearbeitungszeit:** 07.2013 - 01.2014

Funktionalität
--------------

* Die Tonspur aus einer Anzahl von Videos herauslösen
* und diese mit Hilfe eines Spracherkennungssystems verschriftlichen
* Eine Gruppe von Kategorien durch Beispieltexte definieren
* Die Videos den Kategorien zuordnen
* Die Ergebnisse als XML und als HTML5-WebSite ausgeben

Komponenten
-----------

MediaCategorizer besteht aus den folgenden Komponenten:

* Benutzeroberfläche: [MediaCategorizer - UI][mc-ui]
* Spracherkennung: [MediaCategorizer - Transcripter][mc-transcripter]
* Analyse und Visualisierung: [MediaCategorizer - Distillery][mc-distillery]

Darüber hinaus werden die folgenden externen Werkzeuge benutzt:

* [FFmpeg][ffmpeg]
* [Microsoft Speech API][mssapi] (SAPI 5.4 in Microsoft Windows 7)
* [WaveViz][waveviz]

Außer der Microsoft Speech API, welche durch Transcripter gekapselt wird, besitzen alle Komponenten eine Befehlszeilenschnittstelle. Die Benutzeroberfläche von MediaCategorizer nutzt für die Ansteuerung der Komponenten einheitlich die Befehlszeilenschnittstelle. Dadurch können die einzelnen Komponenten auch in anderen Prozessen eingesetzt werden.

Technologien
------------

Die Benutzeroberfläche und die Ansteuerung der Microsoft Speech API wurde in [C#][csharp] implementiert. Die Analyse und Visualisierung wurden in [Clojure][clj] implementiert. Der Datenaustausch zwischen den Komponenten findet über [EDN][edn] statt. Zur Automatisierung wurden [PowerShell][ps]-Scripte verwendet. Für die Dokumentation wurden [Markdown][md] und [pandoc][pandoc] verwendet.

Screenshots
-----------

![Benutzeroberfläche][ui-page-process]

_Die Fortschrittsanzeige während der Bearbeitung eines Projektes_

![Wort in einem Video][video-word]

_Die Details eines erkannten Wortes_

![Übereinstimmungsmatrix][matrix]

_Die Übereinstimmungsmatrix zwischen Kategorien und Videos_


[fhb]: http://www.fh-brandenburg.de/
[ffmpeg]: http://www.ffmpeg.org
[mssapi]: http://msdn.microsoft.com/de-de/library/ee125077.aspx
[waveviz]: http://waveviz.codeplex.com/
[mc-ui]: http://github.com/mastersign/mediacategorizer-ui
[mc-transcripter]: http://github.com/mastersign/mediacategorizer-transcripter
[mc-distillery]: http://github.com/mastersign/mediacategorizer-distillery
[edn]: https://github.com/edn-format/edn
[csharp]: http://msdn.microsoft.com/de-de/library/kx37x362.aspx
[clj]: http://clojure.org/
[ps]: http://technet.microsoft.com/de-de/scriptcenter/dd742419
[md]: http://daringfireball.net/projects/markdown/
[pandoc]: http://johnmacfarlane.net/pandoc/

[logo]: docs/images/MediaCategorizer.png
[ui-page-process]: docs/images/ui-page-process.png
[video-word]: docs/images/video_word.png
[matrix]: docs/images/matrix.png
