#!/bin/sh

d2 --bundle --pad 10 usecase1.d2 usecase1.svg
d2 --bundle --pad 10 --scale 4 usecase1.d2 usecase1.png

d2 --bundle --pad 10 usecase2.d2 usecase2.svg
d2 --bundle --pad 10 --scale 4 usecase2.d2 usecase2.png

d2 --bundle --pad 10 feature1.d2 feature1.svg
d2 --bundle --pad 10 --scale 4 feature1.d2 feature1.png

d2 --bundle --pad 10 feature2.d2 feature2.svg
d2 --bundle --pad 10 --scale 4 feature2.d2 feature2.png
