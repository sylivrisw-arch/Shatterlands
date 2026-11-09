# Shatterlands Beta

[VERIFIED BY SOURCE REVIEW, 2026-11-09] Reviewed against `Shatterlands-beta(1).py` (14,033 lines). The launcher and both embedded modules passed syntax compilation. Gameplay and Windows launch were not tested.

Shatterlands is a single-file Python and OpenGL voxel destruction sandbox. Use the hammer or TNT to dig and break structures, collect loose stone with the Blower, and trade it for credits through the Checklist. Severed terrain can fall as a rigid slab. Imported `.cells` objects can be placed and destroyed in the world.

## [VERIFIED] Run the game

1. Install Python 3 with Tkinter for the launcher, then run `python -m pip install pygame numpy PyOpenGL`. Optional packages include SciPy, psutil and a CUDA-compatible CuPy build.
2. Run `python "Shatterlands-beta(1).py"` using the filename on disk and press **Launch game** in the **Shatterlands - beta** window.
3. Use the cog beside **Launch game** to enter launch commands. The launcher keeps those commands in `engineui_config.json`.

The launcher starts at 380 × 500, with a shorter height on small screens. The game defaults to fullscreen using a 1920 × 1080 game and menu canvas. The default 120% scene scale renders at 2304 × 1296. Terrain and mesh caches default to the `cache` folder beside the script. `SHATTERLANDS_CACHE_DIR` can override that location.

| Launch command | Effect |
|---|---|
| `cubedetail-N`, `cubedetail-max` | Whole cubes per block edge from 1 to 50. Default 2. Max selects 50. |
| `fps-N` | Frame cap from 0 to 1000. Default 60. Zero is uncapped. |
| `scale-N` | Scene resolution from 25% to 150%. |
| `debris-N`, `debris-off` | Debris amount from 0% to 100%. Zero and off disable ordinary debris. |
| `cpuphysics` | Select CPU debris physics. |
| `nocache` | Disable terrain and mesh caches for the run. |
| `raymarch` | Enable the GPU ray-marched terrain path. |

## [VERIFIED] Controls

| Input | Action |
|---|---|
| W A S D, mouse, Space, Left Shift | Move, look, jump, sprint. |
| V | Toggle flight. Space rises and Left Ctrl descends. |
| 1 · Impact Hammer | Left-click to swing. Fixed at 1×. |
| 2 · TNT | Hold left-click to aim and charge, release to throw, then left-click again after it lands to detonate. One charge at a time, fixed at 1.5×. |
| 3 · Blower | Hold left-click to vacuum loose cubes. Scroll down for 1× or up for 2× suction. Stone goes into carried inventory. Other swallowed debris is cleared. |
| 4 · Checklist or Q | Equip the Checklist and left-click to open it, or press Q directly. Q or Esc closes the panel. |
| Tab | Open Display, Scans and Controls. |
| F, X, G | Pause simulation while keeping movement, toggle grid lines, toggle the damage and performance overlay. |
| R | Open the reset menu for damage or return to spawn. Resetting damage clears carried stone. |
| Esc | Close an open menu or quit from gameplay. |

The Blower is suction-only. The old hut, physical storage crates, B-key storage and cube-selection outline are absent from the active gameplay path. Progress actions are in the Checklist.

## [VERIFIED] Checklist and stone economy

| Tab | What you can do |
|---|---|
| Checklist | View carried stone in stacks of 500 and edit or tick six personal tasks. |
| Storage | Deposit all carried stone or withdraw up to 500 at a time. |
| Upgrades | Spend credits to increase the upgrade level. Costs start at 100 and increase by 100 per level. The purchase updates the level counter. |
| Tools | Review tool controls. |
| Jobs | Deliver 500 stored stone for 100 credits and one completed job. |

Carried and stored stone, credits, completed jobs, upgrade levels and personal tasks are session-only. A fresh launch starts from zero with an empty personal checklist. The game does not load or write an HQ progress save.

## [VERIFIED] Terrain and debris

The map is 15 × 15 chunks (225 blocks across). Ordinary TNT terrain debris has half the source cell's edge length. Debris settings and collision filters can reduce the number spawned. The optional loose debris cap starts off. Enable it under **Tab → Display → Debris** for a 12,000-cube cap at full debris amount.

## [VERIFIED] Import a scan

1. Put the `.cells` file beside the game script, in its `scans` folder, in the current working directory, or in `~/Downloads/scan_exports`.
2. Open **Tab → Scans**. Click a scan or select it with the arrow keys and press Enter. The list refreshes about once a second while that tab is open.
3. The game resamples the scan to the current cube detail and places it roughly four blocks ahead as a fixed structure. **Reset all damage** clears placed scans.

The importer reads JSON with `materials` and `cells`. Each cell entry is `[x, y, half_thickness, material_index]`. `cubes_per_block` defaults to 5 if omitted. The loader does not check the format tag, so older `voidcraft.cells.v1` exports can still work if their fields match.

## [VERIFIED] Edit the embedded source

Use `--export-engine engine.py` or `--export-game game.py` after the script filename to export the relevant module. Use `--replace-engine engine.py` or `--replace-game game.py` to put edited code back. Replacement keeps a `.bak` of the script. See the prefs for current source locations and historical tuning notes.

## [UNVERIFIED] External scanner files and workflow

`scanner_server.py` and `scanner.html` were not supplied. All claims below about their UI, dependencies, routes, processing, testing history and export behavior are carried forward from earlier notes, not verified in this review.

| File | Status |
|---|---|
| `scanner_server.py` | [UNVERIFIED] External scanner server; not supplied for this audit. |
| `scanner.html` | [UNVERIFIED] External phone interface; not supplied for this audit. |

### [UNVERIFIED] The phone scanner

The phone is only a camera and a viewer. The laptop does the work.

### Setup

1. On the laptop, install the packages: `pip install flask opencv-python numpy`. For the pairing QR code, also `pip install segno` (optional).
2. Run `python scanner_server.py`. It listens on port 5055 and prints the address for your phone.
3. Put the phone on the same Wi-Fi network and open that address, or scan the QR code the server opens in the laptop browser. The QR code is also in the About tab.

Options: `--port N`, `--export FOLDER`, `--no-browser`, `--terminal-qr`.

### Scanning

- **Video:** upload a short video of the object, ideally a slow turn around it.
- **Guided capture:** take photos of Front, Right, Back and Left, plus an optional Top. The scanner checks each one for blur, darkness and overlap with its neighbours, and tells you to redo a bad shot. If the sides are hard to capture, add a **Whole object** photo instead (it can be used alone or together with the sides).
- **Note:** say what the object is (rock, wood, ceramic, or leave it as auto). This sets the materials directly instead of guessing from colour.

Then open the Model tab. You can spin the model with a full 360 degree swipe, ask for edits ("thicker", "taller", "trim top", "remove loose bits"), compare versions, and press **Import** to write the `.cells` file. Every scan is saved in History, with all its versions.

### What happens to the photos

Frames are cut out from their background (OpenCV GrabCut), turned into a 3D shape, converted to cubes, and given materials. Exports go to a `scan_exports` folder next to `scanner_server.py` by default, or to the folder you give with `--export`.

### [UNVERIFIED] Scanner limitations

- **The 3D shape is a placeholder.** The scanner picks one photo (or the whole-object photo), cuts it out and inflates it into a symmetric slab. Real multi-view reconstruction is not built yet.
- Hollow objects come out solid. A cup is a solid disc.
- Thin parts (leaves, twigs) disappear.
- White objects on white backgrounds cut out badly.
- Edit commands use a simple keyword matcher.
- Colours are not kept per cube. Only the material is.
- Thresholds were tuned on synthetic images. Real guided photos and Windows are lightly tested.

## [PROPOSED / UNVERIFIED IMPLEMENTATION STATUS] Scanner ideas

- Per-cube colour, for objects that look like the real thing.
- Real multi-view reconstruction from the guided photos or a video.
- A "what is this" step using a local vision model (LM Studio).
- Photo to scene: turn a beach photo into terrain, sea, sky and trees using the engine's own generators.
