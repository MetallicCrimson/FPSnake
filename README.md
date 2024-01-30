# FPSnake

## Description
Are you prepared for some crazy 3D action?

![github_img](https://github.com/MetallicCrimson/FPSnake/assets/67794509/d1459c1f-a756-4c5f-b054-7bade324d747)


You already know the rules: go around, get the apples, don't hit the wall (or yourself). What else could the classic Snake be?  
Well, elevating the concept into the third dimension makes it much more. Sure, collecting apples is still the main goal, but getting into the snake's viewpoint, flying through the map, doing crazy maneuvers; these make it much more fun. Who cares about points, when you can pull a corkscrew instead?

The game is entirely controlled by turning with either the arrow keys, or the left stick on a controller. No forward input is needed, since we're talking about Snake, after all.  
You have three lives, as shown in the upper right corner. Each hit comes with 2 seconds of invincibility; use it wisely!
If the apple is not on the screen, an arrow at the edge helps to locate it.  
You can pause/unpause with Enter (or Start on a controller).  
You start with 100 length, the first point adds another 100, the next one adds 101, etc...

Note: The game was mostly tested on a controller, and definitely feels better on one.

## Tech details
This game was developed by Daniel Kovacs, in Godot 4.2.1, immediately after doing the 3D tutorial. Its original purpose was to check if I can make a 3D game (albeit a quite simple one), but I might have had too much fun with it...  
Overall, it took a few days from start to finish, including testing on my much weaker laptop, and fighting with compatibility mode. I also quite repetitively tested my coffee machine in the process.

The biggest issue was definitely the arrow positioning: it would have been much easier if I kept it rotating in its place, but what's the fun in that? (Hint: the fun is NOT rewriting half of the solution because VisibleOnScreenNotifier doesn't work with OpenGL3).

Honestly, after a while, the game felt much more a flying simulator than a snake game, so according to that feeling, I made the snake part easier, by giving the player three lives, making the hit collision detector smaller so risky maneuvers are not as risky (but you can catch points just as easily!), etc.

## Installation
No need to install, [releases can be found here for Windows, Linux, and Mac.](https://github.com/MetallicCrimson/FPSnake/releases/tag/v0.9)  Just download the appropriate executable file, and have fun with it.

Note 1: I still don't own a Mac (nor do I intend to), so I couldn't test that version. I've heard it can be really picky, especially because I'm not a certified Apple developer. If you encounter these problems, sorry; it might be better to just run the source code itself.

Note 2: If you have an older machine which doesn't support Vulkan (shoutout to my old Thinkpad with an i5-5300U and integrated HD 5500, which I absolutely love), you might have to run the executable with the command `--rendering-driver opengl3`. This makes the lights a bit worse, but it doesn't cause any issue.
