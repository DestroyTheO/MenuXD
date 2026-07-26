# MenuXD UI Library Documentation

> **Made by CrimmyXD**  
> **Discord: `zr1xscript`**

A practical guide and importable helper package for the MenuXD / Ventura Roblox Luau UI library.

## Files

- `Documentation.md` — setup, functions, callbacks, controls, layouts, dialogs, configs, data components, and troubleshooting.
- `MenuXDHelper.lua` — importable helper module for loading MenuXD and creating Carbon interfaces.
- `CarbonExample.lua` — complete working Carbon example.

## Import the helper

Replace `YOUR_USERNAME/YOUR_REPO` after uploading:

```lua
local MenuXD = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/refs/heads/main/MenuXD-Documentation/MenuXDHelper.lua"
))()

local Library = MenuXD.LoadLibrary()

local Window = MenuXD.CreateCarbonWindow(Library, {
    name = "My Menu",
    subtitle = "Made by CrimmyXD",
    toggleKey = Enum.KeyCode.RightShift
})

local MainTab = MenuXD.CreateTab(Window, "Main", "🏠")
```

## Run the complete example

```lua
loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/refs/heads/main/MenuXD-Documentation/CarbonExample.lua"
))()
```

## Credits

Made by **CrimmyXD**  
Discord: **`zr1xscript`**
