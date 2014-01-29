---
title: MediaCategorizer
subtitle: Systemarchitektur
author: Tobias Kiertscher
creator:
- role: Autor
  name: Tobias Kiertscher
  affiliation: Fachhochschule Brandenburg
  email: kiertscher@fh-brandenburg.de
version: 0.3.0
date: 30.01.2014
lang: de
...

Dieses Dokument beschreibt die Entwicklungsumgebung und die Architektur von *MediaCategorizer*. Es soll Softwareentwicklern helfen die Software zu verstehen und somit eine Anpassung und Erweiterung unterstützen. 

# Komponenten
Das Projekt setzt sich aus den folgenden Komponenten zusammen:

* Hauptprojekt *MediaCategorizer*
* Benutzeroberfläche *MediaCategorizer - UI*
* Tonspurextraktion *FFmpeg* (extern) 
* Wellenformvisualisierung *WaveViz* (extern)
* Spracherkennung *MediaCategorizer - Transcripter*
* Analyse und Visualisierung *MediaCategorizer - Distillery*
* Wortwolkengenerierung *Mastersign Cloud*

Das Hauptprojekt dient als Startpunkt. Es enthält die Dokumentation und eine Anzahl von Scripts zur Automatisierung des Projektes. Durch die Automatisierung werden die folgenden Aktionen unterstützt:

* Download der externen Komponenten *FFmpeg* und *WaveViz*
* Erzeugen der Dokumentation im HTML- und DOCX-Format aus den Markdown-Quelldateien
* Klonen der Komponenten-Repositories *UI*, *Transcripter* und *Distillery*
* Kompilieren der Komponenten
* Zusammenstellen eines lauffähigen Programmpakets

Die Benutzeroberfläche ermöglicht das benutzerfreundliche Verwalten von Projekten (Videos, Kategorien, Parameter). Sie ist für die Koordination der Prozessausführung verantwortlich und nutzt die übrigen Komponenten über deren Befehlszeilenschnittstelle.

Die Tonspurextraktion löst aus den Videos die Tonspur heraus und konvertiert sie in ein Format, das von der Komponente zur Wellenformvisualisierung und der Komponente zur Spracherkennung unterstützt wird.

Die Wellenformvisualisierung erzeugt aus der extrahierten Tonspur eine bildliche Darstellung des Tonsignals. Dieses wird in der HTML5-Ausgabe eingebunden und dient der Veranschaulichung der Dynamik des Tonsignals.

Die Spracherkennung steuert die Microsoft Speech API an und speichert die Spracherkennungsergebnisse als Zwischenergebnis in einer EDN-Datei, welche von der Komponente für Analyse und Visualisierung gelesen werden kann.

Die Komponente für Analyse und Visualisierung filtert zunächst die erkannten Worte und bildet anschließend für Videos und Kategorien Worthäufigkeitslisten. Diese werden in Form von Wortwolken visualisiert. Aus den Worthäufigkeitslisten von Videos und Kategorien werden die Übereinstimmungen zwischen Videos und Kategorien berechnet. Aus den Übereinstimmungen werden dann Zuordnungen zwischen Videos und Kategorien abgeleitet. Die Ergebnisse (einschließlich der erkannten Worte mit ihren Erkennungssicherheiten) werden in Form einer XML-Datei gespeichert.  Zusätzlich werden die Volltexte der einzelnen Videos als Reintext gespeichert. Abschließend wird eine statische HTML5-Webseite generiert welche alle Ergebnisse visuell aufbereitet darstellt, die Original-Videodateien einbindet und eine interaktive Navigation zwischen den Analyseergebnissen erlaubt. Diese Webseite kann sowohl lokal gespeichert und direkt mit einem Browser betrachtet werden, sie kann aber auch mit Hilfe eines Webservers gehostet und so über das Internet verfügbar gemacht werden. 

# Entwicklungsumgebung
MediaCategorizer wurde mit C# in Visual Studio 2013 und Clojure in LightTable 0.5 implementiert. Deshalb benötigt das Projekt sowohl die Microsoft .NET Laufzeitumgebung als auch die Java Laufzeitumgebung. C# wurden gewählt, weil es mit der WPF-Bibliothek eine schnelle Entwicklung der Benutzeroberfläche und durch die .NET-Schnittstelle eine einfache Anbindung an die Microsoft Speech API ermöglicht. Clojure wurde gewählt, weil das funktionale Programmierparadigma, die komfortablen Bibliotheken für Webseitenerzeugung und die interaktive Entwicklungsumgebung (REPL) eine schnelle Umsetzung der Analyse und Visualisierung ermöglichen. Für die Projektautomatisierung wird die Microsoft PowerShell eingesetzt.

**Voraussetzungen:**

* Microsoft Windows 7 Professional/Enterprise mit Service Pack 1 oder höher
* [Git][git]
* [Microsoft PowerShell 3][ps3] oder höher (in Windows 8 bereits enthalten)
* [pandoc 1.12][pandoc] oder höher  
  _(für das Generieren der Dokumentation aus den Markdown-Quellen erforderlich)_
* [Microsoft .NET Framework 4.5][clr] oder höher (in Windows 8 bereits enthalten)
* [Microsoft Visual Studio 2012][vs] oder höher  
  _(für die Anpassung oder Weiterentwicklung von MediaCategorizer oder Transcripter erforderlich)_
* [Java Development Kit 7][jdk] oder höher

## Hauptprojekt

**Projektname:** MediaCategorizer  
**Repository:** <https://github.com/mastersign/mediacategorizer/>  
**Verzeichnis:** `/`  

### Merkmale

* Einstiegspunkt
* Dokumentation
* Skripte für das Bauen des Projektes

### Setup

1. Installieren der [Voraussetzungen](#voraussetzungen)

	Für das Kompilieren der Komponenten müssen mindestens .NET 4.5, JDK 7 und PowerShell 3 installiert sein. Für das Erzeugen der Projektdokumentation in HTML und DOCX müssen mindestens PowerShell 3 und pandoc installiert sein.

2. Klonen des Hauptprojektes in ein lokales Repository

	Befehlszeile mit git in `PATH` öffnen und `> git clone https://github.com/mastersign/mediacategorizer.git D:\MediaCategorizer` ausführen.
	Der Pfad `D:\MediaCategorizer` kann bei Bedarf angepasst werden.
 
4. Erzeugen der Projektdokumentation in HTML und DOCX

	In das Verzeichnis `auto` wechseln und die Windows-Batch-Datei `transform-all-documents.bat` ausführen.
	Der Vorgang wird in der Datei `transform-all-documents.log` protokolliert.

	War die Ausführung des Skripts erfolgreich, wurden für jede Markdown-Datei aus dem Verzeichnis `docs` je eine HTML-Datei und eine DOCX-Datei im Verzeichnis `docs\out` erzeugt. Für die HTML-Dateien wurde zusätzlich das Verzeichnis `docs\images` nach `docs\out\images` kopiert.

3. Herunterladen der externen Programme, klonen der Komponenten-Repositories, bauen der Komponenten

	In das Verzeichnis `auto` wechseln und die Windows-Batch-Datei `update-build-release.bat` ausführen.
	Der Vorgang wird in der Datei `update-build-release.log` protokolliert.

	Die einzelnen Schritte `Update-Tools.ps1`, `Update-Components.ps1`, `Build-Project.ps1` und `Create-Release.sp1` können auch einzeln ausgeführt werden. Es muss aber berücksichtigt werden, dass die Ausführungsrichtlinie der PowerShell von `Restricted` auf `RemoteSigned` oder `Unrestricted` gesetzt werden muss. Dazu muss die PowerShell mit Administrationsrechten gestartet werden und der Befehl `> Set-ExecutionPolicy RemoteSigned -Force` ausgeführt werden.

	War die Ausführung des Skripts erfolgreich, wurde im Verzeichnis `release` ein vollständiges Paket mit MediaCategorizer und allen erforderlichen Abhängigkeiten zusammengestellt.

	Um MediaCategorizer in Betrieb zu nehmen sind die Anweisungen im [Benutzerhandbuch][handbook] Abschnitt *Installation* zu beachten.

## Benutzeroberfläche

**Projektname:** MediaCategorizer - UI  
**Repository:** <https://github.com/mastersign/mediacategorizer-ui/>  
**Verzeichnis:** `/components/MediaCategorizer`  
**Projekt-Typ:** Microsoft Visual Studio  
**Programmiersprache:** C# 5.0  
**Plattform, Bibliotheken:** .NET 4.5, WPF, Xceed WPF-Toolkit, Windows API CodePack  

### Merkmale

* Einfache Bedienung
* Verwaltung eines Projektes (Videos, Kategorien, Parameter)
* Ansteuerung von FFmpeg, WaveViz, Transcripter und Distillery über die Befehlszeile
* Überwachung der Prozessausführung

### Architektur

Der Quellcode der Benutzeroberfläche teilt sich in die folgenden Namensräume auf (siehe [#img:ui-ns]).

![#img:ui-ns Namesräume der Benutzeroberfläche][ui-ns]

#### `de.fhb.oll.mediacategorizer`

Dieser Namensraum enthält die `App`-Klasse welche den Programmstart initiiert, das Hauptfenster `MainWindow` und die verschiedenen Seiten `Page*` (siehe [#img:ui-ui]). 

![#img:ui-ui Die Klassen des Hauptfensters und der Seiten][ui-ui]

#### `de.fhb.oll.mediacategorizer.edn`

Dieser Namensraum enthält die Schnittstelle `IEdnWritable` und einige Hilfsklassen für das Erzeugen von EDN-Dateien.  

#### `de.fhb.oll.mediacategorizer.model`

Dieser Namensraum enthält die Domain-Modell-Klassen `Project`, `Category`, `Media`, `Configuration` und alle Klassen die für deren Definition benötigt werden (siehe [#img:project] und [#img:configuration]).

![#img:project Das Domain-Modell für ein Projekt][ui-project]

![#img:configuration Das Domain-Modell für die Projektparameter][ui-configuration]

Die Klassen in diesem Namensraum wird in der Datei `Model.xml` definiert und durch den Codegenerator *Scaleton* in der Datei `Model.Designer.cs` implementiert. Einige der generierten Klassen werden in eigenen Dateien um zusätzliche Funktionalität ergänzt. Die Schnittstelle `IEdnWritable` wird für alle Modell-Klassen in der Datei `EDN.cs` implementiert.

#### `de.fhb.oll.mediacategorizer.processing`

Dieser Namensraum enthält die Klassen für die verschiedenen Prozessschritte. Jeder Prozessschritt wird durch eine Klasse realisiert, welche die Schnittstelle `IProcess` implementiert (siehe [#img:ui-iprocess]). Zur Vereinfachung der Implementierung wurden gemeinsame Aspekte der Prozessschritte in den Basisklassen `ProcessBase` und `MultiTaskProcessBase` zusammengefasst (siehe [#img:process]). 

![#img:iprocess Die Schnittstelle für Prozessschritte][ui-iprocess]

![#img:process Die Basisklassen der Prozessschritte][ui-process]

Die Klasse `ProcessChain` verwaltet den gesamten Prozess und übernimmt das Starten der Prozessschritte, wenn deren Vorgänger im Prozess erfolgreich abgeschlossen wurden (siehe [#img:ui-process-chain]). 

![#img:process-chain Die zentrale Steuerung für den Prozess][ui-process-chain]

#### `de.fhb.oll.mediacategorizer.tools`

Dieser Namensraum enthält die Steuerklassen für die Komponenten, die über eine Befehlszeilenschnittstelle angesteuert werden. Die Steuerklassen sind von der gemeinsamen Basisklasse `ToolBase` abgeleitet (siehe [#img:ui-tool-base]).

* `ToolFfprobe` (siehe [#img:ui-tool-ffprobe])
* `ToolFfmpeg` (siehe [#img:ui-tool-ffmpeg])
* `ToolWaveViz` (siehe [#img:ui-tool-waveviz])
* `ToolTranscripter` (siehe [#img:ui-tool-transcripter])
* `ToolDistillery` (siehe [#img:ui-tool-distillery])

Die Steuerklassen sind für das asynchrone Verarbeiten der Komponentenausgaben verantwortlich. Die Ausgaben enthalten dabei sowohl Fortschrittsinformationen als auch Ergebnisdaten.

![#img:tool-base Die Basisklasse der Steuerklassen für Komponenten][ui-tool-base]

![#img:tool-ffprobe Die Steuerklasse für FFprobe][ui-tool-ffprobe]

![#img:tool-ffmpeg Die Steuerklasse für FFmpeg][ui-tool-ffmpeg]

![#img:tool-waveviz Die Steuerklasse für WaveViz][ui-tool-waveviz]

![#img:tool-transcripter Die Steuerklasse für Transcripter][ui-tool-transcripter]

![#img:tool-distillery Die Steuerklasse für Distillery][ui-tool-distillery]

#### `de.fhb.oll.mediacategorizer.settings`

Dieser Namensraum enthält die Klassen `Setup` und `SetupManager`, die für die Verwaltung und das Sichern und Wiederherstellen der Anwendungseinstellungen verantwortlich sind (siehe [#img:ui-setup]).

![#img:setup Das Modell für die Programmeinstellungen][ui-setup]

## Medieninspektion und Tonspurextraktion (extern)

**Projektname:** FFmpeg  
**Website:** <http://www.ffmpeg.org>

### Merkmale

* Befehlszeilenschnittstelle
* Inspektion und Transformation von Audio- und Videodaten

### Befehlszeilenschnittstelle

Das FFmpeg-Projekt umfasst die Programmdatei `ffmpeg.exe` für Transformationsaufgaben und die Programmdatei `ffprobe.exe` für Inspektionsaufgaben.

#### Inspektion

**Beispiel:** `> ffprobe.exe -i "D:\media\video.mp4"`

Die Ausgabe könnte dann z.B. wie folgt aussehen.

	ffprobe version N-58699-ge3d7a39 Copyright (c) 2007-2013 the FFmpeg developers
	  built on Dec  1 2013 22:07:24 with gcc 4.8.2 (GCC)
	  configuration: --enable-gpl --enable-version3 --disable-w32threads --enable-avisynth --enable-bzlib --enable-fontconfig --enable-frei0r --enable-gnutls --enable-iconv --enable-libass --enable-libbluray --enable-libcaca --enable-libfreetype --enable-libgsm --enable-libilbc --enable-libmodplug --enable-libmp3lame --enable-libopencore-amrnb --enable-libopencore-amrwb --enable-libopenjpeg --enable-libopus --enable-librtmp --enable-libschroedinger --enable-libsoxr --enable-libspeex --enable-libtheora --enable-libtwolame --enable-libvidstab --enable-libvo-aacenc --enable-libvo-amrwbenc --enable-libvorbis --enable-libvpx --enable-libwavpack --enable-libx264 --enable-libxavs --enable-libxvid --enable-zlib
	  libavutil      52. 56.100 / 52. 56.100
	  libavcodec     55. 44.100 / 55. 44.100
	  libavformat    55. 22.100 / 55. 22.100
	  libavdevice    55.  5.102 / 55.  5.102
	  libavfilter     3. 91.100 /  3. 91.100
	  libswscale      2.  5.101 /  2.  5.101
	  libswresample   0. 17.104 /  0. 17.104
	  libpostproc    52.  3.100 / 52.  3.100
	Input #0, mov,mp4,m4a,3gp,3g2,mj2, from 'D:\media\video.mp4':
	  Metadata:
	    major_brand     : mp42
	    minor_version   : 0
	    compatible_brands: isommp42
	    creation_time   : 2012-05-15 16:52:11
	  Duration: 01:05:51.97, start: 0.000000, bitrate: 363 kb/s
	    Stream #0:0(und): Video: h264 (Constrained Baseline) (avc1 / 0x31637661), yuv420p, 480x360, 265 kb/s, 18 fps, 18 tbr, 36 tbn, 36 tbc (default)
	    Metadata:
	      creation_time   : 1970-01-01 00:00:00
	      handler_name    : VideoHandler
	    Stream #0:1(und): Audio: aac (mp4a / 0x6134706D), 44100 Hz, stereo, fltp, 95 kb/s (default)
	    Metadata:
	      creation_time   : 2012-05-15 16:52:11
	      handler_name    : IsoMedia File Produced by Google, 5-11-2011

MediaCategorizer nutzt `ffprobe` um die Länge der Videos zu ermitteln, um daraus einen Fortschritt bei Transformation und Spracherkennung zu berechnen. Die Länge des Videos wird dabei mit dem folgenden regulären Ausdruck ermittelt: `Duration: (\d+):(\d\d):(\d\d)\.(\d+)`. Die vier Gruppen entsprechen dabei Stunden, Minuten, Sekunden, Millisekunden.

#### Transformation

**Beispiel:** `> ffmpeg.exe -i "D:\media\video.mp4" -n -vn -ac 1 -ar 16000 -acodec pcm_s16le "D:\media\sound.wav"`

Bedeutung der Argumente:

* `-i "D:\media\video.mp4"` Der Pfad der Eingabedatei
* `-n` Abbrechen falls Ausgabedatei bereits existiert
* `-vn` keine Videoausgabe
* `-ac 1` 1-kanalige Audioausgabe (mono) 
* `-ar 16000` Resampling der Abtastrate auf 16 kHz
* `-acodec pcm_s16le` Ausgabeformat ist PCM-Audio mit Vorzeichen-behafteter 16Bit-Auflösung und Little-Endian Byte-Reihenfolge
* `"D:\media\sound.wav` Der Pfad der Ausgabedatei

## Wellenformvisualisierung (extern)

**Projektname:** WaveViz  
**Repository:** <https://github.com/mastersign/waveviz>  

### Merkmale

* Befehlszeilenschnittstelle
* Erwartet PCM-Wave-Dateien (16 Bit, mono, Abtastrate beliebig)
* Parameter für die Größe der Bildfläche
* Parameter für Hintergrund und Vordergrundfarben
* Antialiasing durch Over-Sampling
* Ausgabe als PNG-Datei

### Befehlszeilenschnittstelle

**Programmdatei:** `WaveViz.exe`  

	Syntax: waveviz <WAV-Datei> <PNG-Datei> [w h] [bg f1 f2 li]
  	  w  = Bildbreite in Pixeln
  	  h  = Bildhöhe in Pixeln
  	  bg = Hintergrundfarbe
  	  f1 = Vordergrundfarbe 1
  	  f2 = Vordergrundfarbe 2
  	  li = Farbe der Horizontlinie
	Farbwerte werden als RGBA-Hex-Werte angegeben. (z.B. #E080D0FF)

**Beispiel:** `> WaveViz.exe "D:\media\sound.wav" "D:\media\wave.png" 1024 100 #00000000 #FF880080 #880000FF #FF0000FF`

## Spracherkennung

**Projektname:** MediaCategorizer - Transcripter  
**Repository:** <https://github.com/mastersign/mediacategorizer-transcripter/>  
**Verzeichnis:** `/components/Transcripter`  
**Projekt-Typ:** Microsoft Visual Studio  
**Programmiersprache:** C# 5.0  
**Plattform, Bibiotheken:** .NET 4.5, Microsoft Speech API

### Merkmale

* Befehlszeilenschnittstelle
* Ansteuerung der Microsoft Speech API  
  über den .NET-Namensraum `System.Speech.Recognition` aus der Assembly `System.Speech.dll`
* Ausgabe der Erkennungsergebnisse als EDN-Datei

### Architektur

Das Befehlszeilenprogramm *Transcripter* ist nahezu vollständig prozedural in der statischen Klasse `de.fhb.oll.transcripter.Program` implementiert. Lediglich das Parsen der Befehlszeilenargumente wird von einer Instanz der Klasse `CommandLineArguments` übernommen.

Das Programm besitzt zwei Betriebsmodi. Im Standardmodus wird die gesamte Quelldatei vom Spracherkennungssystem verarbeitet und die Erkennungsergebnisse werden im EDN-Format in die Ergebnisdatei geschrieben. Die Ergebnisdatei sollte die Endung `.srr` für [Speech Recognition Result][srr] besitzen. Im Testmodus für Erkennungssicherheit wird nur der Anfang einer Datei vom Spracherkennungssystem verarbeitet und statistische Werte zu den erkannten Phrasen und Wörtern ausgegeben.

### Befehlszeilenschnittstelle

**Programmdatei:** `Transcripter.exe`

	Syntax: transcripter [Optionen] <WAV-Datei>
	  Optionen
	    -ct, --confidence-test: Schaltet in den Testmodus für Erkennungssicherheit
	    -td, --test-duration: Die maximale Testlänge ab dem Dateianfang in Sekunden
	    -db, --dashboard: Aktiviert im Standardmodus eine Übersichtsdarstellung
	    -p, --progress: Aktiviert die Ausgabe des Fortschritts
	    -t, --target <SRR-Datei>: Gibt im Standardmodus die Ergebnisdatei an

**Beispiel Test:** `> Transcripter.exe -ct -td 60 D:\media\sound.wav`

**Beispiel Spracherkennung:** `> Transcripter.exe -p -t D:\media\result.srr D:\media\sound.wav`

### Testergebnisse

Im Testmodus für Erkennungssicherheit werden die folgenden Werte ausgegeben.

	PhraseCount=<Anzahl der erkannten Phrasen>
	PhraseConfidenceSum=<Die Summe der Erkennungssicherheit aller erkannten Phrasen>
	MaxPhraseConfidence=<Die höchste Erkennungssicherheit aller erkannten Phrasen>
	MinPhraseConfidence=<Die mittlere Erkennungssicherheit aller erkannten Phrasen>
	MinPhraseConfidence=<Die geringste Erkennungssicherheit aller erkannten Phrasen>
	WordCount=<Die Anzahl der erkannten Worte>
	WordCondifenceSum=<Die Summe der Erkennungssicherheit aller erkannten Worte>
	MaxWordConfidence=<Die höchste Erkennungssicherheit aller erkannten Worte>
	MeanWordConfidence=<Die mittlere Erkennungssicherheit aller erkannten Worte>
	MinWordConfidence=<Die geringste Erkennungssicherheit aller erkannten Worte>
	BestWordConfidence=<Die mittlere Erkennungssicherheit des am besten erkannten Wortes>

## Analyse und Visualisierung

**Projektname:** MediaCategorizer - Distillery  
**Repository:** <https://github.com/mastersign/mediacategorizer-distillery/>  
**Verzeichnis:** `/components/Distillery`  
**Projekt-Typ:** Leiningen  
**Programmiersprache:** Clojure 1.5  
**Plattform, Bibiotheken:** Java 7 Runtime, clojure, data.xml, enlive

### Merkmale

* Befehlszeilenschnittstelle
* Analyse der Spracherkennungsergebnisse
* Erzeugung der Worthäufigkeitslisten für Videos und Kategorien
* Berechnung der Übereinstimmungskennzahlen
* Erzeugung der XML-Ausgabe
* Erzeugung der Reintext-Ausgabe
* Ansteuerung der Bibliothek *Mastersign Cloud*
* Erzeugung der Ergebniswebseite

### Architektur

> TODO

## Wortwolken

**Projektname:** Mastersign Cloud  
**Repository:** <https://github.com/mastersign/mediacategorizer-distillery/>  
**Verzeichnis:** `/components/Distillery/src/mastersign`  
**Projekt-Typ:** Clojure-Bibliothek  
**Programmiersprache:** Clojure 1.5  
**Plattform, Bibliotheken:** Java 7 Runtime, clojure  

### Merkmale

* Clojure-Schnittstelle
* Visualisierung einer Wortmenge
* Unterstützung für zwei charakteristische Größen (Wortgröße, Farbe)
* Parameter für die Größe der Bildfläche
* Parameter für Hintergrund- und Vordergrundfarben
* Parameter für Schriftgrößen und -stilen
* Optional sortiertes Layout
* Parametrisierung für Darstellungsqualität (beeinflusst Laufzeit)


[clr]: http://www.microsoft.com/de-de/download/details.aspx?id=40779
[vs]: http://www.visualstudio.com/de-de
[jdk]: http://www.oracle.com/technetwork/java/javase/downloads/index.html
[ps3]: http://www.microsoft.com/de-de/download/details.aspx?id=40855
[git]: http://git-scm.com/
[pandoc]: http://johnmacfarlane.net/pandoc/
[miktex]: http://miktex.org/download

[handbook]: Benutzerhandbuch.html
[srr]: intermediate-data-structures.html#SpeechRecognitionResultFile

[ui-ns]: images/diagrams/Namespaces.png
[ui-ui]: images/diagrams/UI.png
[ui-project]: images/diagrams/Project.png
[ui-configuration]: images/diagrams/Configuration.png
[ui-iprocess]: images/diagrams/IProcess.png
[ui-process]: images/diagrams/Process.png
[ui-process-chain]: images/diagrams/ProcessChain.png
[ui-tool-base]: images/diagrams/ToolBase.png
[ui-tool-distillery]: images/diagrams/ToolDistillery.png
[ui-tool-ffmpeg]: images/diagrams/ToolFFmpeg.png
[ui-tool-ffprobe]: images/diagrams/ToolFFprobe.png
[ui-tool-transcripter]: images/diagrams/ToolTranscripter.png
[ui-tool-waveviz]: images/diagrams/ToolWaveViz.png
[ui-setup]: images/diagrams/Setup.png

*[EDN]: Extensible Data Notation
*[REPL]: Read-Eval-Print-Loop
*[HTML]: Hyper Text Markup Language
*[PDF]: Portable Document Format
*[XML]: eXtensible Markup Language
*[JDK]: Java Development Kit