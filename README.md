SHATTERLANDS BETA
MASTER README
=================

Shatterlands is a first-person voxel destruction sandbox built on
ShatterEngine, a custom Python and OpenGL engine. Dig with an Impact Hammer,
throw breaching charges, clear loose rubble with the Blower, and bring scanned
objects into the world as breakable structures.

Build reference   shatterlandsgood(1).py
Source reviewed   10 November 2026
Review scope      Launcher, embedded engine and game source. Syntax checked.
                  Gameplay, Windows launch and GPU performance need playtests.

Contents
  Part I    Run and play
  Part II   World lore
  Part III  Player profile and proposed opening
  Appendix  External scanner notes

PART I — RUN AND PLAY
=====================

Quick start
-----------
1. Install Python 3 with Tkinter for the launcher. In a terminal, run:

       python -m pip install pygame numpy PyOpenGL scipy

   SciPy supports terrain collapse checks. A compatible CuPy installation
   is optional for GPU debris compute. The game can use CPU debris physics.

2. Run the script from its folder and click Launch game:

       python "shatterlandsgood(1).py"

3. Press Tab for Display, Cubes, Scans, Controls and Recording. To change
   terrain detail, select the new value under Cubes, then choose
   Restart with new settings. Restarting resets the world session.

The launcher and game are bundled in the script. The game starts windowed
with a fixed 1920 × 1080 canvas and a default scene scale of 120%. Coded
defaults include 60 FPS, 5 terrain cubes per block edge, camera height of
126 cm, 95° vertical FOV and TNT size of 0.70×.

Supported menu settings are saved to engineui_config.json beside the script.
Fullscreen applies for the session. Generated terrain and mesh data are
cached in cache/ by default. SHATTERLANDS_CACHE_DIR overrides the cache path.

Controls
--------
Input                         Action
----------------------------  -----------------------------------------------
W / A / S / D                 Move
Mouse                         Look and aim
Space / Left Shift            Jump / sprint
V                             Toggle flight
Space / Left Ctrl             Rise / descend while flying
1                             Equip the Impact Hammer
2                             Equip the Breaching Charge (TNT)
3                             Equip the Blower
F                             Pause simulation while keeping movement
X                             Toggle grid lines
G                             Toggle the purple tint on loose debris
T                             Start recording or stop the current clip
R                             Open the damage and position reset menu
Tab                           Open or close Settings
[ / ]                         Switch Settings tabs
Up / Down                     Select rows or scroll Controls
Left / Right / Enter          Adjust or activate the selected setting
Esc                           Close a menu or quit from gameplay

Tools
-----
Impact Hammer   Left-click to chip terrain or hit a structure.
TNT             Hold left-click to aim and charge. Release to throw.
                After it lands, left-click again to detonate. One charge
                can be active at a time. Cubes has separate controls for
                explosion size, fireball size and shockwave push.
Blower          Hold left-click to vacuum loose debris and clear it.
                Scroll down for 1× suction or up for 2×.

The field checklist, stone inventory, deliveries and upgrades belong to
earlier builds and to the fiction below. The current build focuses on
breaking terrain and structures, clearing debris and importing scans.

Terrain and rendering
---------------------
The map is 15 × 15 chunks, or 225 blocks across, with an unbreakable
bottom layer. Severed terrain crumbles into loose cubes. Damage can also
weaken ground and trigger a delayed collapse. Detached pieces of
structures can fall as rigid bodies.

Terrain raymarching is enabled by default. The launcher reports whether
it is active or using chunk meshes. The main terrain voxel grid has a
10 GiB budget, with GPU texture dimensions and available memory imposing
additional limits. At default detail 5, the main grid is about 0.303 GiB.
At detail 16, it alone is about 9.463 GiB. See Shatterlands_Master_Prefs.txt
for the full table, advanced launch commands and playtest checks.

Reset and record
----------------
Press R to choose Reset All Damage or Reset Position to Spawn. Reset All
Damage restores terrain and clears loose debris, charges and placed scans.
Reset Position to Spawn moves the player back to the starting position.

Press T to record a clip up to 15 seconds at 30 FPS, or press T again to
stop early. The game saves a video-only Motion JPEG AVI beside the script.
Choose 480p, 720p or 1080p under Tab → Recording. G applies a purple tint
to loose debris, including in the recording.

Import a scan
-------------
1. Put a .cells file beside the script, in its scans/ folder, in the
   current working directory or in ~/Downloads/scan_exports.
2. Open Tab → Scans and click an entry, or select it and press Enter.
3. The game resamples the scan to the current terrain detail and places
   it as a breakable structure roughly four blocks ahead.

The importer reads JSON with materials and cells. A cell row is
[x, y, half_thickness, material_index]. Source cubes_per_block defaults
to 5. The format tag is unchecked, so older exports can work if their
fields match. Material names wood, dirt, stone, leaf and concrete map to
wood, dirt, dirt, planks and white concrete in this build.

Edit the embedded source
------------------------
Run these from the script folder to export the modules:

    python "shatterlandsgood(1).py" --export-engine engine.py
    python "shatterlandsgood(1).py" --export-game game.py

Use --replace-engine engine.py or --replace-game game.py to put edited
modules back. Replacement keeps a .bak of the script. For settings,
source locations and renderer details, see Shatterlands_Master_Prefs.txt.

PART II — WORLD LORE
====================
The history and customs in this section describe the world of Shatterlands.

The Unbroken Age
----------------
Before the Shatterlands there was only the Floor, a seamless plain of dirt
and stone resting on Bedrock. The material was all there, but nobody could
separate it into pieces small enough to use.

The First Blast
---------------
A surveyor set a charge beneath the plain. People remember the blast
although her name was lost long ago. The ground broke into thousands of
tiny cubes. Those who watched swore that what the blast took was what fell.
Miners call this the Scoop Law. Dust drifts away, and the sharpest-eyed
miners say a little is always missing.

The Hanging Ground and the Bedrock Line
---------------------------------------
Miners look for shelves of earth held up by a narrow neck of stone. Cut
through that neck and the shelf can turn over as it falls. Others crumble
and spill down the face in a shower of cubes.

Fire, smoke and dust rise and fade after a blast. Experienced miners
study the cracks that remain. Deep cracks tell them they have little
time to move. Their oldest rule is to look at what's holding a thing up
before they strike it.

Below it all is Bedrock. No charge has ever marked it. A miner can dig
away the land above and still find solid ground at the bottom.

Tools of the trade
------------------
The Impact Hammer takes a measured bite with every swing. Miners use it
to shape a crater, trim a ledge or find a structure's weakest point.
They throw breaching charges in an arc and set them off by hand once
they land. The Blower draws loose rubble into its nozzle. At high power
it reaches farther and pulls harder.

Stone deliveries
----------------
The field checklist records the stone a miner recovers and stores.
The old delivery terms are five hundred stone for one hundred credits.
Ask an old miner how to bring down a ledge and they'll tell you where
to put the charge. Ask where the delivered stone goes and they'll
tell you how much you're short.

The Echoes
----------
Miners bring images of objects from outside the Shatterlands to a scanning
post. It rebuilds a shed, a chair or even a boot from cubes in the material
the miner names. The resulting copy is called an Echo. It can be cracked,
cut and blasted. The post keeps a copy of the scan so a miner can bring
the Echo back and see how it falls from another angle.

PART III — PLAYER PROFILE AND PROPOSED OPENING
=============================================

The miner
---------
The player character is a man who makes his living breaking ground and
recovering stone. His name, age and life before mining are open. He can
spend most of a shift vacuuming rubble and still take pride in the few
seconds it took to bring a ledge down exactly where he wanted it. He judges
a blast by where the rubble lands. If it's within reach, he's saved himself
a long afternoon.

The first camp
--------------
While looking for a place to work, the miner comes across an old survey
post marking the First Blast. He stops to read it.

    FIRST BLAST SURVEY
    Bedrock untouched.
    Loose stone recovered.
    Second count: short.

He sets a charge against the side of a nearby mountain. When the dust
clears, he checks the cracks above the hollow, brings his gear inside
and lays out his bedroll. The stone from the blast is still lying outside.
In the morning, it will go toward his first delivery.

The surveyor's name, what was missing from the second count, and where
the delivered stone goes are open story questions. The post, inscription
and mountain camp are proposed opening beats. The current build has the
destruction tools used in the scene. The opening and delivery loop are
story material.

APPENDIX — EXTERNAL SCANNER NOTES
================================
The current build was checked for .cells import. The following describes
an earlier external scanner workflow. scanner_server.py and scanner.html
were outside the source review, so these instructions and capabilities
need verification with those files.

The earlier setup used Flask, OpenCV and NumPy, with optional Segno for
QR pairing. It ran with python scanner_server.py and reported a local
address on port 5055 for a phone on the same Wi-Fi network. Earlier notes
list --port, --export, --no-browser and --terminal-qr. The external
scanner's default export folder was scan_exports/ beside its server.
To use an export in-game, put it in a folder listed under Import a scan.

The earlier interface offered video upload and guided photos from Front,
Right, Back and Left, with optional Top or Whole Object photos. The Model
tab offered viewing, keyword edits, version comparison and an Import
button to export .cells. History kept scans and their versions.

The earlier reconstruction was described as a cutout inflated into a
symmetric shape, with weak results on hollow objects, thin parts and
low-contrast backgrounds. It stored material labels per cube. Per-cube
colour, multi-view reconstruction, local vision-model labelling and
photo-to-scene conversion were proposed extensions.
