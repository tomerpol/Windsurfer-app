# Windsurfer Garmin

Minimal Garmin Connect IQ watch app for Forerunner 570 (42mm and 47mm).

## Connect IQ development container

Open this repository in its dev container. It uses Ubuntu 22.04 and automatically
installs the Garmin Monkey C extension, downloads Connect IQ SDK Manager directly
from Garmin, and starts an XFCE desktop available through noVNC.

If automatic startup was interrupted, run:

```bash
./scripts/setup-cloud-dev.sh
```

Then open `http://localhost:6080/vnc.html` (the forwarded **Garmin Simulator**
port). Use SDK Manager in that desktop to install a Connect IQ 6.x SDK and the
Forerunner 570 device files. SDKs and developer keys are stored in your home
directory, never in the repository.

Generate a local developer key and build the 47 mm target with:

```bash
./scripts/generate-key.sh
./scripts/build.sh fr57047mm
```
