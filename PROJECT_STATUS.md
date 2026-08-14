# Project status

## Completed work

- The Connect IQ dev-container infrastructure is preserved in commit `861579d`
  (the available repository snapshot's equivalent of requested commit `74e5028`).
- Ubuntu 22.04 GUI/noVNC dependencies, Monkey C extension installation, and the
  direct Garmin SDK Manager download are automated.
- The repository was checked for SDKs, keys, secrets, PRG files, and IQ packages;
  none are tracked.

## Current architecture

- `source/` contains the Connect IQ watch application and view.
- `scripts/setup-cloud-dev.sh` provisions and launches the browser desktop.
- SDKs, device definitions, keys, logs, and build output remain outside source control.

## Build instructions

1. Open the repository in the dev container.
2. Use SDK Manager to install a Connect IQ 6.x SDK and Forerunner 570 devices.
3. Run `./scripts/generate-key.sh` once.
4. Run `./scripts/build.sh fr57042mm` and `./scripts/build.sh fr57047mm`.

## Test results

- Shell syntax, dev-container JSON, and whitespace checks pass.
- A real Monkey C build has not run because this execution environment has no
  Connect IQ SDK and blocks access to Garmin's download server.

## Known limitations

- Branch publishing and pull-request creation are blocked by outbound GitHub access.
- SDK/compiler/device installation and real device builds remain pending until the
  Garmin download is reachable.
- noVNC is intended for a private forwarded port and listens only on container localhost.

## Next task

Implement and deterministically test the pure wind-angle, VMG, smoothing,
confidence, and recommendation engine while SDK access remains unavailable.
