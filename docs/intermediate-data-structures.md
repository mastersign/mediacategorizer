---
title: MediaCategorizer
subtitle: Intermediate File Formats
author: Tobias Kiertscher
creator:
- role: Author
  name: Tobias Kiertscher
  affiliation: Brandenburg University of Applied Sciences
  email: kiertscher@fh-brandenburg.de
version: 0.5.0
date: 2014-02-10
lang: en
...

This document describes the most important data structures for the *distillery*
component. 

# Configuration File {#ConfigFile}
File in [Clojure EDN syntax](http://edn-format.org/) with the extension `.cfg`. 
The content is a map with the _[Configuration](#Configuration)_ structure.

## Configuration {#Configuration}
The configuration structure controls the processing of the 
speech recognition results and the creation of the output. 

### Slots

* **parallel-proc**  
  _boolean_ a flag to activate the parallel processing
* **blacklist-resource**  
  _string_ the resource name for the blacklist
* **blacklist-max-size**  
  _integer number_ the maximum number of words to take from the blacklist
* **min-confidence**  
  _floating point number_ `[0..1]` the minimal recognition confidence for a word to be
  used in the statistic analysis
* **good-confidence**  
  _floating point number_ the minimal recognition confidence of words, 
  recognized "without a doubt"
* **min-relative-appearance**  
  _floating point number_ `[0..1]` the minimal relative appearance 
  (`max-appearance / appearance`) for correction candidates
* **min-match-score**  
  _floating point number_ `[0..1]` the minimal matching score for associating
  a medium with a category
* **index-filter**  
  _vector_ with a combination of the following keywords:
  `:not-short`, `:noun`, `:min-confidence`, `:good-confidence`, `:no-punctuation`,
  `:not-in-blacklist`
* **visualize-results**  
  _boolean_ a flag to activate the generating of an interactive website with
  a visualization of the process result
* **skip-media-copy**  
  _boolean_ a flag to suppress copying the media files into the website structure
* **skip-wordclouds**  
  _boolean_ a flag to suppress the time consuming generation of word clouds
* **skip-word-includes**  
  _boolean_ a flag to suppress the generation of a web-page for word in a medium or
  a category
* **skip-match-includes**  
  _boolean_ a flag to suppress the generation of a web-page for every match between
  a medium and a category
* **main-cloud**  
  _[Cloud Configuration](#CloudConfiguration)_ the configuration map for the global word cloud
* **category-cloud**  
  _[Cloud Configuration](#CloudConfiguration)_ the configuration map for the category word clouds
* **medium-cloud**  
  _[Cloud Configuration](#CloudConfiguration)_ the configuration map for the medium word clouds
* **waveform**  
  _[Waveform Configuration](#WaveformConfiguration)_ the configuration for the waveforms

### Example
	{ :parallel-proc true
      :blacklist-resource (resource "blacklist.txt"))
      :blacklist-max-size 1000
	  :min-confidence 0.4
	  :good-confidence 0.7
	  :min-match-score 0.02
      :index-filter [:not-short :noun :min-confidence :no-punctuation]
	  :skip-media-copy false
	  :skip-word-includes false
	  :skip-match-includes false
	  :main-cloud { { :width 640
                      :height 400
                      :color [0.0 0.8 0.2]
                      ... } } 
      :category-cloud { ... }
      :medium-cloud { ... } }

## Cloud Configuration {#CloudConfiguration}
A cloud configuration controls the creation of a word cloud.

### Slots

* **width**  
  _integer number_ the width of the word cloud image in pixels
* **height**  
  _integer number_ the height of the word cloud image in pixels
* **precision**  
  _floating point number_ `[0..1]` the precision for finding a place for a word
  in the word cloud
* **order-priority**  
  _floating point number_ `[0..1]` the priority of building an alphabetic order
  in the word cloud
* **font-family**  
  _string_ the family name of the font to be used for the words in the word cloud 
* **font-style**  
  _vector_ vector with a combination of the following styles: `:bold`, `:italic`
* **min-font-size**  
  _integer number_ `[10..]` the font size of the smallest words in pixels 
* **max-font-size**  
  _integer number_ `[10..]` the font size of the largest words in pixels
* **color**  
  _vector_ a vector with four _floating point numbers_ `[0..1]` 
  for red, green, and blue, and alpha
* **background-color**  
  _vector_ a vector with four _floating point numbers_ `[0..1]` 
  for red, green, blue, and alpha

### Example
	{ :width 540
	  :height 300
	  :precision :medium
	  :order-priority 0.6
	  :font-family "Segoe UI"
	  :font-style [:bold]
	  :min-font-size 13
	  :max-font-size 70
	  :color [0.0 0.3 0.8 1.0]
	  :background-color [0.0 0.0 0.0 0.0] }

## Waveform Configuration {#WaveformConfiguration}
A waveform configuration controls the creation of waveform visualizations for a medium.

### Slots
* **width**  
  _integer number_ the width of the waveform in pixels
* **height**  
  _integer number_ the height of the waveform in pixels

### Example

	{ :width 640
	  :height 80 }

# Job File {#JobFile}
File in [Clojure EDN syntax](http://edn-format.org/) with file extension `.saj`.
It is the input for the speech recognition result analysis and contains
a _[Job Description](#JobDescription)_ structure. Part of a job is a name, 
a number of categories, a number of medium, and additional parameters
like the output directory.

## Job Description {#JobDescription}
A job description contains all information necessary to perform the analysis
and create the analysis result representation.

### Slots

* **media-categorizer-version**  
  _string_ the version number of the MediaCategorizer tool
* **job-name**  
  _string_ short name for the job
* **job-description**  
  _string_ brief textual description of the job
* **output-dir**  
  _string_ file system path to the directory to save the analysis result 
  representation
* **result-file**  
  _string_ the name of the XML file for the process result
* **configuration**  
  _[Configuration](#Configuration)_ a configuration map which overwrites the default configuration
  individually for each existing slot, can be nil or empty
* **categories**  
  _vector_ of _[Category Descriptions](#CategoryDescription)_
* **media**  
  _vector_ of _[Medium Descriptions](#MediumDescription)_

### Example
	{ :media-categorizer-version "1.0.0"
      :job-name "Archive 001"
	  :job-description "The first part of the media archive."
	  :output-dir "C:\\Media\\Result"
      :result-file "result.xml"
	  :configuration { ... } 
	  :categories [ ... ] 
      :media [ ... ] }

## Category Description {#CategoryDescription}
Defines a category and all associated resources.

### Slots

* **id**  
  _string_ a short identifier without white spaces and special chars
* **name**  
  _string_ the full name of the category
* **resources**  
  _vector_ a vector with _[Category Resource Descriptions](#CategoryResourceDescription)_

### Example
	{ :id "comb"
      :name "Combination"
      :resources [ {:type :wikipedia, :url "http://en.wikipedia.org/wiki/Combination"}
                   {:type :html, :url "http://mathworld.wolfram.com/Combination.html" :file "D:\\cache\\combination.html" }
                   {:type :plain, :file "D:\\text\\combination.txt"} ] }

## Category Resource Description {#CategoryResourceDescription}
The reference to a category resource.

### Slots

* **type**  
  `:plain` | `:html` | `:wikipedia` the text type of the resource
* **url**  
  _string_ the URL to the resource
* **file**  
  _string_ the absolute path to a local file

## Medium Description {#MediumDescription}
Defines a medium and all associated resources.

### Slots
* **id**  
  _string_ a short identifier without white spaces and special chars
* **name**  
  _string_ the full name of the medium
* **medium-file**  
  _string_ the absolute path to the original medium file
* **medium-type**  
  `:audio` | `:video` | `:unknown` the type of the medium
* **encoded-media-files**  
  _vector_ a vector with _[Media Files](#MediumFile)_
* **recognition-profile**  
  _string_ the identifier for the selected speech recognition profile
  (for the Microsoft SAPI the identifier is a GUID)
* **recognition-profile-name**  
  _string_ the human readable name of the selected speech recognition profile
* **extracted-audio-file**  
  _string_ the absolute path to the extracted audio file `.wav` (PCM 16bit mono),
  used for speech recognition
* **duration**  
  _floating point number_ the length of the audio stream in seconds
* **waveform-file**  
  _string_ the absolute path to an image representing the waveform of the extracted audio
* **waveform-file-bg**  
  _string_ the absolute path to an image representing the background of the waveform of the extracted audio
* **results-file**  
  _string_ the absolute path to the speech recognition results file `*.srr`

### Example
	{ :id "C1-P3-Intro"
      :name "Introduction"
      :medium-file "D:\\media\\c1\\p3_introduction.mp4"
	  :medium-type :video
	  :encoded-media-files [ {:mime-type "video/mp4" :path "D:\\media\\c1\\p3_introduction.mp4"} ]
      :recognition-profile ""
      :recognition-profile-name "en-US_female_03"
      :audio-file "D:\\media\\proc\\audio\\p3_introduction.wav"
      :waveform-file "D:\\media\\proc\\waveform\\p3_introduction.png"
	  :waveform-file-bg "D:\\media\\proc\\waveform\\p3_introduction_2.png"
      :results-file "D:\\media\\proc\\transcript\\p3_introduction.srr" }

## Medium File {#MediumFile}
The reference to an encoded media file. Encoded media files are prepared to be played with HTML5 video and audio elements inside a web browser.

### Slots

* **path**  
  _string_ the absolute path to the encoded medium file
* **mime-type**  
  _string_ the MIME type of the medium file

### Example

	{ :path "D:\\media\\c1\\p3_introduction.mp4"
	  :mime-type "video/mp4" }

# Speech Recognition Result File {#SpeechRecognitionResultFile}
File in [Clojure EDN syntax](http://edn-format.org/) with file extension `.srr`.
The content is a vector of _[Speech Recognition Results](#SpeechRecognitionResult)_.

## Example
	[ { :no 0
	    :start 0.3
	    :duration 2.712
	    :confidence 0.5651
	    :text "Hello and welcome"
	    :words [ { :no 0 :confidence 0.9544 :text "Hello" :lexical-form "hello" :pronunciation "həˈləʊ̯" }
	             { :no 1 :confidence 0.8234 :text "and" :lexical-form "and" :pronunciation "ænd" }
	             { :no 2 :confidence 0.8602 :text "welcome" :lexical-form "welcome" :pronunciation "ˈwɛl.kəm" } ]
	    :alternates [ { :no 0
	                    :confidence 0.3521
	                    :text "Hello and welcome"
	                    :words [ ... ] }
	                  ... ] }
	  ... ]

## Phrase {#Phrase}
A phrase is a sequence of recognized words.

### Slots

* **confidence**  
  _floating point number_ `[0..1]` describing the overall confidence of this phrase
* **text**  
  _string_ with the text of the words in this phrase
* **words**  
  _vector_ of the _[Recognized Words](#RecognizedWord)_ in this phrase

## Speech Recognition Result {#SpeechRecognitionResult}
A speech recognition result describes the result yielded by the speech
recognition engine, analyzing a section of an audio stream.
The analyzed section is typically selected by an algorithm which considers
among others values like length of silence, background noises, and
maximal length of a section.
A speech recognition of an audio section yields a number of alternative
phrases. The phrase with the highest confidence is typically used as the
recognized phrase for the audio section.
A speech recognition result is a _[Phrase](#Phrase)_ as well.

### Slots

* **no**  
  _integer number_ `[0..n]` identifying the result in the context of a medium
* **start**  
  _floating point number_ with the begin of the audio section in seconds
* **duration**  
  _floating point number_ with the duration of the audio section in seconds
* **confidence**  
  _floating point number_ `[0..1]` describing the overall confidence of the
  _recognized phrase_ for the audio section
* **text**  
  _string_ with the text of the words in the recognized phrase
* **words**  
  _vector_ of the _[Recognized Words](#RecognizedWord)_ in the recognized phrase
* **alternates** (optional)  
  _vector_ with _[Alternate Phrases](#AlternatePhrase)_

### Example
	{ :no 0
	  :start 24.35
	  :duration 4.267
	  :confidence 0.7885
	  :text "a brown fox jumped over the messy hill."
	  :words [ ... ]
	  :alternates [ ... ] }

## Alternate Phrase {#AlternatePhrase}
An alternate sequence of recognized words for an audio section.
An alternate sequence is an extension of the _[Phrase](#Phrase)_ structure.

### Slots

* **no**
  _integer number_ `[0..n]` identifying the phrase in the context of a _[Speech
  Recognition Result](#SpeechRecognitionResult)_
* **confidence**
  _floating point number_ `[0..1]` describing the overall confidence of this phrase
* **text**
  _string_ with the text of the words in this phrase
* **words**
  _vector_ of the _[Recognized Words](#RecognizedWord)_ in this phrase

### Example
	{ :no 4
	  :confidence 0.48992
	  :text "a brown fox run about the messy mill."
	  :words [ ... ] }

## Recognized Word {#RecognizedWord}
A recognized word is a word in the context of a recognition result. Every word
is recognized with a certain confidence. The confidence values of the words
in a phrase can be combined to an overall confidence for a phrase.

### Slots

* **no**  
  _integer number_ `[0..n]` identifying the word in a phrase
* **confidence**  
  _floating point number_ `[0..1]` describing the confidence for the recognition
  of this word
* **text**  
  _string_ the text representation of the word in the context of the phrase
* **lexical-form**  
  _string_ the lexical form of the word
* **pronunciation**  
  _string_ the [IPA](http://en.wikipedia.org/wiki/International_Phonetic_Alphabet)
  pronunciation of the word in the context of the phrase

### Example
	{ :no 2
	  :confidence 0.6443
	  :text "brown"
	  :lexical-form "brown"
	  :pronunciation "braʊn" }

## Reverse Indexed Structures {#ReverseIndexedStructures}
Reverse indexing adds numerical references, pointing upwards in the hierarchy.

### Reverse Indexed Word
The reverse indexing adds one additional slot to the _[Words](#RecognizedWord)_ 
in a recognized phrase of a result:

* **result-no**  
  _integer number_ `[0..n]` identifying the result containing this word

### Reverse Indexed Alternate Phrase
The reverse indexing adds one additional slot to _[Alternate Phrases](#AlternatePhrase)_
in a result:

* **result-no**  
  _integer number_ `[0..n]` identifying the result containing this phrase

### Reverse Indexed Phrase Word
The reverse indexing adds two additional slots to _[Words](#RecognizedWord)_
in _[Alternate Phrases](#AlternatePhrase)_ of a result:

* **result-no**  
  _integer number_ `[0..n]` identifying the result containing the phrase
* **alt-no**  
  _integer number_ `[0..n]` identifying the alternate phrase in the result

# Analysis Results {#AnalysisResults}
The analysis steps in [distillery.core/prepare-and-analyze](api.html#distillery.core)
takes a _[Job Description](#JobDescription)_, loads the
necessary resources and generates additional data. This additional data
is attached to the _[Job Description](#JobDescription)_ structure and its children. 

Because of the large amount of the accumulated data during the analysis process
the extended job description structure is not written out as it is as an 
[EDN](http://edn-format.org/) file. Instead the most important parts of the
analysis result is written out as the XML result file. 

## Word Index {#WordIndex}
During analysis the _[Job Description](#JobDescription)_ is extended 
with a the slot `:words`, holding an index of words.
A word index points from words to a number of occurrences 
in media phrases. It is encoded as a map with the lexical form of a word
as the key and a structure with properties of the word as value.

### Value Slots
The following properties of a word are possible.

* **id**  
  _string_ an identifier, that can be used ax HTML/XML ID or as a file name 
* **lexical-form**  
  _string_ the lexical form of the word
* **pronunciation**  
  _string_ the [IPA](http://en.wikipedia.org/wiki/International_Phonetic_Alphabet)
  pronunciation of the word
* **occurrences**  
  _vector_ a vector of _[Medium Word Occurrences](#MediumWordOccurrence)_
* **occurrence-count**  
  _integer number_ `[1..n]` the number of occurrences (cached for easy accessibility)
* **mean-confidence**  
  _floating point number_ `[0..1]` mean recognition confidence

### Example
    { "Grammar" { :id "grammar"
                  :lexical-form "Grammar"
                  :pronunciation "..."
                  :occurrences [ { :medium-id "video1" :result-no 20 :word-no 3 :confidence 0.679 } ... ]
                  :occurrence-count 3
                  :mean-confidence 0.7533 }
      "Method"  { :id "method"
                  :lexical-form "Method"
                  :pronunciation "..."
                  :occurrences [ ... ] 
                  :occurrence-count 1
                  :mean-confidence 0.895 }

## Index Statistics {#IndexStatistics}
For computational reasons, an index map can be supported by some statistical values.

### Slots

* **count**  
  _integer number_ `[0..n]` the number of words in the index
* **max-occurrence-count**  
  _integer number_ `[1..n]` the number of occurrences of the most frequent word

### Example
	{ :count 233
      :max-occurrence-count: 35 } 

## Medium Word Occurrence {#MediumWordOccurrence}
A medium word occurrence is the address to a recognized word in a medium.

### Slots

* **medium-id** _(optional)_  
  _string_ medium id
* **result-no**  
  _int_ result number
* **word-no**  
  _int_ word number
* **confidence**  
  _floating point number_ `[0..1]` recognition confidence

### Example
    { :medium-id "video1" 
      :result-no 20 
      :word-no 3 
      :confidence 0.679 }

## Medium Result {#MediumResult}
The analysis result for the recognized phrases of a medium extends
the _[Medium Description](#MediumDescription)_ structure. 
The original _[Medium Description](#MediumDescription)_ from
the vector in the `:media` slot of a _[Job Description](#JobDescription)_ structure 
is extended by the following slots:

### Slots

* *id*
* *name*
* ...
* **results**  
  _vector_ of _[Recognition Result](#RecognitionResult)_ structures
* **phrase-count**  
  _integer number_ `[1..n]` the number of recognized phrases (cached for easy accessibility)
* **word-count**  
  _integer number_ `[1..n]` the number of recognized words
* **index**  
  _map_ the media word index, which maps from word IDs to _[Medium Word](#MediumWord)_ structures
* **index-stats**  
  _[Index Statistics](#IndexStatistics)_ for the media word index 
* **matches**  
  _map_ a look-up table, which maps from category IDs to _[Category Matches](#CategoryMatch)_
* **max-score**  
  _floating point value_ `[0..1]` the maximal score between the medium and a category

### Example
	{ :id "video01"
      :name "The first medium"
      ...
      :results [ ... ]
      :phrase-count 311
      :word-count 4977
      :index { "alpha" { :mean-confidence 0.793
                         :occurrences [ ... ]
                         :occurrence-count 9
                         :match-value: 0.104 }
               "beta"  { ... }
               ... }
      :index-stats { :count 288
                     :max-occurrence-count 19 } 
      :matches { "info" { :category-id "info"
                          :word-scores { ... }
                          :score 0.7133 }
                 "math" { ... }
                 ... }
      :max-score 0.9323 }

## Medium Word {#MediumWord}
A medium word is a word which occurs at least one time in the recognized phrases of a medium.
Every medium word is represented by some statistical values and
a list of _[Medium Word Occurrences](#MediumWordOccurrence)_.

### Slots

* **id**  
  _string_ an identifier, that can be used ax HTML/XML ID or as a file name 
* **lexical-form**  
  _string_ the lexical form of the word
* **pronunciation**  
  _string_ the [IPA](http://en.wikipedia.org/wiki/International_Phonetic_Alphabet)
  pronunciation of the word
* **occurrences**  
  _vector_ a vector of _[Medium Word Occurrences](#MediumWordOccurrence)_
* **occurrence-count**  
  _integer number_ `[1..n]` the number of occurrences (cached for easy accessibility)
* **mean-confidence**  
  _floating point number_ `[0..1]` mean recognition confidence
* **match-value**  
  _floating point number_ `[0..1]` the weight of this word in the context of the medium

### Example
	{ :id "bioinformatik"
      :lexical-form "Bioinformatik"
      :pronunciation "biːoːiːnfɔ͡ɐmaːˈtʰɪk"
      :occurrences [ {:medium-id "ABC"
                      :result-no 3
                      :word-no 10
                      :confidence 0.689}
                     ... ]
      :occurrence-count 21
      :mean-confidence 0.8234
      :match-value 0.01522 }

## Category Match {#CategoryMatch}
The category match describes the matching result between a medium and a category.

### Slots

* **category-id**  
  _string_ the id of the matched category
* **word-scores**  
  _map_ a look-up table, which maps from word IDs to word matching scores
* **score**  
  _floating point number_ `[0..1]` the matching score between the medium and the category

### Example
	{ :category-id "math"
      :word-scores { "algorithm" 0.00315
                     "linear" 2.4552E-4
                     ... } }

## Category Result {#CategoryResult}
The analysis result for the words of a category extends
the _[Category Description](#CategoryDescription)_ structure. 
The original _[Category Description](#CategoryDescription)_ from
the vector in the `:categories` slot of a _[Job Description](#JobDescription)_ structure 
is extended by the following slots:

### Slots

* *id*
* *name*
* ...
* **words**  
  _vector_ of _[Descriptive Words](#DescriptiveWord)_
* **index**  
  _map_ the category word index, which maps from word IDs to _[Category Word](#CategoryWord)_ structures
* **index-stats**  
  _[Index Statistics](#IndexStatistics)_ for the category word index 
* **matches**  
  _map_ a look-up table, which maps from media IDs to _[Medium Matches](#MediumMatch)_
* **max-score**  
  _floating point value_ `[0..1]` the maximal score between the category and a medium

### Example
	{ :id "math"
      :name "Mathematics"
      ...
      :words [ ... ]
      :index { "gamma" { :mean-confidence 1
                         :occurrences [ ... ]
                         :occurrence-count 4
                         :match-value: 0.0281 }
               "kappa"  { ... }
               ... }
      :index-stats { :count 1022
                     :max-occurrence-count 56 } 
      :matches { "video01" { :medium-id "video01"
                             :word-scores { ... }
                             :score 0.3991 }
                 "video02" { ... }
                 ... }
      :max-score 0.8554 }

## Descriptive Word {#DescriptiveWord}
A descriptive word is a word, describing a category as part of the category resources.
The category resources are filtered to sequences of tokens and then concatenated to
one token sequence per category. A descriptive word is a token in this sequence.
The structure of a descriptive word is somehow similar to the 
_[Recognized Word](#RecognizedWord)_ structure

### Slots

* **no**  
  _integer number_ `[0..n]` the position of the word in the token sequence
* **text**  
  _string_ the characters of the word
* **lexical-form**  
  _string_ a copy of the text 
  to provide the same interface as _[Recognized Words](#RecognizedWord)_
* **confidence**  
  _floating point number_ has always the value of `1` because a descriptive word
  is part of the category resources and therefore has no recognition confidence

### Example
	{ :no 455
      :text "way"
      :lexical-confidence "way"
      :confidence 1 }

## Category Word {#CategoryWord}
A category word is a word which occurs at least one time in the category resources.
Every category word is represented by some statistical values and
a list of _[Category Word Occurrences](#CategoryWordOccurrence)_.

### Slots

* **id**  
  _string_ an identifier, that can be used ax HTML/XML ID or as a file name 
* **lexical-form**  
  _string_ the lexical form of the word
* **occurrences**  
  _vector_ of _[Category Word Occurrences](#CategoryWordOccurrence)_
* **occurrence-count**  
  _integer number_ `[1..n]` the number of occurrences (cached for easy accessibility)
* **mean-confidence**  
  _floating point number_ has always the value of `1` because all category word occurrences
  have the confidence of `1`
* **match-value**  
  _floating point number_ `[0..1]` the weight of this word in the context of the category

### Example
	{ :id "bioinformatik"
      :lexical-form "Bioinformatik"
      :occurrences [ {:category-id "biology"
                      :no 466
                      :confidence 1}
                     ... ]
      :occurrence-count 21
      :mean-confidence 0.8234
      :match-value 0.01522 }

## Medium Match {#MediumMatch}
The medium match describes the matching result between a category and a medium.

### Slots

* **medium-id**  
  _string_ the id of the matched medium
* **word-scores**  
  _map_ a look-up table, which maps from word IDs to word matching scores
* **score**  
  _floating point number_ `[0..1]` the matching score between the category and the medium

### Example
	{ :medium-id "video08"
      :word-scores { "hair" 0.00023
                     "tube" 1.6882E-4
                     ... } }


*[EDN]: Extensible Data Notation
*[HTML]: Hyper Text Markup Language
*[IPA]: International Phonetic Alphabet
*[PCM]: Pulse Code Modulation
*[URL]: Uniform Resource Locator
*[XML]: eXtensible Markup Language
*[SAPI]: Speech Application Programming Interface
*[GUID]: Globally Unique IDentifier