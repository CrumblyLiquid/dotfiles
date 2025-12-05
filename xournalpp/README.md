# Xournal++

[Xournal++](https://xournalpp.github.io/) is a very handy
program for handwritten notes with PDF annotation and
many more features.

## Packages

- `xournalpp`

## Configuration

Main configuration is stored in `settings.xml`,
but the configuration format isn't very readable,
and it's recommended to edit it through the application
rather than manually.

Other files:
- `toolbar.ini` - definition for a custom toolbar setup
(see [Toolbar Customization](https://xournalpp.github.io/guide/config/toolbar-colors/#toolbar-palette-files))
- `palette.gpl` - color palette definition
(see [Toolbar Palette](https://xournalpp.github.io/guide/config/toolbar-colors/#toolbar-palette-files))

Every file mentioned here is stored
under `$XDG_CONFIG_HOME/xournalpp` (so probably `~/.config/xournalpp`).
For other platforms and more,
see [documentation](https://xournalpp.github.io/guide/file-locations/).

### Useful options

Settings are under `Edit` -> `Preferences`

#### Input stabilization (Input System)

My settings:
- Averaging method: Arithmetic mean
- Preprocessor: Deadzone
- Buffersize: 5
- Deadzone radius: 1.30
- Finalize the stroke: Enabled
- Cusp detection: Enabled

#### Pressure Sensitivity (Pressure Sensitivity)

Pressure sensitivity is very useful to dial in
the thickness based on the pressure used.

My settings (Wacom One S):
- Minimum Pressure: 0.20
- Pressure Multiplier: 1.60

### Plugins

#### Xim

My [own plugin](https://github.com/CrumblyLiquid/xim)
for easy modal editing.
I think it makes taking notes and editing them
significantly more pleasant!
