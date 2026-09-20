# CS 220 Auto Submitter

A Windows batch script that handles the submission and completion of labs for CS220: it creates the lab's `README.md` from the course template, optionally commits and pushes to GitHub, zips the solution directory remotely, and copies the finished `.zip` back to your computer.

## Installation

Download `submit.bat` onto your computer

Open `submit.bat` in a text editor and edit the two variables at the top:

**IF NECESSARY** also edit the two at the bottom 

```bat
set OUT_DIR=C:\Users\user\Downloads\labs
set SSH_USR=user
set IN_DIR=~/i220/submit/%~1-sol
set ZIP_DIR=~/cs220/bin/do-zip.sh
```

| Variable | What to set it to |
| --- | --- |
| `OUT_DIR` | Local folder where the finished zip should land. Created automatically if missing. |
| `SSH_USR` | Your SSH username. |
| `IN_DIR` | Remote path to your lab directories. Leave `%~1` in place of the lab name. |
| `ZIP_DIR` | Remote path to the zipping script the professor provided. |

## Usage

Connect to the BU VPN

**GENERALLY JUST USE IT LIKE THIS EXAMPLE**
```bat
submit.bat lab9 -g        :: submit and commit to GitHub
```
**^^^^^^^^^^^^^^**

```bat
submit.bat [lab name] [-g] [-nz]
```

The lab name is given **without** the `-sol` suffix — the script appends it. Flags are optional and can go in either order.

| Argument | Effect |
| --- | --- |
| `lab name` | The lab to submit (for example `lab2`, `lab4`, `lab9`). |
| `-g` | Commit the lab as `completed <lab name>` and push to GitHub. |
| `-nz` | Skip the re-zipping step, for just transferring an already-zipped lab. |

### Examples

```bat
submit.bat lab9 -g        :: submit and commit to GitHub


submit.bat lab2           :: submit normally
submit.bat lab4 -nz       :: copy down without re-zipping
submit.bat lab9 -g -nz    :: commit, skip re-zipping
```

## Caveats

- **`-nz` is not absolute.** The lab is still zipped if no zip exists yet, or if the `README.md` had to be created on that run — otherwise there'd be nothing to copy down.
- **The README is only created once.** If `README.md` already exists it's left alone, header included.
- **Git must already be set up** in the lab directory for `-g` to work. A failed push shows up as the generic `Remote zip step failed.` message.
