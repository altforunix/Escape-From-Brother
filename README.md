# Escape From Brother

A complete 2D escape game made in **Godot 4**. It's 3AM and your older brother wakes up, remembering "all the evil things." Now you must escape!

## 🎮 How to Play

1. **Start the game** and watch the intro story
2. **Collect 6 randomly selected tasks** from 20 available (yellow markers on screen)
3. **Avoid your pursuing brother** (red character chasing you)
4. **Reach the parents' room** (right side of screen) after collecting all tasks to win!

## ⌨️ Controls

- **Arrow Keys** or **WASD**: Move your character
- **Proximity**: Get close to yellow task markers to collect them
- **Escape**: Reach the right edge of the screen (parents' room)

## 🎮 Gameplay Features

✅ **Complete game** - fully functional with no stubs or placeholders
✅ **20 unique tasks** - 6 randomly selected each playthrough for replayability
✅ **Dynamic AI** - brother chases you and gets faster over time
✅ **Real-time UI** - task counter, timer, and status display
✅ **Win/Lose conditions** - clear objectives and outcomes
✅ **Story intro** - cinematic opening at 3AM
✅ **Main menu** - start game or quit
✅ **Smooth physics** - Godot 4 physics engine with collision detection

## 📁 Project Structure

```
Escape-From-Brother/
├── project.godot              # Godot 4 project configuration
├── GAME_DESIGN.md             # Game design document
├── README.md                  # This file
├── .gitignore                 # Git ignore file
├── scenes/
│   ├── main_scene.tscn        # Main menu scene
│   ├── intro_scene.tscn       # Intro cinematics scene
│   └── game_scene.tscn        # Main gameplay scene
└── scripts/
    ├── main_scene.gd          # Main menu controller
    ├── intro_scene.gd         # Intro controller
    ├── game_scene.gd          # Game controller & task system
    ├── player.gd              # Player movement & collision
    └── brother.gd             # Brother AI chasing logic
```

## 🚀 Requirements

- **Godot 4.0** or later
- No external dependencies required
- Works on Windows, macOS, and Linux

## ▶️ Running the Game

1. **Open Godot 4**
2. **Open this project** by selecting the project folder
3. **Press F5** or click "Play" to start the game

## 🎯 Game Mechanics Explained

### Player (Green)
- Move at 250 pixels/second
- Collect tasks by getting close to yellow markers
- Win by reaching the right edge after collecting 6 tasks

### Brother (Red)
- Starts at 180 pixels/second
- Speed increases 0.5 pixels/second every second
- AI constantly chases the player
- Catches player on collision

### Tasks
- 20 different tasks available in the game
- 6 tasks randomly selected each playthrough
- Complete all 6 to unlock the parents' room
- Each task has a unique name and location

### Win Condition
- Collect all 6 required tasks
- Reach the parents' room (right edge of screen)
- Display time and statistics

### Lose Condition
- Get caught by your brother (collision)
- Game resets after 4 seconds

## 📊 Game Stats

- **Screen Size**: 1000x600 pixels
- **Player Speed**: 250 px/s
- **Brother Base Speed**: 180 px/s (increases over time)
- **Detection Range**: 35 pixels for task collection
- **Catch Range**: 40 pixels for brother collision
- **Tasks Required**: 6 out of 20
- **Game Duration**: Average 60-120 seconds

---

**Made with ❤️ in Godot 4** | No external assets or dependencies
