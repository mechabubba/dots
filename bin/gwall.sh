#!/bin/sh

# gwall - create and set a grid wallpaper
# usage: gwall color1 color2 <step-size> <image-resolution>
#
# you shouldn't really set image-resolution, but do what your heart tells you to
# due to ImageMagick's command-line argument limit, max step size is something less than 50
#
# deps: ImageMagick, feh
#
# modified from https://gist.github.com/krzysckh/938593f83fe482049877040b4faf15d0
# krzysckh 2021

us() {
	echo "usage: $0 color1 color2 <step> <res>"
	exit
}

res="24"
c1="$1"
c2="$2"

[ -z "$c1" ] && us
[ -z "$c2" ] && us
[ -z "$3" ] && step="2" || step="$3"
[ -z "$4" ] && res=$((step*10)) || res="$4"

res=$((res*2))

x=0
y=0
push=0
lines=""

while [ "$y" -lt "$res" ]
do
	if [ "$push" -eq 0 ]
	then 
		x=0
	else
		x="$step"
	fi

	while [ "$x" -lt "$res" ]
	do
		lines="$lines line $x,$y $((x+step-1)),$y"
		x=$((x+step+step))
	done

	y=$((y+1))

	if [ "$((y % step))" -eq 0 ]
	then
		if [ "$push" -eq 0 ]
		then
			push=1
		else
			push=0
		fi
	fi
done

convert -size "${res}"x"${res}" xc:"${c1}" -stroke "${c2}" -draw "${lines}" /tmp/wall.png
feh --no-fehbg --bg-tile /tmp/wall.png > /dev/null

