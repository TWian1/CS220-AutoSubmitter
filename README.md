# CS 220 Auto Submitter

A Windows batch script that handles the submission and completion of labs for CS220: it creates the lab's `README.md` from the course template, optionally commits and pushes to GitHub, zips the solution directory remotely, and copies the finished `.zip` back to your computer.

## Installation

Download `submit.bat` onto your computer

Open `submit.bat` in a text editor and edit the two variables at the top:

```bat
set OUT_DIR=C:\Users\user\Downloads\labs
set SSH_USR=username
```

| Variable | What to set it to |
| --- | --- |
| `OUT_DIR` | Local folder where the finished zip should land. Created automatically if missing. |
| `SSH_USR` | Your SSH username. |

## Usage

Connect to the BU VPN

**GENERALLY JUST USE IT LIKE THIS EXAMPLE**
```bat
submit lab9        :: submit and commit to GitHub
```
**^^^^^^^^^^^^^^**

```bat
submit [lab name] [-ng] [-nz]
```

The lab name is given **without** the `-sol` suffix — the script appends it. Flags are optional and can go in either order.

| Argument | Effect |
| --- | --- |
| `lab name` | The lab to submit (for example `lab2`, `lab4`, `lab9`). |
| `-ng` | Skip committing the lab as `completed <lab name>` and push to GitHub. |
| `-nz` | Skip the re-zipping step, for just transferring an already-zipped lab. |

### Examples

```bat
submit lab9         :: submit and commit to GitHub


submit lab2 -ng       :: submit without commiting normally
submit lab4 -nz       :: copy down without re-zipping, commits
submit lab9 -ng -nz    :: skips commit, skip re-zipping
```

## Caveats

- **`-nz` is not absolute.** The lab is still zipped if no zip exists yet, or if the `README.md` had to be created on that run — otherwise there'd be nothing to copy down.
- **The README is only created once.** If `README.md` already exists it's left alone, header included.
- **Git must already be set up** in the lab directory for commiting to work. A failed push shows up as the generic `Remote zip step failed.` message.
- Modify these values if they do not point to the correct spots:
```bat
set IN_DIR=~/i220/submit/%~1-sol
set ZIP_DIR=~/cs220/bin/do-zip.sh
```
