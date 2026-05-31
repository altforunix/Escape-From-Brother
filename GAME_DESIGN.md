# Escape From Brother - Game Design Document

## Overview
A tense 2D escape game where the player must complete randomly selected tasks before reaching the safety of the parents' room, all while being chased by an increasingly hostile older brother.

## Game Flow
1. **Intro Scene** - Narrative setup at 3AM
2. **Main Game** - Escape and collect 6 of 20 random tasks
3. **Win/Lose** - Reach parents room (success) or get caught (failure)

## Controls
- **Arrow Keys or WASD**: Move character
- **Get close to task locations** to complete them (yellow markers)
- **Reach the right edge** (parents room) after completing all tasks

## Game Mechanics
- **Player**: Controllable green character with 250 speed
- **Brother**: Red AI-controlled pursuer (180 base speed, increases over time)
- **Tasks**: 20 available, 6 randomly selected each game
- **Win Condition**: Complete 6 tasks + reach parents room
- **Lose Condition**: Get caught by brother (collision)
- **Difficulty Scaling**: Brother speed increases as time progresses

## Task List (20 total)
1. Find Keys
2. Disable Alarm
3. Get Jacket
4. Grab Flashlight
5. Find Phone
6. Get Backpack
7. Unlock Window
8. Hide Evidence
9. Grab Water Bottle
10. Find Shoes
11. Get Money
12. Find Map
13. Grab Knife
14. Get Rope
15. Find Lighter
16. Get Matches
17. Find Compass
18. Grab Duct Tape
19. Get Binoculars
20. Find Medical Kit

## Game Features
✓ Complete Godot 4 game with no stubs or placeholders
✓ 20 unique tasks to collect (6 randomly selected each playthrough)
✓ Dynamic AI brother that speeds up over time
✓ Real-time task counter and timer
✓ Visual task markers on screen
✓ Win/Lose conditions with statistics
✓ Main menu
✓ Story intro cinematics
✓ Smooth 2D physics and collision detection
