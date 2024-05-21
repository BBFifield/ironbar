Displays currently playing song from your music player.
This module supports both MPRIS players and MPD servers.
Clicking on the widget opens a popout displaying info about the current song, album art
and playback controls.

in MPRIS mode, the widget will listen to all players and automatically detect/display the active one.

![Screenshot showing MPD widget with track playing with popout open](https://f.jstanger.dev/github/ironbar/music.png)

## Configuration

> Type: `music`

<% modules::music::config::MusicModule %>

### Icons

<% modules::music::config::Icons { depth = 2 } %>

<details>
<summary>JSON</summary>

```json
{
  "start": [
    {
      "type": "music",
      "player_type": "mpd",
      "format": "{title} / {artist}",
      "truncate": "end",
      "icons": {
        "play": "",
        "pause": ""
      },
      "music_dir": "/home/jake/Music"
    }
  ]
}
```

</details>

<details>
<summary>TOML</summary>

```toml
[[start]]
type = "music"
player_type = "mpd"
format = "{title} / {artist}"
music_dir = "/home/jake/Music"
truncate = "end"

[start.icons]
play = ""
pause = ""
```

</details>

<details>
<summary>YAML</summary>

```yaml
start:
  - type: "music"
    player_type: "mpd"
    format: "{title} / {artist}"
    truncate: "end"
    icons:
      play: ""
      pause: ""
    music_dir: "/home/jake/Music"
```

</details>

<details>
<summary>Corn</summary>

```corn
{
  start = [
    {
      type = "music"
      player_type = "mpd"
      format = "{title} / {artist}"
      truncate = "end"
      icons.play = ""
      icons.pause = ""
      music_dir = "/home/jake/Music"
    }
  ]
}
```

</details>

### Formatting Tokens

The following tokens can be used in the `format` config option,
and will be replaced with values from the currently playing track:

| Token        | Description                          |
|--------------|--------------------------------------|
| `{title}`    | Title                                |
| `{album}`    | Album name                           |
| `{artist}`   | Artist name                          |
| `{date}`     | Release date                         |
| `{track}`    | Track number                         |
| `{disc}`     | Disc number                          |
| `{genre}`    | Genre                                |

## Styling

| Selector                                    | Description                                           |
|---------------------------------------------|-------------------------------------------------------|
| `.music`                                    | Tray widget button                                    |
| `.music .contents`                          | Tray widget button contents box                       |
| `.music .contents .icon`                    | Tray widget button icon (any type)                    |
| `.music .contents .text-icon`               | Tray widget button icon (textual only)                |
| `.music .contents .image`                   | Tray widget button icon (image only)                  |
| `.popup-music`                              | Popup box                                             |
| `.popup-music .album-art`                   | Album art image inside popup box                      |
| `.popup-music .title`                       | Track title container inside popup box                |
| `.popup-music .title .icon-box`             | Track title icon container inside popup box           |
| `.popup-music .title .icon-box .icon`       | Track title icon inside its container (any type)      |
| `.popup-music .title .icon-box .text-icon`  | Track title icon inside its container (textual only)  |
| `.popup-music .title .icon-box .image`      | Track title icon inside its container (image only)    |
| `.popup-music .title .label`                | Track title label inside popup box                    |
| `.popup-music .album`                       | Track album container inside popup box                |
| `.popup-music .album .icon-box`             | Track album icon container inside popup box           |
| `.popup-music .album .icon-box .icon`       | Track album icon inside its container (any type)      |
| `.popup-music .album .icon-box .text-icon`  | Track album icon inside its container (textual only)  |
| `.popup-music .album .icon-box .image`      | Track album icon inside its container (image only)    |
| `.popup-music .album .label`                | Track album label inside popup box                    |
| `.popup-music .artist`                      | Track artist container inside popup box               |
| `.popup-music .artist .icon-box`            | Track artist icon container inside popup box          |
| `.popup-music .artist .icon-box .icon`      | Track artist icon inside its container (any type)     |
| `.popup-music .artist .icon-box .text-icon` | Track artist icon inside its container (textual only) |
| `.popup-music .artist .icon-box .image`     | Track artist icon inside its container (image only)   |
| `.popup-music .artist .label`               | Track artist label inside popup box                   |
| `.popup-music .controls`                    | Controls container inside popup box                   |
| `.popup-music .controls .btn-prev`          | Previous button inside popup box                      |
| `.popup-music .controls .btn-play`          | Play button inside popup box                          |
| `.popup-music .controls .btn-pause`         | Pause button inside popup box                         |
| `.popup-music .controls .btn-next`          | Next button inside popup box                          |
| `.popup-music .volume`                      | Volume container inside popup box                     |
| `.popup-music .volume .slider`              | Slider inside volume container                        |
| `.popup-music .volume .icon`                | Icon inside volume container                          |
| `.popup-music .progress`                    | Progress (seek) bar container                         |
| `.popup-music .progress .slider`            | Slider inside progress container                      |
| `.popup-music .progress .label`             | Duration label inside progress container              |

For more information on styling, please see the [styling guide](styling-guide).