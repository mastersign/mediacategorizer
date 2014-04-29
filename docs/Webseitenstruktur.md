---
title: MediaCategorizer
subtitle: Struktur der Ergebniswebseite
author: Tobias Kiertscher
creator:
- role: Autor
  name: Tobias Kiertscher
  affiliation: Fachhochschule Brandenburg
  email: kiertscher@fh-brandenburg.de
version: 0.6.0
date: 29.04.2014
lang: de
...

Dieses Dokument bietet eine knappe Übersicht über die technische Struktur der Ergebniswebseite, die von MediaCategorizer ausgegeben wird. Es richtet sich an Entwickler, die die Projektausgabe an eigene Bedürfnisse anpassen möchten. Das Dokument ist als Orientierungshilfe und Nachschlagewerk konzipiert.

In der Webseite werden alle verarbeiteten Medien und Kategorien aufgeführt. Für jedes Medium und jede Kategorie ist ein individuelles Glossar und eine Wortwolke in der Webseite enthalten. Des Weiteren ist ein Medien-übergreifendes Glossar und eine Medien-übergreifende Wortwolke enthalten. Die Übereinstimmungen zwischen Medien und Kategorien werden übersichtlich in einer Matrix dargestellt.

Die Webseite ist in unterschiedliche Kontexte aufgeteilt:

* **Projektkontext** alle Medien und alle Kategorien
* **Medium** ein Medium und die zugeordneten Kategorien
* **Kategorie** eine Kategorie und die zugeordneten Medien 

# Index

Pfad: `/index.html`

## Kontext

* Mehrere Kategorien
* Mehrere Medien

## Ansichten

* Projekt
	* Übersicht
		* Beschreibung
		* Statistiken
		* Wort-Hitliste &rarr; Projekt : Wort
	* Wortwolke
		* Wortwolke Wort &rarr; Projekt : Wort 
	* Matrix
		* Zeile &rarr; Medium : Übersicht
		* Spalte &rarr; Kategorie : Übersicht
		* Zelle &rarr; Kategorie : Übereinstimmung 
	* Glossar
* Kategorien
	* Übersicht 
		* List &rarr; Kategorie : Übersicht
* Medien
	* Übersicht	
		* List &rarr; Medium : Übersicht
* Wort*  
  Pfad: `/words/<Wort>.inc.html`
	* Statistiken
	* Medien (Teilmenge) &rarr; Medium : Wort
	* Kategorien (Teilmenge) &rarr; Kategorie : Wort

# Kategorie*

Pfad: `/categories/<Kategorie>/index.html`

## Kontext

* Einzelne Kategorie
* Mehrere Medien (Teilmenge)

## Ansichten

* Kategorie (Übersicht)
	* Beschreibung
	* Statistiken
	* Wort-Hitliste &rarr; Kategorie:Wort
* Wortwolke
	* Wortwolke Wort &rarr; Kategorie:Wort
* Medien
	* Liste &rarr; Kategorie : Übereinstimmung
* Glossar
	* Liste &rarr; Kategorie : Wort
* Wort*  
  Pfad: `/categories/<Kategorie>/words/<Wort>.inc.html`
	* Statistiken
	* Medien (Teilmenge) &rarr; Medium : Wort
* Übereinstimmung*  
  Pfad: `/categories/<Kategorie>/matches/<Medium>.inc.html`
	* Übereinstimmung
	* Wortliste &rarr; Kategorie : Wort

# Medium*

Pfad: `/media/<Medium>/index.html`  
Medienpfad: `/media/<Medium>/<Medium>.<Typ>`  
Waveform-Pfad: `/media/<Medium>/waveform.png`

## Kontext

* Einzelnes Medium
* Mehrere Kategorien (Teilmenge)

## Ansichten

* Medium (Übersicht)
	* Beschreibung
	* Statistiken
	* Waveform
	* Wort-Hitliste &rarra; Medium : Wort
* Wortwolke
	* Wortwolke Wort &rarr; Medium : Wort 
* Transkript
	* Phrase Zeitpunkt &rarr; Abspielposition
	* Phrase Wort &rarr; Medium : Wort
* Kategorien 
	* Liste &rarr; Kategorie : Übereinstimmung
* Glossar
	* Liste &rarr; Medium : Wort
* Wort*  
  Pfad: `/media/<Medium>/words/<Wort>.inc.html`
	* Statistiken
	* Auftreten &rarr; Abspielposition
	* Kategorien &rarr; Kategorie:Wort
