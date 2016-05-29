# Musical Instrument Recognition System using Artificial Neural Networks


## Introduction
In this study, Artificial Neural Networks (ANN) were used to compare different characteristics of musical instruments and study their ability to distinguish a range of instruments. This was performed using the frequency spectrum of the audio signal, together with an, comparing the accuracy of the network in the cases of the following experiments:
* The whole sample
* The attack of the sound
* Everything but the attack of the sound
* The initial 100 Hz of the frequency spectrum
* The following 900 Hz of the frequency spectrum

## Dataset
<img src="/plots/pca.png" width="400px">
The dataset used in this project was the [London Philharmonic Orchestra Dataset](http://www.philharmonia.co.uk/explore/make_music), consisting of recorded samples from 20 different musical instruments. For each instrument, the samples range over its entire set of tones played in every octave with different levels of strength (piano, forte) and length. In addition to that, the dataset also includes samples where different playing techniques are used with the instrument, such as _vibrato_, _tremolo_, _pizzicato_ and _ponticello_.

In order to limit the scope of this project, the following eight instruments were selected to train the model: Banjo, Cello, Clarinet, English horn, Guitar, Oboe, Trumpet and Violin. This set of instruments was chosen because of the high quality of the samples and them ranging over the three instrument families Brass, String and Woodwind. 

To avoid handling potential different harmonics in the same tone across the octaves, only the samples of recordings done in the fourth octave were used.

| Index | Instruments | Samples |
| :---: | :---------: | :—————: |
| 1   | Banjo | 23 |
| 2   | Cello | 166 |


_2016, Babak Toghiani-Rizi & Marcus Windmark_