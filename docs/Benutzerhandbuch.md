---
title: MediaCategorizer
subtitle: Benutzerhandbuch
author: Tobias Kiertscher
creator:
- role: Autor
  name: Tobias Kiertscher
  affiliation: Fachhochschule Brandenburg
  email: kiertscher@fh-brandenburg.de
version: 0.4.0
date: 05.02.2014
lang: de
...

![][logo]

# Einleitung
MediaCategorizer ist eine Windows-Desktop-Anwendung zur Verschriftlichung von Audio- und Videomedien und der automatischen Zuordnung dieser Medien zu benutzerdefinierten Kategorien.

# Technische Voraussetzungen
Für den Betrieb von MediaCategorizer wird ein PC mit Microsoft Windows 7 Professional oder Enterprise und deutscher Benutzeroberfläche als Betriebssystem benötigt. (Es genügt evtl. nicht, ein Windows mit anderer Sprache durch die Installation eines Sprachpakets auf Deutsch umzustellen, da in einem deutschen Sprachpaket evtl. nicht die Deutschen Wörterbücher für die Spracherkennung enthalten sind.)

Für die Darstellung der Prozessergebnisse ist ein Browser erforderlich. Die Ergebnisse wurden mit Mozilla Firefox (Version 25) und Microsoft Internet Explorer 10 getestet. 

Der Rechenaufwand und Arbeitsspeicherbedarf ist abhängig von der Anzahl und Länge der verarbeiteten Medien. Es wird empfohlen mindestens 3 GB RAM und eine CPU mit mindestens 2 Kernen zu verwenden. MediaCategorizer ist so implementiert, dass mehrere Prozessorkerne effektiv genutzt werden. Das bedeutet, dass sich die Verarbeitungszeit bei Projekten mit mehreren Medien durch den Einsatz eines Mehrprozessorsystems deutlich reduziert.

# Installation
MediaCategorizer benötigt sowohl das Microsoft .NET-Framework 4.5 als auch eine Java 7 Laufzeitumgebung.

* **Microsoft .NET-Framework 4.5**  
  In der Systemsteuerung unter *Programme und Funktionen* kann überprüft werden, ob das Framework in der erforderlichen Version bereits installiert ist. Falls dies nicht der Fall ist, kann das Framework über das Microsoft Update installiert werden, oder durch ein Setup-Paket, das [hier][net45] heruntergeladen werden kann.
* **Java 7 Plattform**  
  In der Systemsteuerung unter *Programme und Funktionen* kann überprüft werden, ob Java 7 bereits installiert ist. Falls dies nicht der Fall ist, kann es durch das Setup-Paket installiert werden, das [hier][java7] heruntergeladen werden kann. Im Normalfall genügt die 32-Bit-Laufzeitumgebung (auch auf einem 64-Bit Windows).
  Wenn große Projekte mit vielen Medien verarbeitet werden sollen und ein Microsoft Windows 7 in der 64-Bit-Variante als Betriebssystem verwendet wird, empfiehlt es sich jedoch, die 64-Bit-Laufzeitumgebung von Java 7 zu installieren.

MediaCategorizer benötigt keine Registrierung im Betriebssystem. Das bedeutet, dass es nicht durch das Ausführen eines Setup-Programms installiert werden muss, sondern einfach durch Kopieren des Anwendungsverzeichnisses installiert wird. MediaCategorizer kann z.B. im Verzeichnis `C:\MediaCategorizer` installiert werden oder in `C:\User\<Benutzer>\Documents\MediaCategorizer`.

Es kann, falls gewünscht, eine Verknüpfung zum Start von MediaCategorizer auf dem Desktop platziert werden. Dafür kann die Datei `MediaCategorizer.exe` im Installationsverzeichnis aus einem Explorer-Fenster bei gedrückter `Alt`-Taste auf den Desktop gezogen werden.

Nach erfolgreicher Installation von MediaCategorizer müssen Sprecherprofile in Windows eingerichtet werden. Dazu dienen die Anweisungen im Dokument [MediaCategorizer - Sprecherprofilverwaltung][profile-management].

# Benutzeroberfläche
Die Benutzeroberfläche von MediaCategorizer gliedert sich die die folgenden drei Bereiche (siehe [#ui-parts]).

![#ui-parts Die allgemeine Aufteilung der Benutzeroberfläche][ui-parts]

Am oberen Fensterrand befindet sich das Projektmenü, mit dessen Hilfe Projekte angelegt, gespeichert und wieder geöffnet werden können. Am rechten Ende des Projektmenüs befindet sich ein Eintrag für die [Programmeinstellungen](#PageSetup) und ein Eintrag für die [Infoseite](#PageAbout). Ganz rechts führt das Hilfe-Symbol zur Online-Hilfe im Standardbrowser.

Am rechten Fensterrand befindet sich das Prozessmenü. Mit dem Prozessmenü wird zwischen den verschiedenen Seiten eines Projektes umgeschaltet.

Im übrigen Bereich des Fensters wird die jeweils aktive Seite angezeigt.

## Projektseiten
Die verschiedenen Aspekte eines Projektes sind auf die folgenden Seiten verteilt. 

* [Start](#PageStart)
* [Kategorien](#PageCategories)
* [Medien](#PageMedia)
* [Parameter](#PageParameters)
* [Ausführung](#PageProcessing)

Die Seiten können in beliebiger Reihenfolge über das Prozessmenü aufgerufen werden.

### Start {#PageStart}
Auf der *Startseite* eines Projekt kann für das Projekt ein Name und eine Beschreibung angegeben werden (siehe [#ui-page-start]). Darüber hinaus wird auf der Startseite ein absoluter oder relativer Pfad für das Ausgabeverzeichnis angegeben. In diesem Verzeichnis werden die Prozessergebnisse gespeichert.

Wird ein relativer Pfad für das Ausgabeverzeichnis angegeben, bezieht sich dieser auf die Position der Projektdatei im Dateisystem. Deshalb muss das Projekt gespeichert werden, bevor die Ausführung des Prozesses gestartet wird.

![#ui-page-start Die Startseite eines Projektes][ui-page-start]

### Kategorien {#PageCategories}
Auf der Seite *Kategorien* können die Kategorien für das Projekt definiert werden (siehe [#ui-page-cats]). Die Schaltflächen *Kategorie hinzufügen* und *Kategorie entfernen* können verwendet werden, um der Liste neue Einträge hinzuzufügen oder einen oder mehrere markierte Einträge zu löschen. Ein Klick auf eine Zeile der Tabelle markiert die Zeile und damit die entsprechende Kategorie, ein weiterer Klick auf eine Zelle in dieser Zeile schaltet die Zelle in den Bearbeitungsmodus. Auf diese Weise können die ID und der Name einer Kategorie bearbeitet werden.

![#ui-page-cats Die Kategorien eines Projektes][ui-page-cats]

Durch das Markieren einer Kategorie werden die Ressourcen dieser Kategorie in der unteren Tabelle angezeigt.

Die ID einer Kategorie darf keine Leer- oder Sonderzeichen enthalten und sollte möglichst kurz gewählt werden. Der Name sollte die Kategorie möglichst aussagekräftig beschreiben. Er wird in der Prozessausgabe zur Beschriftung der Kategorie verwendet.

Die Ressourcen einer Kategorie werden verwendet, um die Wortliste der Kategorie zu erzeugen. Ressourcen können über die Schaltflächen *Ressource(n) hinzufügen* und *Ressource(n) entfernen* bearbeitet werden. Nach einem Klick auf die Schaltfläche *Ressource(n) hinzufügen* wird ein Auswahldialog angezeigt, in dem zwischen lokalen Resourcen und Web-Resourcen gewählt werden kann. Wird *Lokale Datei* ausgewählt, kann eine oder mehrere Datei im lokalen Dateisystem als Ressource ausgewählt werden. Wird *Webserver* ausgewählt, öffnet sich ein Browser-Fenster in dem eine Webseite aufgrufen werden kann. Mit der Schaltfläche *Adresse übernehmen* wird die aktuell angezeigte Seite der Kategorie als Web-Resource hinzugefügt und das Browser-Fenster geschlossen. 

Jede Ressource wird durch einen Typ und eine URL definiert. Es gibt drei Typen von Ressourcen:

* **Plain** (Reintext)  
  Dieser Typ eignet sich, wenn eine Textdatei als Ressource verwendet werden soll, die einfachen Text oder sogar nur beschreibende Wörter enthält.
* **HTML** (Webseite)  
  Dieser Typ eignet sich für HTML-Seiten die hauptsächlich Text enthalten. Es muss jedoch beachtet werden, dass MediaCategorizer nicht zwischen inhaltlichem Text und z.B. Menüeinträgen oder Fußzeilen unterscheiden kann. Deshalb sollte die Webseite nach Möglichkeit nur den Text enthalten, der zur Beschreibung der Kategorie herangezogen werden soll.
* **Wikipedia** (MediaWiki-Seite)  
  Dieser Typ eignet sich für Wikipedia-Seiten. Da die deutsche Wikipedia zu nahezu jedem Thema Seiten enthält, ist es in vielen Fällen Hilfreich eine Kategorie durch Wikipedia-Seiten beschreiben zu können. Da MediaCategorizer den Aufbau einer Wikipedia-Seite kennt, können viele Struktur- und Navigationselemente, die keine inhaltlichen Worte enthalten, vor der weiteren Verarbeitung heraus gefiltert werden.

Die URL einer Ressource gibt den Pfad zu der Ressource an. Die URL kann auch direkt bearbeitet werden. Für eine Wikipedia-Seite zum Begriff *Betriebssystem* kann z.B. die URL `http://de.wikipedia.org/wiki/Betriebssystem` verwendet werden. Wenn eine Datei aus dem lokalen Dateisystem gewählt wurde, wird dem Pfad `file:///` vorangestellt. So kann die Datei `C:\Users\Nutzer1\Documents\Stichworte.txt` z.B. mit der URL `file:///C:\Users\Nutzer1\Documents\Stichworte.txt` angegeben werden.

Werden in einem Projekt keine Kategorien angegeben, wird für die Prozessausgabe keine Zuordnung zwischen Kategorien und Medien berechnet.

### Medien {#PageMedia}
Auf der Seite *Medien* werden die Mediendateien angegeben, die in dem Prozess verarbeitet werden sollen (siehe [#ui-page-media]).

![#ui-page-media Die Medienliste eines Projektes][ui-page-media]

Medien werden mit einer ID, einem Namen und dem lokalen Pfad zu einer Mediendatei beschrieben. Die ID darf keine Leer- oder Sonderzeichen enthalten und sie sollte möglichst kurz gewählt werden. Der Name sollte das Medium aussagekräftig beschreiben, er wird in der Prozessausgabe zur Beschriftung des Mediums verwendet.

Einträge werden in der Medienliste mit den Schaltflächen *Medien hinzufügen* und *Medien entfernen* verwaltet.

Einfacher als das manuelle Hinzufügen von Einträgen zur Liste ist jedoch die Nutzung der Drag&Drop-Unterstützung. Dazu können ein oder mehrere Dateien oder Ordner aus einem Explorer-Fenster auf die Liste gezogen werden. Dabei werden alle Ordner nach kompatiblen Mediendateien durchsucht und passende Einträge in der List erzeugt. Der Name wird aus dem Dateinamen gewonnen und die ID wird als fortlaufende Nummer generiert.

### Parameter {#PageParameters}
Die Seite *Parameter* führt eine Reihe von Einstellungen auf, die den Prozess steuern (siehe [#ui-page-params]).

![#ui-page-params Die Parametereinstellung eines Projektes][ui-page-params]

* *Analyse*
	* **Gute Erkennungssicherheit**  
	  Die minimale Erkennungssicherheit für Worte die in der Ausgabe verwendet werden dürfen.
	* **Minimale Erkennungssicherheit**  
	  Die minimale Erkennungssicherheit für Worte die in der Analyse berücksichtigt werden sollen.
	* **Minimale Übereinstimmung**  
	  Die minimale Übereinstimmung für eine Zuordnung zwischen einem Medium und einer Kategorie.
	* **Wortfilter**  
	  Der Wortfilter steuert, welche Worte aus der Verschriftlichung und aus den Kategorie-Ressourcen in die Wortlisten aufgenommen werden dürfen.
		* **Blacklist**  
		  Aktiviert die Verwendung der Blacklist.
		* **Blacklist-Worte**  
		  Die obere Grenze für die Anzahl der Worte, die vom Anfang der Blacklist für das Filtern verwendet werden. Es wird eine nach Relevanz sortierte Blacklist vorausgesetzt.
		* **Erkennungssicherheit gut**  
		  Akzeptiert nur Worte, die mindestens eine gute Erkennungssicherheit besitzen. Der Schwellwert wird durch den Parameter *Gute Erkennungssicherheit* definiert.
		* **Erkennungssicherheit minimal**  
		  Akzeptiert nur Worte, die mindestens eine minimale Erkennungssicherheit besitzen. Der Schwellwert wird durch den Parameter *Minimale Erkennungssicherheit* definiert.
		* **Keine kurzen Worte**  
		  Akzeptiert nur Worte mit einer Mindestlänge von drei Zeichen.
		* **Keine Sonderzeichen**  
		  Akzeptiert keine Worte, die Sonderzeichen enthalten.
		* **Nur Substantive**  
		  Akzeptiert nur Worte die in ihrer Normalform großgeschrieben werden.
* *Ausgabe*
	* **Ergebnis anzeigen**  
	  Gibt an, ob die Ergebnisse des Prozesses nach Abschluss der Ausführung angezeigt werden sollen.
	* **Ergebnis visualisieren**  
	  Gibt an, ob die Prozessergebnisse in Form einer Website mit Wortwolken und Worthäufigkeitsdiagrammen visualisiert werden soll.
	* **Keine Übereinstimmungsdetails**  
	  Verhindert dass Detailseiten für jede Übereinstimmung zwischen einem Medium und einer Kategorie generiert wird.
	* **Keine Wortseiten**  
	  Verhindert dass Detailseiten für jedes Wort im Kontext eines Mediums, einer Kategorie oder des Projektes generiert wird.
	* **Keine Wortwolken**  
	  Verhindert die Visualisierung der häufigsten Worte in Wortwolken. (Beschleunigt die Erzeugung der Ausgabe wesentlich.)
	* **Mediendateien nicht kopieren**  
	  Verhindert dass die Mediendateien in die Website kopiert werden.
* *Spracherkennung*
	* **Dauer des Profiltests (sec)**  
	  Gibt an, wie viel vom Anfang der Tonspuren mit allen installierten Sprecherprofilen verarbeitet werden soll, um für jedes Medium das beste Sprecherprofil auszuwählen.
	* **Profilauswahlkriterium**  
	  Gibt die statistische Größe an, anhand derer das beste Sprecherprofil für ein Medium ausgewählt wird.
* *Verarbeitung*
	* **Arbeitsverzeichnis aufräumen**  
	  Gibt an, dass nach erfolgreicher Ausführung des Prozesses alle temporären Zwischenergebnisse gelöscht werden sollen. Diese stehen dann für eine wiederholte Ausführung nicht mehr zur Verfügung.
	* **Zwischenergebnisse verwerfen**  
	  Gibt an, dass alle noch existierenden Zwischenergebnisse aus einer früheren Prozessausführung verworfen werden sollen. Andernfalls werden die Zwischenergebnisse wiederverwendet und verkürzen entsprechend die Ausführungszeit.
* *Visualisierung*
	* **Globale Wolke**  
	  Steuert die Erzeugung der Wortwolke für die Worte aus allen Medien.
		* **Breite (px)**  
		  Gibt die Breite der Bildfläche in Pixeln an.
		* **Höhe (px)**  
		  Gibt die Höhe der Bildfläche in Pixeln an.
		* **Genauigkeit**  
		  Gibt die Genauigkeit der Berechnung für die Position der Worte in der Wortwolke an (`High`, `Medium`, `Low`). Eine hohe Genauigkeit (`High`) sorgt dafür, dass nach Möglichkeit auch kleine Lücken in der Darstellung für die Platzierung von Worten genutzt werden, erzeugt aber einen höheren Rechenaufwand. Eine niedrige Genauigkeit (`Low`) bedeutet, dass evtl. Lücken in der Darstellung frei bleiben, erzeugt aber weniger Rechenaufwand. Eine mittlere Genauigkeit (`Medium`) ist ein Kompromiss zwischen Visueller Qualität und Rechenaufwand.
		* **Minimales Vorkommen**  
		  Gibt die Anzahl an, die ein Wort mindestens erkannt werden muss, damit es in einer Wortwolke berücksichtigt wird. Es gibt jedoch keine Garantie dafür, dass ein Wort mit einer entsprechenden Häufigkeit in der Wortwolke erscheint, da in vielen Fällen nicht alle Worte auf der Bildfläche Platz finden.
		* **Priorität der Sortierung**  
		  Gibt die Priorität der Sortierung gegenüber der Worthäufigkeit bei der Platzierung der Worte an. Bei einer niedrigen Priorität (z.B. `0,1`) werden Worte hauptsächlich nach ihrer Häufigkeit von innen nach außen platziert. Bei einer hohen Priorität (z.B. `0,9`) werden Worte mehr nach ihrem Anfangsbuchstaben platziert (A-N oben von links nach rechts, O-Z unten von links nach rechts.).
		* **Hintergrundfarbe**  
		  Hintergrundfarbe der Bildfläche auf der die Worte platziert werden.
		* **Schriftfarbe**  
		  Die Farbe in der die Worte dargestellt werden. Haben Worte eine hohe Erkennungssicherheit werden sie einfach mit dieser Farbe dargestellt. Haben die Worte eine niedrige Erkennungssicherheit werden die Worte zunehmend transparent dargestellt.
		* **Schriftfamilie**  
		  Die Schriftfamilie mit der die Worte dargestellt werden.
		* **Schriftschnitt (kursiv)**  
		  Gibt an, ob die Worte in kursiver Schrift dargestellt werden sollen.
		* **Schriftstärke (fett)**  
		  Gibt an, ob die Worte fett dargestellt werden sollen.
		* **Schriftgröße (minimal)**  
		  Gibt die Schriftgröße an, mit der die Worte mit der geringsten Häufigkeit dargestellt werden sollen.
		* **Schriftgröße (maximal)**  
		  Gibt die Schriftgröße an, mit der die Worte mit der größten Häufigkeit dargestellt werden sollen.
	* **Kategoriewolke**  
	  Steuert die Erzeugung einer Wortwolke für die Worte aus einer Kategorie.
		* ... (siehe *Globale Wortwolke*)
	* **Medienwolke**  
	  Steuert die Erzeugung einer Wortwolke für die Worte aus einem Medium.
		* ... (siehe *Globale Wortwolke*)
	* **Wellenformvisualisierung**  
	  Steuert die Erzeugung der Wellenform aus der Mediendatei. Jede Wellenform wird zweimal visualisert, einmal aktiv und einmal passiv. Die passive Darstellung ist immer zusehen, die aktive Darstellung ist nur für den Bereich zu sehen der bereits abgespielt wurde. 
		* **Breite (px)**  
		  Gibt die Breite der Bildfläche in Pixeln an.
		* **Höhe (px)**  
		  Gibt die Höhe der Bildfläche in Pixeln an.
		* **Hintergrund**  
		  Gibt die Farbe des aktiven Hintergrundes an.
		* **Horizontlinie**  
		  Gibt die Farbe der aktiven Horizontlinie an.
		* **Wellenform 1**  
		  Gibt die erste Farbe für den Farbverlauf der aktiven Wellenform an. Die erste Farbe wird nahe der Horizontlinie verwendet.
		* **Wellenform 2**  
		  Gibt die zweite Farbe für den Farbverlauf der aktiven Wellenform an. Die zweite Farbe wird fern der Horizontlinie verwendet.
		* **Passiver Hintergrund**  
		  Gibt die Farbe des passiven Hintergrundes an.
		* **Passive Horizontlinie**  
		  Gibt die Farbe der passiven Horizontlinie an.
		* **Passive Wellenform 1**  
		  Gibt die erste Farbe für den Farbverlauf der passiven Wellenform an. Die erste Farbe wird nahe der Horizontlinie verwendet.
		* **Passive Wellenform 2**  
		  Gibt die zweite Farbe für den Farbverlauf der passiven Wellenform an. Die zweite Farbe wird fern der Horizontlinie verwendet.

### Ausführung {#PageProcessing}
Auf der Seite *Ausführung* kann der Prozess gestartet und der Fortschritt der Ausführung beobachtet werden. Sie besteht aus einem Kopfbereich der den globalen Fortschritt der Ausführung anzeigt, eine Liste mit Aufgaben und am Fuß eine Schaltfläche zum Starten des Projektes.

![#ui-page-process Die Fortschrittsanzeige während der Ausführung des Prozesses][ui-page-process]

Die Aufgabenliste besteht aus drei Bereichen:

* **Wartende Aufgaben**  
  In diesem Teil werden alle Aufgaben angezeigt, die noch nicht ausgeführt wurden.
* **Laufende Aufgaben**  
  In diesem Teil werden all Aufgaben angezeigt, die gerade ausgeführt werden. Jede laufende Aufgabe zeigt Statusmeldungen an und besitzt einen eigenen Fortschrittsbalken.
* **Abgeschlossene Aufgaben**  
  In diesem Teil werden alle Aufgaben angezeigt, die abgeschlossen oder fehlgeschlagen sind. Abgeschlossene Aufgaben werden grün hinterlegt, fehlgeschlagene Aufgaben werden rot hinterlegt und zeigen eine Fehlermeldung an.

## Programmeinstellungen {#PageSetup}
Durch den Eintrag *Einstellungen* im Projektmenü oben rechts, gelangt man auf die Seite *Einstellungen*. Auf dieser Seite werden Projektübergreifende Programmeinstellungen festgelegt. Diese Einstellungen werden in der Datei `MediaCategorizer.setup.xml` im Programmverzeichnis von MediaCategorizer gespeichert.

![#ui-page-settings Die Programmeinstellungen von MediaCategorizer][ui-page-settings]

Die folgenden Einstellungen stehen zur Verfügung:

* *Hilfsprogramme*
	* **distillery**  
	  Der relative oder absolute Pfad zur JAR-Datei der distillery-Komponente.
	* **FFmpeg**  
	  Der relative oder absolute Pfad zu `ffmpeg.exe`. (`ffmpeg.exe` ist das Befehlszeilenprogramm aus dem FFmpeg-Projekt, welches Umwandlung und Streaming von Audio- und Videodaten ermöglicht.)
	* **FFprobe**  
	  Der relative oder absolute Pfad zu `ffprobe.exe`. (`ffprobe.exe` ist ein Befehlszeilenprogramm aus dem FFmpeg-Projekt, welches Informationen über eine Mediendatei ausgibt.)
	* **JRE** (optional)  
	  Der relative oder absolute Pfad zu `java.exe`. (`java.exe` ist die Programmdatei der Java-Plattform.) Wird kein Pfad angegeben, wird nach einer Java-7-Installation gesucht.
 	* **Transcripter**  
	  Der relative oder absolute Pfad zur EXE-Datei der Transcripter-Komponente.
	* **WaveViz**  
	  Der relative oder absolute Pfad zur EXE-Date der WaveViz-Komponente.
* *Ressourcen*
	* **Download-Timeout**  
	  Die Anzahl an Sekunden, nach denen ein Downloadversuch von Kategorie-Ressourcen abgebrochen wird. 
	* **Audiodateiendungen**  
	  Eine Liste mit Dateiendungen für unterstützte Audiodateien. Die Endungen werden ohne führenden Punkt angegeben und durch Leerzeichen getrennt.
	* **Videodateiendungen**  
	  Eine Liste mit Dateiendungen für unterstützte Videodateien. Die Endungen werden ohne führenden Punkt angegeben und durch Leerzeichen getrennt.
* *Verarbeitung*
	* **Parallelisierung**  
	  Gibt an, ob unabhängige Aufgaben parallel ausgeführt werden dürfen (`None`, `Manual`, `Auto`). `None` bedeutet, dass Aufgaben nicht parallel ausgeführt werden dürfen. `Manual` bedeutet, das nur eine begrenzte Anzahl von Aufgaben parallel ausgeführt werden dürfen. `Auto` gibt an, das so viele Aufgaben parallel ausgeführt werden dürfen, wie Prozessorkerne im System verfügbar sind.
	* **Parallele Aufgaben**  
	  Wenn *Parallelisierung* auf `Manual` steht, gibt dieser Parameter die Anzahl der maximal parallel laufenden Aufgaben an.

## Infoseite {#PageAbout}
Die *Infoseite* wird über den Eintrag *Info* im Projektmenü rechts oben aufgerufen. Sie enthält Versions- und Lizenzinformationen zu MediaCategorizer (siehe [#ui-page-info]). Ein Link führt auf die Projekt-Website.

![#ui-page-info Die Infoseite von MediaCategorizer][ui-page-info]

# Prozessergebnisse
Nach erfolgreicher Prozessausführung wurden die Ergebnisse im Ausgabeverzeichnis des Projektes gespeichert.

## Verzeichnisstruktur
Die Ergebnisse werden in der folgenden Verzeichnisstruktur gespeichert:

* `index.html`  
  Die HTML-Seite mit der visuell aufbereiteten Darstellung der Ergebnisse. Diese Datei ist die Startseite der Ergebnis-Website.
* `categories.html`  
  Eine HTML-Seite mit einer Liste aller Kategorien.
* `media.html`  
  Eine HTML-Seite mit einer Liste aller Medien.
* `cloud.png`  
  Eine Bilddatei mit der Wortwolke für alle Medien.
* `result.xml` (*wird immer erzeugt*)  
  Eine maschinenlesbare XML-Datei mit allen Ergebnissen (Worthäufigkeiten, Transkript mit Erkennungssicherheiten, Zuordnungen)
* `*.css`  
  Eine Reihe von CSS-Dateien die Style-Informationen für die Website enthalten.
* `*.js`  
  Eine Reihe von JavaScript-Dateien die Programmlogik für die Website enthalten. 
* `<YYYY-MM-DD_hh-mm-ss>.log` (*wird immer erzeugt*)  
  Bei jeder Prozessausführung wird eine Protokolldatei geschrieben. Der Dateiname wird durch einen Zeitstempel erzeugt.
* `_tmp_`  
  Enthält Zwischenergebnisse und wird automatisch gelöscht, wenn der Projektparameter *Arbeitsverzeichnis aufräumen* gesetzt ist.
* `media`  
  Ein Verzeichnis das für jedes verarbeitete Medium ein Unterverzeichnis enthält. Der Name des Verzeichnisses entspricht der ID des Mediums.
	* `<Medien-ID>` (z.B. `lecture-1`)  
	  Ein Verzeichnis mit Medien-spezifischen Ergebnissen.
		* `index.html`  
		  Die HTML-Seite mit der visuell aufbereiteten Darstellung der Medien-spezifischen Ergebnisse.
		* `transcript.txt` (*wird immer erzeugt*)  
		  Eine Textdatei mit dem Transkript des Mediums mit jeder erkannten Phrase in einer Zeile.
		* `cloud.png`  
		  Eine Bilddatei mit der Wortwolke des Mediums.
		* `waveform.png`  
		  Eine Bilddatei mit der Wellenform des Mediums.
		* `<Medien-ID>.<Dateiendung>` (t.B. `lecture-1.mp4`)  
		  Die Datei des Mediums.
		* `words`  
		  Ein Verzeichnis mit Details zu allen Worten des Mediums.
* `categories`  
  Ein Verzeichnis das für jede verarbeitete Kategorie ein Unterverzeichnis enthält. Der Name des Verzeichnisses entspricht der ID der Kategorie.
	* `<Kategorie-ID>` (z.B. `math`)  
	  Ein Verzeichnis mit Kategorie-spezifischen Ergebnissen.
		* `index.html`  
		  Die HTML-Seite mit der visuell aufbereiteten Darstellung der Kategorie-spezifischen Ergebnisse.
		* `cloud.png`  
		  Eine Bilddatei mit der Wortwolke der Kategorie.
		* `words`  
		  Ein Verzeichnis mit Details zu allen Worten der Kategorie.
		* `matches`  
		  Ein Verzeichnis mit Details zu den Übereinstimmungen zwischen der Kategorie und den Medien.

Welche Teile der Ausgabe erzeugt werden hängt von den Projektparametern in der Parametergruppe *Ausgabe* ab: *Ergebnis visualisieren*, *Keine Übereinstimmungsdetails*, *Keine Wortseiten*, *Keine Wortwolken* und *Mediendateien nicht kopieren*.

Weitere Details zum Aufbau der Ergebnis-Website sind im Dokument [Struktur der Ergebniswebseite][site-structure] zu finden.

## Website
Die Website mit den Prozessergebnissen kann mit der Datei `index.html` in einem Browser aufgerufen werden.

Die Seite besitzt ein Hauptmenü und ein Ansichtsmenü (siehe [#result-general]). Über das Hauptmenü kann zwischen den allgemeinen Projektergebnissen, der Kategorieliste und der Medienliste umgeschaltet werden. Die Kategorieliste führt zu den Kategorie-spezifischen Ergebnissen und die Medienliste führt zu den Medien-spezifischen Ergebnissen. Damit gibt es drei unterschiedliche Kontexte: Projekt, Kategorie und Medium. Das Ansichtsmenü erlaubt den Wechsel zwischen den verschiedenen Ansichten des jeweiligen Kontexts.

![#result-general Die Startseite der Prozessergebnisse][result-general]

Die unterschiedlichen visuellen Darstellungen sind mit erläuternden Texten versehen, so dass die Website weitgehend selbsterklärend ist.

Das Ausgabeverzeichnis kann auf jedem Webserver veröffentlicht werden, der statische Inhalte vom Dateisystem ausliefern kann und die Datei `index.html` als Startseite für ein Verzeichnis erkennt. 

Falls vorhanden, sollten die folgenden Dateien und Verzeichnisse nicht veröffentlicht werden:

* `*.log`
* `_tmp_`

Ob die Datei `result.xml` veröffentlicht werden soll hängt davon ab, ob die maschinenlesbaren Ergebnisse über die Website abrufbar sein sollen.

Bei der Veröffentlichung ist zu beachten, dass je nach Größe der Mediendateien erheblicher Speicherplatzbedarf entsteht.

[net45]: http://www.microsoft.com/de-de/download/details.aspx?id=30653
[java7]: https://www.java.com/de/download/manual.jsp
[profile-management]: Sprecherprofilverwaltung.html

[logo]: images/MediaCategorizer.png
[ui-parts]: images/ui-parts-annotated.png
[ui-page-start]: images/ui-page-start.png
[ui-page-cats]: images/ui-page-categories.png
[ui-page-media]: images/ui-page-media.png
[ui-page-params]: images/ui-page-parameter.png
[ui-page-process]: images/ui-page-process.png
[ui-page-settings]: images/ui-page-settings.png
[ui-page-info]: images/ui-page-info.png
[result-general]: images/result-general.png

[site-structure]: Webseitenstruktur.html
