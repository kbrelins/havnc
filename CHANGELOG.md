# Changelog

All notable changes to the HAVNC Standalone project will be documented in this file.

## [Unreleased]

## [1.0.0] - 2026-02-28

### Added
- Initial standalone version based on gnyman/havnc.
- Added GitHub Actions workflow to automatically build and push the Docker image to GHCR.
- Added `README.md` with instructions for standalone Docker usage.

### Changed
- Modified supervisor configuration to remove dependency on Home Assistant (`options.json`).
- Updated websockify configuration to operate in **HTTP mode** (removed SSL/HTTPS requirements for easier local access).
- Fixed mouse cursor synchronization for ARM64/OrbStack environments by updating Chromium flags (`--force-device-scale-factor=1`).

### Removed
- Removed Home Assistant specific files (`config.yaml`, `translations/` folder).
- Removed original `CHANGELOG.md` to start a new history for the standalone fork.
