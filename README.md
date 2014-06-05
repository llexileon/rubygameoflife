
# Ruby Game of Life

An example of Conway's Game of Life written in Ruby using the [Gosu framework](http://code.google.com/p/gosu/).

![Screenshot](https://raw.githubusercontent.com/llexileon/rubygameoflife/master/assets/screen1.png)

I've used the Gosu library to add to the visualization of the game:

* A color transition is driven by the number of living cells each generation
* An audio sample of the note C5 is played each generation, it's pitch is raised or lowered depending on the number of living cells.

# Usage

    gem install gosu
    git clone git://github.com/llexileon/rubygameoflife.git
    cd rubygameoflife
    ./game.rb

# Controls

* P to play
* Q to quit
* Space to reset the game during play


# Resources

I've tried to implement the 4 rules of the game faithfully:

* Any live cell with fewer than two live neighbours dies, as if caused by under-population.
* Any live cell with two or three live neighbours lives on to the next generation.
* Any live cell with more than three live neighbours dies, as if by overcrowding.
* Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

For more information, see the [Conway's Game of Life wiki](http://en.wikipedia.org/wiki/Conway's_Game_of_Life).

# Thanks

The following samples are used with permission.

Soundtrack from http://audionautix.com