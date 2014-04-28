---
title: MediaCategorizer
subtitle: Sprecherprofilverwaltung
author: Tobias Kiertscher
creator:
- name: Tobias Kiertscher
  role: Autor
  affiliation: Fachhochschule Brandenburg
  email: kiertscher@fh-brandenburg.de
version: 0.5.0
date: 10.02.2014
lang: de
...

# Voraussetzungen
MediaCategorizer verwendet für die Verschriftlichung das Microsoft Speech API, welches Bestandteil von Microsoft Windows ist. Für MediaCategorizer wird das Betriebssystem Microsoft Windows 7 in deutscher Sprache benötigt.

Für die Spracherkennung sind ein oder mehrere Sprecherprofile erforderlich. Diese kleine Anleitung erklärt die Verwaltung der Sprecherprofile. 

# Sprecherprofil erzeugen {#create}
Windows 7 erstellt bei der Installation automatisch ein nicht trainiertes Sprecherprofil mit dem Namen *Standard*. Es können beliebig viele weitere Profile erstellt werden. Dafür muss zunächst die Seite *Spracherkennung* in der Systemsteuerung geöffnet werden (siehe [#sysctrl-speechrecon]).

![#sysctrl-speechrecon Die Spracherkennung in der Systemsteuerung][sysctrl-speechrecon]

Über den Link oben links *Erweiterte Sprachoptionen* wird der Dialog *Spracheigenschaften* geöffnet (siehe [#speechprops]). Der Karteireiter *Spracherkennung* enthält die Liste der existierenden Sprecherprofile. Über die Schaltfläche *Neu...* kann ein neues Sprecherprofil angelegt werden (siehe [#newprofile]).

![#speechprops Der Dialog "Spracheigenschaften"][speechprops]

![#newprofile Der Dialog "Profil hinzufügen..."][speech-newprofile]

# Sprecherprofil trainieren {#train}
Ein existierendes Profil kann durch das Vorlesen eines vorgegebenen Textes trainiert werden. Der Trainingsassistent wird durch die Schaltfläche *Profil trainieren* im Dialog *Spracheigenschaften* aufgerufen (siehe [#speechprops]).

Das Training findet in ein oder mehreren Phasen statt. Die besten Ergebnisse werden erreicht, wenn alle Phasen des Trainings absolviert werden.

# Sprecherprofil exportieren {#export}
Sprecherprofile können in eine SPF-Datei exportiert und so auf ein anderes System übertragen werden. Diese Funktionalität steht leider nicht über die Benutzeroberfläche von Windows zur Verfügung. Jedoch bietet Microsoft für diesen Zweck das kleine Programm *Speech Profile Manager* zum [Download][spm-dl] an (siehe [#spm]).

![#spm Der Speech Profile Manager von Microsoft][spm]

Um ein Profil zu exportieren genügt es, dieses im Speech Profile Manager auszuwählen und auf die Schaltfläche *Export...* zu klicken. Im anschließenden Dialog kann der Pfad der SPF-Datei angegeben werden in die das Profil exportiert werden soll.

#Sprecherprofil importieren {#import}
Sprecherprofile können aus einer SPF-Datei importiert werden. Dazu ist das Programm *Speech Profile Manager* erforderlich (siehe Abschnitt [Sprecherprofil exportieren](#export)).

Um ein Profil zu importieren, genügt es im Speech Profile Manager auf die Schaltfläche *Import...* zu klicken und anschließend die SPF-Datei auszuwählen. Das Programm warnt, wenn das zu importierende Profil den gleichen Namen besitzt wie ein bereits installiertes Profile und ermöglicht es, einen neuen Namen für das zu importierende Profil anzugeben.

Nach erfolgreichem Import fragt das Programm zunächst nach, ob das importierte Profil zum Standardprofil gemacht werden soll. Diese Frage kann mit *No* beantwortet werden. Anschließen bietet das Programm an, die Mikrofoneinrichtung für das Profil durchzuführen. Für die Verschriftlichung mit MediaCategorizer ist dies nicht erforderlich, da dabei nicht das am PC angeschlossene Mikrofon zum Einsatz kommt. Deshalb kann auch dieser zweite Dialog mit *No* beantwortet werden. 

# Hinweise zum Einsatz von Sprecherprofilen
MediaCategorizer nutzt immer alle installierten Sprecherprofile. Es wählt während der Ausführung nacheinander verschiedene Sprecherprofile als aktuelles Standardprofil aus, deshalb ist es die Regel, dass das Standardprofil nach der Ausführung von MediaCategorizer umgestellt wurde.

Sind mehrere Sprecherprofile im System installiert, wählt MediaCategorizer für jedes Video das Sprecherprofil mit der besten Erkennungsleistung aus. 

Für gute Erkennungsergebnisse mit unbekanntem Videomaterial ist es empfehlenswert eine kleine Anzahl von Profilen (z.B. 8) zu verwenden, die von Sprechern mit möglichst unterschiedlichen Stimmen und unterschiedlicher Aussprache trainiert wurden. Eine große Anzahl unterschiedlicher Profile erhöht die Wahrscheinlichkeit einer guten Erkennungsleistung, erhöht aber auch deutlich den Rechenaufwand für die Profilauswahl.

Sind die Sprecher der Videos bekannt, erzielt man die besten Ergebnisse, wenn Profile verwendet werden, die durch diese Sprecher trainiert wurden.

Wenn im Dateipaket von MediaCategorizer ein Verzeichnis mit SPF-Dateien enthalten ist, können diese Profile für einen ersten Einsatz importiert werden (siehe Abschnitt [Sprecherprofil importieren](#import)).


[sysctrl-speechrecon]: images/windows-sysctrl-speechrecon.png
[speechprops]: images/windows-speechprops.png
[speech-newprofile]: images/windows-speech-newprofile.png
[spm]: images/speech-profile-manager.png

[spm-dl]: http://www.microsoft.com/en-us/download/details.aspx?id=22358
