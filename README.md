# txt2snd - Converts text to human readable spectrograms

## To use this:

- Ensure you have installed "printerbanner", perl and sox
- Put your text in input.txt
- run the `run` script.

## What this will do:

- Invokes "printerbanner" to turn the text into an text-based banner image
- Generates a raw audio file from that image, encoding the banner image
  into the spectrogram of the audio file, mostly outside audible range
- Converts the raw audio file to wav.

## Limitations:

Using lossy audio compressors may make the text less legible.
Using a lower start frequency on the command line (`--startfreq=xxxxx`)
or a greater amplitude (see variable `$amplitude` in the script)
may remedy this to a point, at the cost of possibly making the watermark
audible during wave playback.
