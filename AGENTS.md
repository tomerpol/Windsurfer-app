# Codex instructions

- This is a Garmin Connect IQ watch app written in Monkey C.
- Supported targets: fr57042mm and fr57047mm only.
- Keep the code minimal and readable.
- Do not commit Garmin SDK files, developer keys, PRG files, or IQ files.
- Before finishing a task, run ./scripts/build.sh fr57047mm when a Garmin SDK is available.
- Preserve compatibility with Connect IQ API 6.0.
- Keep pure coaching logic separate from Garmin APIs and cover it with deterministic tests.
- Build both fr57042mm and fr57047mm after each meaningful phase when the SDK is available.
- Maintain PROJECT_STATUS.md with progress, architecture, build/test results, limitations, and next work.
- Never commit logs, generated binaries, downloaded device definitions, or SDK archives.
- Work in small, reviewable commits and keep the watch UI readable at a glance.
