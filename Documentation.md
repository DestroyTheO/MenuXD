# Branding

**Made by CrimmyXD**  
**Discord: `zr1xscript`**

# MenuXD UI Library Documentation

**Library version:** `5.99.3.2-fresh-reexecution`  
**Build ID:** `5.99.3.2.20260720.0d114899fe`  
**Source:** `https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main`  
**Theme used:** Carbon

This companion Markdown file contains the quick-reference version of the full DOCX guide.

## Quick start

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main"
))()

local Window = Library:CreateWindow({
    name = "My Menu",
    subtitle = "MenuXD example",
    theme = "Carbon",
    toggleKey = Enum.KeyCode.RightShift
})

local MainTab = Window:CreateTab({
    name = "Main",
    icon = "🏠"
})

MainTab:Button({
    name = "Test Button",
    callback = function()
        print("Button clicked")
    end
})
```

## Complete Carbon setup

```lua
Window:SetTheme("Carbon", true)
Window:UseThemeAccent(true)
Window:SetThemeDesign("carbon", true)
Window:SetThemeAnimationStyle("void", true)
Window:SetThemeOverlayVisible(true)
Window:ForceThemeSync()
```

## General control pattern

```lua
local Control = Tab:Toggle({
    name = "Feature Enabled",
    description = "Example setting",
    default = false,
    flag = "featureEnabled",

    callback = function(Value)
        print(Value)
    end
})
```

## Universal control methods

- `Get()`
- `Set(value, silent?)`
- `Show()` / `Hide()`
- `Enable()` / `Disable()`
- `IsVisible()` / `IsEnabled()`
- `SetName(text)`
- `SetDescription(text)`
- `SetCallback(function)`
- `GetFrame()`
- `Own(item)`
- `Connect(signal, callback)`
- `Destroy()`

## Reusable feature-toggle function

```lua
local function CreateFeatureToggle(Parent, Config)
    return Parent:Toggle({
        name = Config.Name,
        description = Config.Description or "",
        default = Config.Default == true,
        flag = Config.Flag,

        callback = function(IsEnabled)
            if IsEnabled then
                if type(Config.Start) == "function" then
                    Config.Start()
                end
            else
                if type(Config.Stop) == "function" then
                    Config.Stop()
                end
            end
        end
    })
end
```

## Core controls

`Button`, `Toggle`, `Slider`, `Dropdown`, `SearchDropdown`, `MultiDropdown`,
`TextInput`, `NumberInput`, `Counter`, `Stepper`, `Segmented`, `ColorPicker`,
`Keybind`, and `SearchBox`.

## Display controls

`Section`, `Label`, `Paragraph`, `Badge`, `Chip`, `Info`, `Warning`, `Success`,
`Alert`, `ProgressBar`, `NumberDisplay`, `PercentageDisplay`, `GoalProgress`,
`StatusCard`, `MiniStat`, `KeyValue`, `TimerDisplay`, `ControlHint`, `Image`,
`Hyperlink`, and `CodeBlock`.

## Layout helpers

`Groupbox`, `CollapsibleSection`, `Columns`, `ButtonGrid`, `ActionRow`,
`Divider`, `Separator`, and `Spacer`.

## Money and data components

`MoneyDisplay`, `ProfitDisplay`, `TransactionList`, `StatGrid`, `ActivityLog`,
`LogConsole`, `MiniChart`, `SessionTracker`, `DataTable`, `InventoryGrid`,
`Form`, `VirtualList`, and `InstanceInspector`.

## Common fix: silent updates

```lua
Control:Set(Value)       -- Updates and runs callback
Control:Set(Value, true) -- Updates without callback
```

## Common fix: safe creation

```lua
local function SafeControl(Parent, MethodName, Options)
    local Method = Parent[MethodName]

    if type(Method) ~= "function" then
        warn(MethodName .. " is unavailable")
        return nil
    end

    local Success, Control = pcall(Method, Parent, Options)

    if not Success then
        warn(MethodName .. " failed:", Control)
        return nil
    end

    return Control
end
```

See the DOCX for full examples, option tables, dialogs, stores, events,
undo/redo, configurations, component aliases, and troubleshooting.
