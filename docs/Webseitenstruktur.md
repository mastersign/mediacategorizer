---
title: MediaCategorizer
subtitle: Struktur der Ergebniswebseite
author: Tobias Kiertscher
creator:
- role: Autor
  name: Tobias Kiertscher
  affiliation: Fachhochschule Brandenburg
  email: kiertscher@fh-brandenburg.de
version: 0.3.0
date: 31.01.2014
lang: de
...

Dieses Dokument bietet eine knappe Übersicht über die technische Struktur der Ergebniswebseite, die von MediaCategorizer ausgegeben wird. Es richtet sich an Entwickler, die die Projektausgabe an eigene Bedürfnisse anpassen möchten. Das Dokument ist als Orientierungshilfe und Nachschlagewerk konzipiert.

In der Webseite werden alle verarbeiteten Videos und Kategorien aufgeführt. Für jedes Video und jede Kategorie ist ein individuelles Glossar und eine Wortwolke in der Webseite enthalten. Des Weiteren ist ein Video-übergreifendes Glossar und eine Video-übergreifende Wortwolke enthalten. Die Übereinstimmungen zwischen Videos und Kategorien werden übersichtlich in einer Matrix dargestellt.

Die Webseite ist in unterschiedliche Kontexte aufgeteilt:

* **Projektkontext** alle Videos und alle Kategorien
* **Video** ein Video und die zugeordneten Kategorien
* **Kategorie** eine Kategorie und die zugeordneten Videos 

# Index

Pfad: `/index.html`

## Kontext

* Mehrere Kategorien
* Mehrere Videos

## Ansichten

* Projekt
	* Übersicht
		* Beschreibung
		* Statistiken
		* Wort-Hitliste &rarr; Projekt : Wort
	* Wortwolke
		* Wortwolke Wort &rarr; Projekt : Wort 
	* Matrix
		* Zeile &rarr; Video : Übersicht
		* Spalte &rarr; Kategorie : Übersicht
		* Zelle &rarr; Kategorie : Übereinstimmung 
	* Glossar
* Kategorien
	* Übersicht 
		* List &rarr; Kategorie : Übersicht
* Videos
	* Übersicht	
		* List &rarr; Video : Übersicht
* Wort*  
  Pfad: `/Worts/<Wort>.inc.html`
	* Statistiken
	* Videos (Teilmenge) &rarr; Video : Wort
	* Kategorien (Teilmenge) &rarr; Kategorie : Wort

# Kategorie*

Pfad: `/categories/<Kategorie>/index.html`

## Kontext

* Einzelne Kategorie
* Mehrere Videos (Teilmenge)

## Ansichten

* Kategorie (Übersicht)
	* Beschreibung
	* Statistiken
	* Wort-Hitliste &rarr; Kategorie:Wort
* Wortwolke
	* Wortwolke Wort &rarr; Kategorie:Wort
* Videos
	* Liste &rarr; Kategorie : Übereinstimmung
* Glossar
	* Liste &rarr; Kategorie : Wort
* Wort*  
  Pfad: `/categories/<Kategorie>/Worts/<Wort>.inc.html`
	* Statistiken
	* Videos (Teilmenge) &rarr; Video : Wort
* Übereinstimmung*  
  Pfad: `/categories/<Kategorie>/matches/<video>.inc.html`
	* Übereinstimmung
	* Wortliste &rarr; Kategorie : Wort

# Video*

Pfad: `/videos/<video>/index.html`  
Video-Pfad: `/video/<video>/<video>.mp4`  
Waveform-Pfad: `/videos/<video>/waveform.png`

## Kontext

* Einzelnes Video
* Mehrere Kategorien (Teilmenge)

## Ansichten

* Video (Übersicht)
	* Beschreibung
	* Statistiken
	* Waveform
	* Wort-Hitliste &rarra; Video : Wort
* Wortwolke
	* Wortwolke Wort &rarr; Video : Wort 
* Transkript
	* Phrase Zeitpunkt &rarr; Abspielposition
	* Phrase Wort &rarr; Video : Wort
* Kategorien 
	* Liste &rarr; Kategorie : Übereinstimmung
* Glossar
	* Liste &rarr; Video : Wort
* Wort*  
  Pfad: `/videos/<video>/Worts/<Wort>.inc.html`
	* Statistiken
	* Auftreten &rarr; Abspielposition
	* Kategorien &rarr; Kategorie:Wort
