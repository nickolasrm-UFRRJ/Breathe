# Breathe
This project consist of a game based on Pink Floyd's songs, and mainly on The
Dark Side of The Moon album in which gave us the colored geometric style idea
to concept this game.

## Images


## Mechanics

### Shop time
A time interval in which no enemies are spawned. It lasts 15s.
Shop times are always skippable by clicking the play button at the top center
of the screen.

### Wave
A time interval in which enemies are spawned until there are no more
enemies into the spawn queue or a shop time is reached.

### Path
The level path is a continuous set of tiles in which enemies walk through in 
from the starting point to the end point. If an enemy reaches the end point
you lose a life.

### Start point
Start point is the entry tile of path that enemies spawn.

### End point
End point is the last tile of the path in which enemies want to reach.

### Block
Blocks are red tiles in which blocks the player of putting a turret in that
position.

### Lifes
At the top left of the screen there are level-varying number of hearts in which
each of them represent the number of lives you have left. If an enemy reaches
the end point, you lost a life, and if you lost all lives, then you will be
transported to the game over screen.

### Coins
At the top right of the screen there is a golden circle icon representing the
coins. Aside of it, is the number of coins  you currently have. If the number
of coins is >= than the turret cost, you'll be able to buy it, otherwise, not.

### Turrets
Turrets are blocks you use coins to buy and can be placed in non block and non
path tiles if they are not occupied by another turret. Each turret is more
appropriate for an enemy, and they vary on damage, fire delay, range and price.
Check the table below for more information:

| Name       | Fire delay(s) | Range | Damage | Price |
|------------|---------------|-------|--------|-------|
| Regular    | 1             | 48    | 2      | 100   |
| Fast       | 0.75          | 36    | 1      | 60    |
| Ranger     | 2             | 96    | 15     | 150   |
| Heavy      | 2             | 36    | 50     | 200   |
| Submachine | 0.2           | 36    | 1      | 300   |

### Enemies:
Enemies are object that move through the path from the start point to the end
point that should be destroyed by turrets, otherwise, they can reach an
endpoint enabling the player to lose the game. Enemies vary on speed, health,
number of sides, color, and coins. Their specification is described below:

| Name    | Health | Speed | Nof sides | Color  | Coins |
|---------|--------|-------|-----------|--------|-------|
| Fast    | 1      | 100   | 3         | Yellow | 7     |
| Regular | 4      | 40    | 4         | Orange | 12    |
| Heavy   | 10     | 25    | 5         | Violet | 25    |
| Tank    | 50     | 20    | 6         | Purple | 40    |
| Boss    | 400    | 20    | 7         | Red    | 100   |

## Goal
The main goal of this game is to find the right combination of turrets for each
enemy. But for doing this, the player will have to plan when it is time to 
accumulate coins to buy an expensier turret, or when it is time to buy a cheaper
turret. Aside of this, the player also have to know what are the best spots to
place turrets.

## Editor
In the bottom left side of the menu screen there's a brush icon, when clicked
the player is transported to the editor.


The editor has two main screens, one for the map editing and another for the
events (wave, stats, and shop time) sequence editing. The gif above shows an
example of how to make a level for Breathe.

## Contribution
Feel free to contribute with this project, we'd be happy to see our game become
more and more rich of mechanics, graphics or other features.

## Engine
This game was developed in Godot 3.4.4. Check their [website](https://godotengine.org/)
for more information.

## Authors
* Natalia Zambe([nataliazambe](https://github.com/nataliazambe))
* João Pedro Ribeiro ([JayPOS](https://github.com/JayPOS))
* Nickolas da Rocha Machado ([nickolasrm](https://github.com/nickolasrm))
