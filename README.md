MediaCategorizer
================

![MediaCategorizer][logo]

Eine Windows-Anwendung zur Verschriftlichung und Kategorisierung von Videos mit gesprochenem Inhalt.

Dieses Projekt ist das Ergebnis eines Forschungsprojektes an der [Fachhochschule Brandenburg][fhb] mit dem Namen OLL - "Online Lehr- und Lernmittel".

* **Projektleiter:** Friedhelm Mündemann <muendema@fh-brandenburg.de>
* **Mitarbeiter:** Tobias Kiertscher <kiertscher@fh-brandenburg.de>
* **Bearbeitungszeit:** 07.2013 - 01.2014

Funktionalität
--------------

* Die Tonspur aus einer Anzahl von Videos herauslösen
* und diese mit Hilfe eines Spracherkennungssystems verschriftlichen
* Eine Gruppe von Kategorien durch Beispieltexte definieren
* Die Videos den Kategorien zuordnen
* Die Ergebnisse als XML und als WebSite ausgeben

Komponenten
-----------

MediaCategorizer besteht aus den folgenden Komponenten:

* [Benutzeroberfläche][mc-ui]
* [Spracherkennung][mc-transcripter]
* [Analyse und Visualisierung][mc-distillery]

Darüber hinaus werden die folgenden externen Werkzeuge benutzt:

* [FFmpeg][ffmpeg]
* [Microsoft Speech API][mssapi] (SAPI 5.4 in Microsoft Windows 7)
* [WaveViz][waveviz]

Screenshots
-----------

![Benutzeroberfläche][ui-page-process]

_Die Fortschrittsanzeige während der Bearbeitung eines Projektes_

![Übereinstimmungsmatrix][matrix]

_Die Übereinstimmungsmatrix zwischen Kategorien und Videos_


[fhb]: http://www.fh-brandenburg.de/
[ffmpeg]: http://www.ffmpeg.org "FFmpeg"
[mssapi]: http://msdn.microsoft.com/de-de/library/ee125077.aspx "Microsoft Speech API"
[waveviz]: http://waveviz.codeplex.com/
[mc-ui]: http://github.com/mastersign/mediacategorizer-ui
[mc-transcripter]: http://github.com/mastersign/mediacategorizer-transcripter
[mc-distillery]: http://github.com/mastersign/mediacategorizer-distillery

[logo]: docs/images/MediaCategorizer.png
[ui-page-process]: docs/images/ui-page-process.png
[video-word]: docs/images/video_word.png
[matrix]: docs/images/matrix.png
