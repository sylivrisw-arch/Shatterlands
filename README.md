# Shatterlands

A destruction sandbox and physics engine written in Python (pygame + OpenGL): blast, break and collapse structures built from cubes.

## Why everything is in zip files

The project is uploaded as **zip files instead of individual files**. This saves space and avoids confusion about which loose file belongs to which version. Download the zip you need and extract it.

| File | What it is |
|------|------------|
| `Shatterlands_game.zip` | The full game. |
| `ShatterEngine_update.zip` | The engine by itself, extracted from the game, so work on the engine's progress can be followed separately. |

## Getting started

1. Download `Shatterlands_game.zip` and extract it.
2. Install Python 3 and the required packages:

   ```
   pip install pygame numpy PyOpenGL scipy
   ```

   Optional: `opencv-python` (video recording) and `numba` (speed).
3. Run the game:

   ```
   python ShatterEngine2_reactive.py
   ```

A GPU with OpenGL compute shader support is needed.

## License

MIT. See the license file in the repository.
