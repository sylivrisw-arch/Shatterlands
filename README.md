# Shatterlands

A first-person voxel destruction sandbox. Cut the terrain with the Impact Hammer, throw and detonate TNT, watch weakened ground collapse, and clear the rubble with the Blower.

The map is a fixed 15 × 15 chunks (225 blocks across) of terraces, hills, mountains and river gorges. The bedrock layer at the bottom can't be broken.

## Requirements

- Python (tested on 3.14)
- NumPy, pygame, PyOpenGL, Tkinter
- A graphics driver that supports GLSL 330
- **Optional:** SciPy (needed for terrain collapse), psutil (process stats), CuPy (needs CUDA)

There's no installer or requirements file yet. It was tested on an RTX 5060 Laptop GPU.

## Running

```
python Shatterlands.py
```

Click **Launch game**. To skip the launcher and start the game directly:

```
python Shatterlands.py --run-game builtin:shatterlands
```

You can add startup options after that command, for example `cubedetail-5 fps-60`. See `MASTER_PREFS.txt` for the full list.

## Tools

| Key | Tool | Use |
|---|---|---|
| 1 | Impact Hammer | Left-click to make a small cut. It can weaken nearby ground. |
| 2 | TNT | Hold left-click to aim, release to throw, then click again to detonate. One charge at a time. |
| 3 | Blower | Hold left-click to pull in loose cubes and remove them. Mouse wheel switches between 1× and 2× power. |

## Controls

| Key | Action |
|---|---|
| W A S D / Mouse | Move / look |
| Space / Left Shift | Jump / sprint |
| V | Toggle flight (Space to rise, Ctrl to descend) |
| F | Pause the simulation (you can still move) |
| X | Toggle cube grid lines |
| G / H | Diagnostics panel / colour overlays |
| F9 | Save a diagnostics report (PNG + JSON) |
| T | Record a clip (up to 15 seconds) |
| R | Reset panel |
| Tab | Settings |
| Esc | Close the menu, or quit |

## Output

- **Settings** are saved to `engineui_config.json` beside the script.
- **Recordings** are Motion JPEG AVI files at 30 fps, saved beside the script.
- **Diagnostics reports** go into `diagnostics/`.
- **Terrain and mesh caches** go into `cache/`.

World edits are not saved between sessions.

## Known limitations

- Collisions and resource limits still have known problems.
- Blower timing depends on the frame rate.
- High terrain detail uses a lot of memory: about 1.3 GiB per edited chunk at detail 50.
- Trees and survival are built but switched off.

## Docs

- `MASTER_README.txt`: the full game guide
- `MASTER_PREFS.txt`: settings, startup options and diagnostics
- `MASTER_LORE.txt`: world lore
