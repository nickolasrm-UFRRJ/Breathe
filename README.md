# Breathe
This project consist of a game based on Pink Floyd's songs, and mainly on The
Dark Side of The Moon album in which gave us the colored geometric style idea
to concept this game.

## Images
![Game menu](https://github.com/nickolasrm-UFRRJ/Breathe/blob/main/screenshots/menu.gif?raw=true)

![Gameplay](https://github.com/nickolasrm-UFRRJ/Breathe/blob/main/screenshots/gameplay.gif?raw=true)

## Mechanics

### Shop time
A time interval in which no enemies are spawned. It lasts 15s.
Shop times are always skippable by clicking the play button at the top center
of the screen.

### Wave
A time interval in which enemies are spawned until there are no more
enemies into the spawn queue or a shop time is reached.

### Path
The level path is a continuous set of tiles in which enemies walk through 
from the starting point to the end point. If an enemy reaches the end point
the player lose a life.

### Start point
Start point is the entry tile of path that enemies spawn. Represented by green.

### End point
End point is the last tile of the path in which enemies want to reach. Represented by yellow.

### Block
Blocks are red tiles in which blocks the player of putting a turret in that
position.

### Lifes
At the top left spot of the screen there are level-specified number of hearts in which
represent the number of lives the player have left. If an enemy reaches
the end point, the player loses a life, and if the player loses all lives, then the scene
will change to the game over scene.

### Coins
At the top right spot of the screen there is a golden circle icon representing the
coins. Aside of it, is the number of coins the player currently have. If the number
of coins is >= than the turret price, the player will be able to buy it, otherwise, it wont.

### Turrets
Turrets are blocks the player spend coins to buy, and place into a non block and non
path tiles if they are not occupied by another turret. Each turret is more
appropriate for an enemy, varying on damage, fire delay, range, color, and price.
Check the table below for more information:

| Name       | Fire delay(s) | Range | Damage | Color   | Price |
|------------|---------------|-------|--------|---------|-------|
| Regular    | 1             | 48    | 2      | Red     | 100   |
| Fast       | 0.75          | 36    | 1      | Lime    | 60    |
| Ranger     | 2             | 96    | 15     | Cyan    | 150   |
| Heavy      | 2             | 36    | 50     | Purple  | 200   |
| Submachine | 0.2           | 36    | 1      | Pink    | 300   |

#### Turrets representation in the game
Each turret card on the turrets deck contains three numbers, they are respectively:
fire delay, damage and price.

![Ranges preview](https://github.com/nickolasrm-UFRRJ/Breathe/blob/main/screenshots/ranges.gif?raw=true)

### Enemies:
Enemies are objects that move through the path from the start point to the end
point. They have to be destroyed by turrets, otherwise, they can reach an
endpoint, enabling the player to lose the game. Enemies vary on speed, health,
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
accumulate coins and buy an expensier turret, or when it is time to buy a cheaper
turret. Aside of this, the player also have to know what are the best spots to
place turrets in order to maximize range.

## Editor
In the bottom left spot of the menu screen there's a brush icon, by clicking it,
the player is transported to the editor.

![Level creation example](https://github.com/nickolasrm-UFRRJ/Breathe/blob/main/screenshots/editor.gif?raw=true)

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
* Natalia Zambe ([nataliazambe](https://github.com/nataliazambe))
* João Pedro Ribeiro ([JayPOS](https://github.com/JayPOS))
* Nickolas da Rocha Machado ([nickolasrm](https://github.com/nickolasrm))
