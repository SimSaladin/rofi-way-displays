# `rofi-way-displays`

Rofi-powered menu for executing `way-displays` actions and inspecting the
current configuration.

## Run directly

```bash
rofi -show way-displays:path/to/rofi-way-displays

# …or directly:
./rofi-way-displays
```

## Local install

 ```bash
 ln -sfr ./rofi-way-displays ~/.config/rofi/scripts/way-displays

 # Then rofi will find the script with merely a:
 rofi -show way-displays
 ```
