SHATTERLANDS — GAME README
Documentation synchronized: 11 November 2026

Shatterlands is a first-person voxel destruction sandbox. Explore the
terrain, cut it with the Impact Hammer, throw and detonate TNT, watch
weakened ground collapse, and clear loose rubble with the Blower.

The fixed map is 15 x 15 chunks, 225 blocks across. Procedural terraces,
hills, mountains and river/gorge features form the landscape. Tool paths
protect the bottom bedrock layer by restoring it after digging. Collapse
checks are local approximations, so an apparently unsupported formation
is not guaranteed to fall. The engine contains structural fracture and
rigid-body code, but world-structure creation is not enabled in gameplay.

STARTING
========
Run the script and click Launch game:
    python Shatterlands.py
Or start gameplay directly:
    python Shatterlands.py --run-game builtin:shatterlands

Launcher, engine and game are bundled in this script. Runtime imports
include NumPy, pygame and PyOpenGL; the launcher uses Tkinter. GLSL 330
shaders require a compatible graphics driver. SciPy enables terrain
collapse checks: those checks return no groups when it is unavailable.
Some structural-labeling paths have NumPy/CuPy fallbacks. psutil provides
optional process statistics; CuPy requires compatible CUDA support.

The supplied file set has no dependency manifest or installer. This README
does not claim a clean-install test or a certified package/hardware range.
Earlier validation used Python 3.14 and an RTX 5060 Laptop GPU. Preferences
and recordings need a writable script folder; F9 also needs permission to
create diagnostics/.

TOOLS
=====
1 — Impact Hammer: left-click for a small local cut. It can weaken nearby
ground and trigger immediate or delayed collapse. Its excavation path
uses tool_crater(), then world.dig().
2 — TNT (initial selection): hold left-click to aim and charge a throw;
release to throw. Click after landing to detonate. Only one charge,
including one in flight, is supported. Throws outside the map can be lost.
Terrain TNT uses c4_explode() and world.dig(); it also damages surrounding
ground and propels debris.
3 — Blower: hold left-click to pull loose cubes into the nozzle and remove
them. Wheel down selects 1x, wheel up 2x. Higher power increases pull and
reach.

CONTROLS
========
W/A/S/D                 Move
Mouse                   Look and aim
Space                   Jump
Left Shift              Sprint
V                       Toggle flight
Space / Left Ctrl       Rise / descend while flying
1 / 2 / 3               Hammer / TNT / Blower
F                       Pause simulation; movement remains available
X                       Toggle cube grid lines
G                       Cycle diagnostics: off / simple / advanced
H                       Cycle diagnostic colour/motion overlays
F9                      Save diagnostic PNG report and JSON data
R                       Open reset panel
Tab                     Open/close settings
[ / ]                   Switch settings tabs
Up / Down               Select settings rows or scroll Controls
Left / Right / Enter    Adjust or activate settings
Mouse                   Click settings; drag sliders
T                       Start recording / stop early
Esc                     Close an open menu; otherwise quit

Menus freeze the world. Reset-panel actions use the mouse. Settings tabs
are DISPLAY, CUBES, CONTROLS and RECORDING.

DIAGNOSTICS
===========
G enables a compact corner panel; another press selects advanced mode,
then off. The panel shows CPU-work/GPU-measured-stage timing, smoothed
graphs, target-budget bars and cube totals. Advanced mode adds activity,
memory, hardware readings and key game settings. Debris stays purple
while diagnostics are enabled; ordinary colours return when disabled.

H cycles normal, damage, stress, integrity and motion views. H enables
simple diagnostics if off. Damage/integrity views sample nearby terrain;
stress describes structural solver data and can be empty without
structures. Motion vectors show speed intensity, not material temperature.
Available GPU temperature is a separate hardware reading.

For a report, enable diagnostics, let history collect, reproduce the
slowdown and press F9. Matching PNG and JSON files are created under
diagnostics/ beside the script. F9 also enables simple mode if off.
The PNG includes graphs, counters, settings and a gameplay snapshot; the
JSON adds raw timing/counter histories and renderer/platform details.
Upload the PNG and, when possible, its JSON for diagnosis.
F9 readback and file writing can intentionally cause a brief hitch.

CPU work is elapsed main-thread work, not total processor utilization.
GPU graph values are delayed measurements of selected GL stages, not
whole-device utilization. Their bars overlap in time and must not be
added. Missing/stale values show N/A. MASTER_PREFS.txt defines the counters,
sampling limits and settings. Diagnostics have small, nonzero overhead;
existing short comparisons do not guarantee every scene's performance.

RESET, SAVING AND OUTPUT
=======================
Reset damage restores terrain and clears debris, structures, charges,
pending collapses and blast effects. Return to spawn is a separate action.
Restart with new settings starts a new session; terrain detail applies
at startup. World edits and structures are not persistent saves.

Selected preferences are stored in engineui_config.json beside the script.
Most ordinary Python-script launches use cache/ beside the script for
terrain/mesh caches. SHATTERLANDS_CACHE_DIR overrides that location; if
sys.argv[0] does not end in .py, the default cache base is the working
directory. Caches and diagnostic captures are not saved player worlds.

T records silent Motion JPEG AVI files beside the script, up to 15 seconds.
Presets are 854 x 480, 1280 x 720 and 1920 x 1080 (default). The timeline
is 30 FPS; slow capture duplicates frames. Encoding/writing run in the
game loop. End-to-end AVI playback was not verified in this documentation
pass; a working F9 PNG capture does not establish working video recording.

LIMITATIONS AND VERIFICATION
===========================
The script still has collision and resource-limit issues, plus frame-rate-dependent Blower timing. At detail 50, one edited dense terrain chunk alone
uses about 1.265 GiB. Default 200% debris and disabled total-debris capping
can be expensive. Exact cube-count/volume conservation is not guaranteed.
Trees and thirst/canteen code remain disabled.

This synchronization checked current source, settings and paths.
Earlier diagnostics validation included hidden real-OpenGL startup,
PNG/JSON capture and a bounded blast comparison. It was not an exhaustive
gameplay, clean-install, capacity or collision test, and was not repeated
for this documentation-only change. Exposed maxima are not safe hardware
recommendations. Source agreement is not proof of bug-free runtime behaviour.

DOCUMENT MAP
============
MASTER_LORE.txt             World lore; no technical specification
MASTER_PREFS.txt                   Defaults, ranges, persistence and diagnostics