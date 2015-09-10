# DrawBMP
A Ruby script to make geometric BMP images via the command line.

## How to play
Clone this repo and run `ruby script/bmp.rb` (with optional arguments) in the project's root directory. I don't know how well this is going to work on Windows machines.

## CLI
`ruby script/bmp.rb "x+y" "y-x" "dist(x,y)" 512 512`  
The [propreantepenultimate](https://en.wiktionary.org/wiki/propreantepenultimate) argument is a ruby expression of red brightness (mod 256).  
The [preantepenultimate](https://en.wiktionary.org/wiki/preantepenultimate) argument is a ruby expression of green brightness (mod 256).  
The [antipentulimate](https://en.wiktionary.org/wiki/antipentulimate) argument is a ruby expression of blue brightness (mod 256).  
The [penultimate](https://en.wiktionary.org/wiki/penultimate) argument is the width of the canvas.  
The [ultimate](https://en.wiktionary.org/wiki/ultimate) argument is the height of the canvas.

## Valid expressions
You can use any valid ruby expression. `x` and `y` are defined as the horizontal and veritcal pixel distance from the lower left corner. `height` and `width` are the height and width of the canvas in pixels.

`dist(a,b)` is defined as the distance between a and b.
`sin(z)` and `cos(z)` are (appropriately scaled) sin and cosine functions.
`height` is defined as the height of the canvas.
`width` is defined as the width of the canvas.

## Defaults
If you leave an argument blank `""`, the image will fall back to a default expression.
##### Default red expression:
`2**0.5 * dist(x - @width, y - @height) * (256.0/@width)`

##### Default green expression:
`x + y > @width * 0.8 && x + y < @width * 1.2 ? 0x90 : 0x40`

##### Default blue expression:
`2**0.5 * 256.0/@width * dist(x,y)`

##### Default width and height:
`256`

## Examples
##### Example 1:
`ruby script/bmp.rb "2 * x" "0" "0" 300 256`  
![](https://github.com/peterokagey/DrawBMP/blob/master/images/example_1.bmp?raw=true)  
The canvas generally gets more red as the x value gets greater. Notice that red brightness is displayed by the last two hex digits of the value. Thus a value of `300` gets displayed the same as a value of `44` (via `300 % 256 = 44`). Because green and blue are set to zero, green and blue hues are absent from the `BMP`.

##### Example 2:
`ruby script/bmp.rb "0" "0" "" 300 256`  
![](https://github.com/peterokagey/DrawBMP/blob/master/images/example_2.bmp?raw=true)  
If an argument is left blank (as `""`) the default expression or value is used. In this case the default value for blue is:  
`2**0.5 * 256.0/@width * dist(x,y)`.  
Thus we see a quarter circle starting in the lower right corner.

##### Example 3:
`ruby script/bmp.rb "255 * ((Time.now.to_f * 1000) % 1)" "red(x,y)" "red(x,y)" 300 256`  
![](https://github.com/peterokagey/DrawBMP/blob/master/images/example_3.bmp?raw=true)  
The color brightness doesn't *have* to depend on the pixel position. In this case, the brightness depends on the millisecond that the pixel was processed.
Setting the blue and green expressions to `"red(x,y)"` effectively makes the image greyscale. (Although some color appears in this image due to the processing lag.)

##### Example 4:
`ruby script/bmp.rb "(5 * y) % [x,0.01].max" "3 * red(x,y)" "255.0/width * x" 500 256`  
![](https://github.com/peterokagey/DrawBMP/blob/master/images/example_4.bmp?raw=true)  
I just thought that this one was cool.
