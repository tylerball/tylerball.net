---
title: batch generating jpgs from fuji raw files
published: true
date: 2019-07-05
---

The best Google service is [Google Photos][goog]. Despite one's usage probably
providing material to train Google's machine learning corpus that will
eventually enslave us all, having a canny search function for your
unorganized archive of digital photos is worth it. Type in "dog" and you get
all the photos of your dog.

My problem is it doesn't support raw files from Fuji cameras, of which I have a
few. In the future I can solve this problem by shooting in `RAW+JPEG`, which
stores a `.jpg` file processed with the camera's colour profiles that the
Google sync app can pick up and put on Google Photos.

But what do I do with my years-long archive? I tried a few different batch
image converters but none of them retained the Fuji film simulations, or
adjustments I had done in Lightroom. I also
couldn't find a way to filter my photos in Lightroom for the images that lacked a
corresponding `.jpg` file and convert them that way.

Enter [`raw2jpg`][raw2jpg], a script I wrote for bulk converting raw files that is
`RAW+JPEG` aware and applies adjustments made to the image in Lightroom or
Photoshop. To install it run:

```
brew cask install adobe-dng-converter
brew install exiftool
curl -Lk https://raw.githubusercontent.com/tylerball/raw2jpg/master/raw2jpg > /usr/local/bin/raw2jpg
```

Then you can run it on a directory of RAW files.

```
raw2jpg ~/Photos/Fuji
```

[goog]:https://www.google.com/photos/about/
[raw2jpg]:https://github.com/tylerball/raw2jpg
