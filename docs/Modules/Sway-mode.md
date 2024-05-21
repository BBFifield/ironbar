Displays the current sway mode in a label. If the current sway mode is
"default", nothing is displayed.

> [!NOTE]
> This module only works under the [Sway](https://swaywm.org/) compositor.

## Configuration

> Type: `sway-mode`

<% modules::sway::mode::SwayModeModule %>

<details>
<summary>JSON</summary>

```json
{
  "end": [
    {
      "type": "sway-mode",
      "truncate": "start"
    }
  ]
}
```

</details>

<details>
<summary>TOML</summary>

```toml
[[end]]
type = "sway-mode"
truncate = "start"
```

</details>

<details>
<summary>YAML</summary>

```yaml
end:
  - type: "sway-mode"
    truncate: "start"
```

</details>

<details>
<summary>Corn</summary>

```corn
{
  end = [
    {
      type = "sway-mode"
      truncate = "start"
    }
  ]
}
```

</details>

## Styling

| Selector     | Description            |
| ------------ | ---------------------- |
| `.sway_mode` | Sway mode label widget |

For more information on styling, please see the [styling guide](styling-guide).
