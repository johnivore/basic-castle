# quick and dirty convert an svg file to a png file using inkscape
function svg2png
    set -l pngfile (basename $argv .svg).png
    inkscape -o $pngfile -w 1024 -h 1024 $argv && convert $pngfile -background transparent -gravity center -scale 400x400 -extent 500x500 $pngfile
    file $pngfile
end
