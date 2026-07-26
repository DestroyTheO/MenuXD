# MenuXD UI Library — Complete Beginner Guide

**Made by CrimmyXD**
**Discord: `zr1xscript`**

This guide explains how to:

* Load MenuXD
* Create a Carbon window
* Create tabs and sections
* Write your own functions
* Connect functions to UI controls
* Start and stop features safely
* Use buttons, toggles, sliders, dropdowns, inputs, and displays
* Update controls from your own code
* Organize a complete script properly

---

# 1. Understanding the Script Layout

A well-organized MenuXD script should normally follow this order:

```lua
-- 1. Roblox services

-- 2. Variables and feature state

-- 3. Your own feature functions

-- 4. Load MenuXD

-- 5. Create the window

-- 6. Create tabs

-- 7. Create UI controls

-- 8. Final startup code
```

Your actual feature code should normally be placed inside functions before creating the UI.

The button, toggle, or slider callback should call those functions.

Example:

```lua
local function StartFeature()
    print("Your feature started")
end

local function StopFeature()
    print("Your feature stopped")
end

MainTab:Toggle({
    name = "Feature",

    callback = function(IsEnabled)
        if IsEnabled then
            StartFeature()
        else
            StopFeature()
        end
    end
})
```

---

# 2. Loading MenuXD

Place this near the beginning of your script:

```lua
local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main"
))()
```

A safer loader gives you better error messages:

```lua
local UI_URL =
    "https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main"

local Source = game:HttpGet(UI_URL)
local Compiled, CompileError = loadstring(Source)

if not Compiled then
    error("MenuXD compile error: " .. tostring(CompileError))
end

local Success, Library = pcall(Compiled)

if not Success then
    error("MenuXD runtime error: " .. tostring(Library))
end

if type(Library) ~= "table" then
    error("MenuXD did not return a library table")
end
```

---

# 3. Getting Roblox Services

Place Roblox services at the top of your script.

```lua
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
```

Only include the services your script actually uses.

For example, a simple UI may only need:

```lua
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
```

---

# 4. Creating Variables for Your Features

Variables that control your features should be placed before your functions.

```lua
local FeatureEnabled = false
local FeatureSpeed = 5
local SelectedMode = "Balanced"
local ActionCount = 0
```

These variables store the current settings selected through the UI.

For example:

```lua
local FeatureSpeed = 5
```

A slider can change this variable:

```lua
MainTab:Slider({
    name = "Feature Speed",
    min = 1,
    max = 20,
    default = 5,

    callback = function(Value)
        FeatureSpeed = Value
    end
})
```

Your feature function can then use it:

```lua
local function RunFeatureAction()
    print("Running at speed:", FeatureSpeed)
end
```

---

# 5. Creating Your Own Functions

Your feature code should normally be written inside local functions.

```lua
local function MyFunction()
    print("My code is running")
end
```

Call the function like this:

```lua
MyFunction()
```

## Function with information passed into it

```lua
local function PrintMessage(Message)
    print(Message)
end

PrintMessage("Hello")
```

## Function that returns a result

```lua
local function AddNumbers(A, B)
    return A + B
end

local Result = AddNumbers(10, 20)

print(Result)
```

---

# 6. Where to Put Your Actual Code

Place your actual code inside feature functions.

```lua
local function StartMyFeature()
    -- =========================================
    -- PUT YOUR FEATURE START CODE HERE
    -- =========================================

    print("Feature started")
end

local function StopMyFeature()
    -- =========================================
    -- PUT YOUR FEATURE STOP CODE HERE
    -- =========================================

    print("Feature stopped")
end
```

Then connect those functions to a toggle:

```lua
MainTab:Toggle({
    name = "My Feature",
    default = false,

    callback = function(IsEnabled)
        if IsEnabled then
            StartMyFeature()
        else
            StopMyFeature()
        end
    end
})
```

This is better than placing hundreds of lines directly inside the callback.

---

# 7. Creating the Window

After defining your services, variables, and functions, create the window.

```lua
local Window = Library:CreateWindow({
    name = "My Menu",

    subtitle = {
        "Loading MenuXD...",
        "Creating tabs...",
        "Loading features...",
        "Ready."
    },

    theme = "Carbon",
    toggleKey = Enum.KeyCode.RightShift,

    loadingTime = 1,

    watermark = "Made by CrimmyXD | zr1xscript",
    watermarkStats = true,
    watermarkRuntime = true,

    safeLoad = true,
    controlErrorIsolation = true,

    destroyOnRespawn = false,
    reconnectOnRespawn = false,

    autoLoad = false,
    autoSave = false,

    configProfile = "MyMenu"
})
```

---

# 8. Applying the Full Carbon Theme

Place this immediately after creating the window:

```lua
Window:SetTheme("Carbon", true)
Window:UseThemeAccent(true)
Window:SetThemeDesign("carbon", true)
Window:SetThemeAnimationStyle("void", true)
Window:SetThemeOverlayVisible(true)
Window:ForceThemeSync()
```

Complete setup:

```lua
local Window = Library:CreateWindow({
    name = "My Carbon Menu",
    subtitle = "Made by CrimmyXD",
    theme = "Carbon",
    toggleKey = Enum.KeyCode.RightShift
})

Window:SetTheme("Carbon", true)
Window:UseThemeAccent(true)
Window:SetThemeDesign("carbon", true)
Window:SetThemeAnimationStyle("void", true)
Window:SetThemeOverlayVisible(true)
Window:ForceThemeSync()
```

---

# 9. Creating Tabs

Create tabs after creating the window.

```lua
Window:NavSection("Main")

local HomeTab = Window:CreateTab({
    name = "Home",
    icon = "🏠"
})

local FeaturesTab = Window:CreateTab({
    name = "Features",
    icon = "⚡"
})

Window:NavSection("Configuration")

local SettingsTab = Window:CreateTab({
    name = "Settings",
    icon = "⚙️"
})
```

Controls must be created from a tab:

```lua
FeaturesTab:Toggle({
    name = "Example Toggle"
})
```

---

# 10. Creating Sections

Sections organize controls inside a tab.

```lua
FeaturesTab:Section({
    name = "Main Features",
    subtitle = "Enable and configure features here",
    icon = "⚡"
})
```

Another section:

```lua
FeaturesTab:Section({
    name = "Additional Settings",
    subtitle = "Extra options",
    icon = "⚙️"
})
```

---

# 11. Buttons

Buttons run code one time when clicked.

```lua
FeaturesTab:Button({
    name = "Run Action",
    description = "Runs your custom function",
    icon = "⚡",

    callback = function()
        -- Put one-time button code here
        print("Button clicked")
    end
})
```

A better structure uses a named function:

```lua
local function RunAction()
    -- =========================================
    -- PUT YOUR BUTTON CODE HERE
    -- =========================================

    print("Action executed")
end

FeaturesTab:Button({
    name = "Run Action",
    description = "Runs your custom function",
    icon = "⚡",
    callback = RunAction
})
```

## Protected button code

Use `pcall` if your function could produce an error:

```lua
local function RunAction()
    print("Running action")
end

FeaturesTab:Button({
    name = "Protected Action",

    callback = function()
        local Success, Error = pcall(RunAction)

        if not Success then
            warn("Action failed:", Error)
        end
    end
})
```

## Store the button

```lua
local ActionButton = FeaturesTab:Button({
    name = "Run Action",

    callback = function()
        print("Action ran")
    end
})
```

You can then control it:

```lua
ActionButton:Fire()
ActionButton:SetDisabled(true)
ActionButton:SetDisabled(false)
ActionButton:SetName("New Button Name")
ActionButton:SetDescription("New description")
ActionButton:Hide()
ActionButton:Show()
```

---

# 12. Toggles

Toggles are used for features that turn on and off.

```lua
local FeatureToggle = FeaturesTab:Toggle({
    name = "Enable Feature",
    description = "Turns the feature on or off",

    default = false,
    onText = "ACTIVE",
    offText = "OFF",

    flag = "featureEnabled",

    callback = function(IsEnabled)
        if IsEnabled then
            StartMyFeature()
        else
            StopMyFeature()
        end
    end
})
```

## Getting the toggle state

```lua
local IsEnabled = FeatureToggle:Get()

print(IsEnabled)
```

## Changing the toggle from code

```lua
FeatureToggle:Set(true)
FeatureToggle:Set(false)
```

This changes the state and runs the callback.

## Silent update

```lua
FeatureToggle:Set(true, true)
```

The second `true` changes the toggle without running its callback.

## Toggle methods

```lua
FeatureToggle:Get()

FeatureToggle:Set(true)
FeatureToggle:Set(false)

FeatureToggle:Enable()
FeatureToggle:Disable()

FeatureToggle:Show()
FeatureToggle:Hide()

FeatureToggle:SetName("New Toggle Name")
FeatureToggle:SetDescription("New description")
```

---

# 13. Starting and Stopping a Repeating Feature

Do not place an uncontrolled `while true do` loop inside a toggle callback.

Bad example:

```lua
callback = function(IsEnabled)
    if IsEnabled then
        while true do
            print("Running")
            task.wait()
        end
    end
end
```

This loop cannot stop correctly.

Use a state variable instead:

```lua
local FeatureRunning = false

local function StartFeature()
    if FeatureRunning then
        return
    end

    FeatureRunning = true

    task.spawn(function()
        while FeatureRunning do
            -- =========================================
            -- PUT REPEATING FEATURE CODE HERE
            -- =========================================

            print("Feature loop running")

            task.wait(1)
        end
    end)
end

local function StopFeature()
    FeatureRunning = false
end
```

Connect it to the toggle:

```lua
FeaturesTab:Toggle({
    name = "Repeating Feature",
    default = false,

    callback = function(IsEnabled)
        if IsEnabled then
            StartFeature()
        else
            StopFeature()
        end
    end
})
```

---

# 14. Using a RunService Connection

For code that should update every frame, use a connection and disconnect it when disabled.

```lua
local FeatureConnection

local function StartFrameFeature()
    if FeatureConnection then
        return
    end

    FeatureConnection = RunService.Heartbeat:Connect(function(DeltaTime)
        -- =========================================
        -- PUT FRAME UPDATE CODE HERE
        -- =========================================

        print("Frame update:", DeltaTime)
    end)
end

local function StopFrameFeature()
    if FeatureConnection then
        FeatureConnection:Disconnect()
        FeatureConnection = nil
    end
end
```

Connect it to a toggle:

```lua
FeaturesTab:Toggle({
    name = "Frame Feature",
    default = false,

    callback = function(IsEnabled)
        if IsEnabled then
            StartFrameFeature()
        else
            StopFrameFeature()
        end
    end
})
```

---

# 15. Sliders

Sliders change numeric variables.

```lua
local FeatureSpeed = 10

local SpeedSlider = SettingsTab:Slider({
    name = "Feature Speed",
    description = "Controls how fast the feature runs",

    min = 1,
    max = 100,
    default = 10,

    round = 1,
    suffix = "%",

    flag = "featureSpeed",

    callback = function(Value)
        FeatureSpeed = Value

        print("Feature speed:", FeatureSpeed)
    end
})
```

Your feature uses the variable:

```lua
local function RunAction()
    print("Running with speed:", FeatureSpeed)
end
```

## Decimal slider

```lua
local FeatureDelay = 1

local DelaySlider = SettingsTab:Slider({
    name = "Feature Delay",

    min = 0.1,
    max = 5,
    default = 1,

    round = 0.1,
    suffix = "s",

    callback = function(Value)
        FeatureDelay = Value
    end
})
```

Use the delay inside a loop:

```lua
task.spawn(function()
    while FeatureRunning do
        print("Running feature")

        task.wait(FeatureDelay)
    end
end)
```

## Slider methods

```lua
SpeedSlider:Set(50)

local CurrentSpeed = SpeedSlider:Get()

SpeedSlider:Set(25, true)

SpeedSlider:Enable()
SpeedSlider:Disable()

SpeedSlider:Show()
SpeedSlider:Hide()
```

---

# 16. Dropdowns

Dropdowns allow the user to choose an option.

```lua
local SelectedMode = "Balanced"

local ModeDropdown = SettingsTab:Dropdown({
    name = "Feature Mode",
    description = "Select how the feature behaves",

    items = {
        "Safe",
        "Balanced",
        "Fast"
    },

    default = "Balanced",
    placeholder = "Select a mode...",

    flag = "featureMode",

    callback = function(Value)
        SelectedMode = Value

        print("Selected mode:", SelectedMode)
    end
})
```

Use the selected mode inside your code:

```lua
local function RunModeAction()
    if SelectedMode == "Safe" then
        print("Running safe behavior")
    elseif SelectedMode == "Balanced" then
        print("Running balanced behavior")
    elseif SelectedMode == "Fast" then
        print("Running fast behavior")
    end
end
```

## Dropdown methods

```lua
ModeDropdown:Set("Fast")

local CurrentMode = ModeDropdown:Get()

ModeDropdown:AddOption("Custom")
ModeDropdown:AddOption("New Mode", true)

ModeDropdown:RemoveOption("Custom")

ModeDropdown:SetItems({
    "One",
    "Two",
    "Three"
})

ModeDropdown:Refresh({
    "Alpha",
    "Bravo",
    "Charlie"
})

ModeDropdown:Clear()
ModeDropdown:Close()
```

---

# 17. Search Dropdown

```lua
local SelectedItem

local ItemDropdown = FeaturesTab:SearchDropdown({
    name = "Select Item",
    description = "Search through available items",

    items = {
        "Sword",
        "Shield",
        "Potion",
        "Gem"
    },

    placeholder = "Select an item...",
    searchPlaceholder = "Search items...",

    callback = function(Value)
        SelectedItem = Value

        print("Selected item:", SelectedItem)
    end
})
```

Use it from a button:

```lua
FeaturesTab:Button({
    name = "Use Selected Item",

    callback = function()
        if not SelectedItem then
            warn("No item selected")
            return
        end

        print("Using item:", SelectedItem)
    end
})
```

---

# 18. Multi Dropdown

A multi dropdown allows several values to be selected.

```lua
local SelectedFeatures = {}

local FeatureDropdown = SettingsTab:MultiDropdown({
    name = "Enabled Options",

    items = {
        "Notifications",
        "Sound",
        "Logging",
        "Auto Save"
    },

    default = {
        "Notifications"
    },

    callback = function(Values)
        SelectedFeatures = Values
    end
})
```

Check whether an option is selected:

```lua
local function IsOptionSelected(Name)
    for _, Value in ipairs(SelectedFeatures) do
        if Value == Name then
            return true
        end
    end

    return false
end
```

Use it:

```lua
if IsOptionSelected("Notifications") then
    print("Notifications are enabled")
end
```

---

# 19. Text Inputs

```lua
local EnteredText = ""

local TextInput = SettingsTab:TextInput({
    name = "Custom Text",
    description = "Enter your own text",

    placeholder = "Type here...",
    default = "",

    flag = "customText",

    callback = function(Text)
        EnteredText = Text
    end
})
```

Use the entered text:

```lua
FeaturesTab:Button({
    name = "Print Custom Text",

    callback = function()
        print(EnteredText)
    end
})
```

Methods:

```lua
TextInput:Set("Hello")
TextInput:Set("", true)

local CurrentText = TextInput:Get()
```

---

# 20. Number Input

```lua
local Quantity = 1

local QuantityInput = SettingsTab:NumberInput({
    name = "Quantity",

    default = 1,
    min = 1,
    max = 100,
    step = 1,

    suffix = " items",

    callback = function(Value)
        Quantity = Value
    end
})
```

Use it:

```lua
FeaturesTab:Button({
    name = "Process Quantity",

    callback = function()
        print("Processing", Quantity, "items")
    end
})
```

Methods:

```lua
QuantityInput:Set(10)
QuantityInput:Add(5)
QuantityInput:Subtract(2)

print(QuantityInput:Get())
```

---

# 21. Counter

```lua
local Counter = SettingsTab:Counter({
    name = "Action Count",

    default = 1,
    min = 0,
    max = 50,
    step = 1,

    callback = function(Value)
        print("Count:", Value)
    end
})
```

Methods:

```lua
Counter:Set(10)
Counter:Add(5)
Counter:Subtract(2)

Counter:Increment()
Counter:Decrement()

print(Counter:Get())
```

---

# 22. Stepper

```lua
local Multiplier = 1

local MultiplierStepper = SettingsTab:Stepper({
    name = "Multiplier",

    min = 1,
    max = 20,
    step = 1,
    default = 1,

    suffix = "x",

    callback = function(Value)
        Multiplier = Value
    end
})
```

Use it:

```lua
local function CalculateValue(BaseValue)
    return BaseValue * Multiplier
end

print(CalculateValue(100))
```

---

# 23. Segmented Control

```lua
local SelectedQuality = "Medium"

local QualityControl = SettingsTab:Segmented({
    name = "Quality",

    items = {
        "Low",
        "Medium",
        "High"
    },

    default = "Medium",

    callback = function(Value)
        SelectedQuality = Value
    end
})
```

Use it:

```lua
local function ApplyQuality()
    if SelectedQuality == "Low" then
        print("Applying low quality")
    elseif SelectedQuality == "Medium" then
        print("Applying medium quality")
    elseif SelectedQuality == "High" then
        print("Applying high quality")
    end
end
```

---

# 24. Keybinds

```lua
local SelectedKey = Enum.KeyCode.E

local Keybind = SettingsTab:Keybind({
    name = "Action Key",
    default = Enum.KeyCode.E,

    callback = function(Key)
        SelectedKey = Key
    end
})
```

To make the selected key run code:

```lua
UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then
        return
    end

    if Input.KeyCode == SelectedKey then
        print("Selected action key pressed")
    end
end)
```

---

# 25. Color Picker

```lua
local SelectedColor = Color3.fromRGB(150, 155, 165)

local ColorPicker = SettingsTab:ColorPicker({
    name = "Feature Color",
    default = SelectedColor,

    callback = function(Color)
        SelectedColor = Color
    end
})
```

Use the selected color:

```lua
local function ApplyColor(Object)
    if Object and Object:IsA("BasePart") then
        Object.Color = SelectedColor
    end
end
```

---

# 26. Status Displays

Status displays show the user what your feature is doing.

```lua
local StatusCard = HomeTab:StatusCard({
    title = "Feature Status",
    status = "Stopped",
    value = "0 actions",
    kind = "idle"
})
```

Update it when a feature starts:

```lua
local function StartFeature()
    FeatureRunning = true

    StatusCard:SetStatus("Running", "success")
end
```

Update it when stopped:

```lua
local function StopFeature()
    FeatureRunning = false

    StatusCard:SetStatus("Stopped", "idle")
end
```

Update the value:

```lua
ActionCount += 1

StatusCard:SetValue(
    tostring(ActionCount) .. " actions"
)
```

Common status kinds:

```lua
"idle"
"info"
"running"
"success"
"warning"
"error"
```

---

# 27. Number Displays

```lua
local ActionDisplay = HomeTab:NumberDisplay({
    name = "Total Actions",
    value = 0,
    decimals = 0,
    icon = "📊"
})
```

Update it:

```lua
ActionCount += 1

ActionDisplay:Set(ActionCount)
```

Other methods:

```lua
ActionDisplay:Add(1)
ActionDisplay:Subtract(1)

print(ActionDisplay:Get())
```

Example connecting a slider to a display:

```lua
local SpeedDisplay

local SpeedSlider = SettingsTab:Slider({
    name = "Speed",
    min = 1,
    max = 100,
    default = 25,

    callback = function(Value)
        if SpeedDisplay then
            SpeedDisplay:Set(Value)
        end
    end
})

SpeedDisplay = SettingsTab:NumberDisplay({
    name = "Current Speed",
    value = SpeedSlider:Get()
})
```

---

# 28. Progress Bars

```lua
local Progress = HomeTab:ProgressBar({
    name = "Feature Progress",
    default = 0,
    suffix = "%"
})
```

Update it:

```lua
Progress:Set(25)
Progress:Set(50)
Progress:Set(100)
```

---

# 29. Notifications

Create a helper function:

```lua
local function Notify(Title, Message, Kind, Duration)
    local Method = Window.Notify or Window.notify

    if type(Method) ~= "function" then
        warn("Notification method unavailable")
        return
    end

    local Success = pcall(
        Method,
        Window,
        tostring(Title),
        tostring(Message),
        tonumber(Duration) or 3,
        tostring(Kind or "info")
    )

    if not Success then
        pcall(
            Method,
            tostring(Title),
            tostring(Message),
            tonumber(Duration) or 3,
            tostring(Kind or "info")
        )
    end
end
```

Use it:

```lua
Notify(
    "Feature Enabled",
    "The feature is now running.",
    "success",
    3
)
```

Common notification kinds:

```lua
"info"
"success"
"warning"
"error"
```

---

# 30. Groupboxes

Groupboxes hold related controls.

```lua
local FeatureGroup = FeaturesTab:Groupbox({
    name = "Feature Settings",
    description = "Configure the feature",
    icon = "⚡"
})
```

Add controls inside it:

```lua
FeatureGroup:Toggle({
    name = "Enabled",
    default = false
})

FeatureGroup:Slider({
    name = "Speed",
    min = 1,
    max = 100,
    default = 25
})

FeatureGroup:Button({
    name = "Test",

    callback = function()
        print("Testing feature")
    end
})
```

The same controls that work on a tab normally work inside a Groupbox.

---

# 31. Collapsible Sections

```lua
local AdvancedSection = SettingsTab:CollapsibleSection({
    name = "Advanced Settings",
    description = "Click to open or close",
    icon = "⚙️",
    open = false
})
```

Add controls inside it:

```lua
AdvancedSection:Toggle({
    name = "Debug Mode",
    default = false
})

AdvancedSection:Slider({
    name = "Advanced Value",
    min = 0,
    max = 100,
    default = 50
})
```

Control it from code:

```lua
AdvancedSection:SetOpen(true)
AdvancedSection:SetOpen(false)
AdvancedSection:Toggle()

print(AdvancedSection:IsOpen())
```

---

# 32. Columns

```lua
local Columns = HomeTab:Columns({
    columns = 2,
    gap = 8
})

local LeftColumn = Columns:Column(1)
local RightColumn = Columns:Column(2)
```

Add controls:

```lua
LeftColumn:MiniStat({
    title = "Left Value",
    value = "100"
})

RightColumn:MiniStat({
    title = "Right Value",
    value = "200"
})
```

---

# 33. Reusable Feature Toggle Builder

This function lets you create many toggles without rewriting the same code.

```lua
local function CreateFeatureToggle(Parent, Config)
    return Parent:Toggle({
        name = Config.Name or "Feature",
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

            if type(Config.Callback) == "function" then
                Config.Callback(IsEnabled)
            end
        end
    })
end
```

Use it:

```lua
local ExampleToggle = CreateFeatureToggle(
    FeaturesTab,
    {
        Name = "Example Feature",
        Description = "Reusable toggle example",
        Default = false,
        Flag = "exampleFeature",

        Start = function()
            -- PUT START CODE HERE
            print("Example feature started")
        end,

        Stop = function()
            -- PUT STOP CODE HERE
            print("Example feature stopped")
        end
    }
)
```

---

# 34. Reusable Button Builder

```lua
local function CreateActionButton(Parent, Config)
    return Parent:Button({
        name = Config.Name or "Action",
        description = Config.Description or "",
        icon = Config.Icon or "",

        callback = function()
            if type(Config.Callback) ~= "function" then
                return
            end

            local Success, Error = pcall(Config.Callback)

            if not Success then
                warn(
                    tostring(Config.Name or "Action")
                        .. " failed:",
                    Error
                )
            end
        end
    })
end
```

Use it:

```lua
CreateActionButton(FeaturesTab, {
    Name = "Refresh Data",
    Description = "Refreshes the current data",
    Icon = "🔄",

    Callback = function()
        -- PUT BUTTON CODE HERE
        print("Refreshing data")
    end
})
```

---

# 35. Reusable Slider and Display Builder

```lua
local function CreateNumberSetting(Parent, Config)
    local Display

    local Slider = Parent:Slider({
        name = Config.Name or "Value",
        description = Config.Description or "",

        min = Config.Min or 0,
        max = Config.Max or 100,
        default = Config.Default or 0,

        round = Config.Step or 1,
        prefix = Config.Prefix or "",
        suffix = Config.Suffix or "",

        flag = Config.Flag,

        callback = function(Value)
            if Display then
                Display:Set(Value)
            end

            if type(Config.Callback) == "function" then
                Config.Callback(Value)
            end
        end
    })

    Display = Parent:NumberDisplay({
        name = (Config.Name or "Value") .. " Display",

        value = Slider:Get(),

        prefix = Config.Prefix or "",
        suffix = Config.Suffix or "",

        decimals = Config.Decimals or 0
    })

    return {
        Slider = Slider,
        Display = Display
    }
end
```

Use it:

```lua
local SpeedSetting = CreateNumberSetting(
    SettingsTab,
    {
        Name = "Speed",
        Description = "Controls the speed",

        Min = 1,
        Max = 100,
        Default = 25,
        Step = 1,

        Suffix = "%",
        Decimals = 0,

        Flag = "featureSpeed",

        Callback = function(Value)
            FeatureSpeed = Value
        end
    }
)
```

Access its controls:

```lua
SpeedSetting.Slider:Set(50)
SpeedSetting.Display:Set(50)
```

---

# 36. Complete Script Template

Use this as the base for a new project.

```lua
--==================================================
-- SERVICES
--==================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

--==================================================
-- FEATURE VARIABLES
--==================================================

local FeatureRunning = false
local FeatureSpeed = 10
local FeatureDelay = 1
local SelectedMode = "Balanced"
local ActionCount = 0

local FeatureConnection

-- These UI controls are assigned after the UI is created.
local StatusCard
local ActionDisplay
local FeatureToggle

--==================================================
-- FEATURE FUNCTIONS
--==================================================

local function UpdateStatus(Text, Kind)
    if StatusCard then
        StatusCard:SetStatus(
            Text,
            Kind or "info"
        )
    end
end

local function UpdateActionCount()
    ActionCount += 1

    if ActionDisplay then
        ActionDisplay:Set(ActionCount)
    end

    if StatusCard then
        StatusCard:SetValue(
            tostring(ActionCount) .. " actions"
        )
    end
end

local function RunOneAction()
    -- =============================================
    -- PUT YOUR ONE-TIME ACTION CODE HERE
    -- =============================================

    print(
        "Running action",
        "Speed:",
        FeatureSpeed,
        "Mode:",
        SelectedMode
    )

    UpdateActionCount()
end

local function StartFeature()
    if FeatureRunning then
        return
    end

    FeatureRunning = true

    UpdateStatus("Running", "success")

    task.spawn(function()
        while FeatureRunning do
            -- =========================================
            -- PUT YOUR REPEATING FEATURE CODE HERE
            -- =========================================

            RunOneAction()

            task.wait(FeatureDelay)
        end
    end)
end

local function StopFeature()
    FeatureRunning = false

    if FeatureConnection then
        FeatureConnection:Disconnect()
        FeatureConnection = nil
    end

    UpdateStatus("Stopped", "idle")
end

local function ResetEverything()
    StopFeature()

    FeatureSpeed = 10
    FeatureDelay = 1
    SelectedMode = "Balanced"
    ActionCount = 0

    if FeatureToggle then
        FeatureToggle:Set(false, true)
    end

    if ActionDisplay then
        ActionDisplay:Set(0)
    end

    if StatusCard then
        StatusCard:SetStatus(
            "Stopped",
            "idle"
        )

        StatusCard:SetValue("0 actions")
    end
end

--==================================================
-- LOAD MENUXD
--==================================================

local Library = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main"
))()

--==================================================
-- CREATE WINDOW
--==================================================

local Window = Library:CreateWindow({
    name = "My Menu",

    subtitle =
        "Made by CrimmyXD | Discord: zr1xscript",

    theme = "Carbon",
    toggleKey = Enum.KeyCode.RightShift,

    loadingTime = 1,

    watermark =
        "CrimmyXD | zr1xscript",

    watermarkStats = true,
    watermarkRuntime = true,

    safeLoad = true,
    controlErrorIsolation = true,

    destroyOnRespawn = false,
    reconnectOnRespawn = false,

    autoLoad = false,
    autoSave = false,

    configProfile = "MyMenu"
})

Window:SetTheme("Carbon", true)
Window:UseThemeAccent(true)
Window:SetThemeDesign("carbon", true)
Window:SetThemeAnimationStyle("void", true)
Window:SetThemeOverlayVisible(true)
Window:ForceThemeSync()

--==================================================
-- CREATE TABS
--==================================================

Window:NavSection("Main")

local HomeTab = Window:CreateTab({
    name = "Home",
    icon = "🏠"
})

local FeaturesTab = Window:CreateTab({
    name = "Features",
    icon = "⚡"
})

Window:NavSection("Configuration")

local SettingsTab = Window:CreateTab({
    name = "Settings",
    icon = "⚙️"
})

--==================================================
-- HOME TAB
--==================================================

HomeTab:Section({
    name = "Dashboard",
    subtitle = "Current feature information",
    icon = "📊"
})

StatusCard = HomeTab:StatusCard({
    title = "Feature Status",
    status = "Stopped",
    value = "0 actions",
    kind = "idle"
})

ActionDisplay = HomeTab:NumberDisplay({
    name = "Total Actions",
    value = 0,
    decimals = 0,
    icon = "⚡"
})

HomeTab:Paragraph({
    title = "Information",
    text = "Use the Features tab to enable the feature. Use the Settings tab to change its speed, delay, and mode."
})

--==================================================
-- FEATURES TAB
--==================================================

FeaturesTab:Section({
    name = "Main Feature",
    subtitle = "Enable or manually run the feature",
    icon = "⚡"
})

FeatureToggle = FeaturesTab:Toggle({
    name = "Enable Feature",
    description = "Starts or stops the repeating feature",

    default = false,

    flag = "featureEnabled",

    callback = function(IsEnabled)
        if IsEnabled then
            StartFeature()
        else
            StopFeature()
        end
    end
})

FeaturesTab:Button({
    name = "Run One Action",
    description = "Runs one action without enabling the loop",
    icon = "▶️",

    callback = function()
        RunOneAction()
    end
})

FeaturesTab:Button({
    name = "Reset Everything",
    description = "Stops the feature and resets all values",
    icon = "🔄",

    callback = function()
        ResetEverything()
    end
})

--==================================================
-- SETTINGS TAB
--==================================================

SettingsTab:Section({
    name = "Feature Settings",
    subtitle = "Change how the feature behaves",
    icon = "⚙️"
})

local SpeedSlider = SettingsTab:Slider({
    name = "Feature Speed",

    min = 1,
    max = 100,
    default = 10,

    round = 1,
    suffix = "%",

    flag = "featureSpeed",

    callback = function(Value)
        FeatureSpeed = Value
    end
})

local DelaySlider = SettingsTab:Slider({
    name = "Feature Delay",

    min = 0.1,
    max = 5,
    default = 1,

    round = 0.1,
    suffix = "s",

    flag = "featureDelay",

    callback = function(Value)
        FeatureDelay = Value
    end
})

local ModeDropdown = SettingsTab:Dropdown({
    name = "Feature Mode",

    items = {
        "Safe",
        "Balanced",
        "Fast"
    },

    default = "Balanced",

    flag = "featureMode",

    callback = function(Value)
        SelectedMode = Value
    end
})

SettingsTab:Button({
    name = "Print Current Settings",

    callback = function()
        print("Speed:", FeatureSpeed)
        print("Delay:", FeatureDelay)
        print("Mode:", SelectedMode)
    end
})

--==================================================
-- FINISHED
--==================================================

Window:ForceThemeSync()

print("MenuXD script loaded")
print("Made by CrimmyXD")
print("Discord: zr1xscript")
```

---

# 37. Important Rules

## Rule 1: Put feature code inside functions

Good:

```lua
local function StartFeature()
    print("Feature started")
end
```

Then:

```lua
callback = function(IsEnabled)
    if IsEnabled then
        StartFeature()
    end
end
```

Avoid placing hundreds of feature lines directly inside the callback.

## Rule 2: Save controls you need later

Good:

```lua
local FeatureToggle = MainTab:Toggle({
    name = "Feature"
})
```

You can then use:

```lua
FeatureToggle:Set(true)
FeatureToggle:Get()
FeatureToggle:Disable()
```

If you do not save it:

```lua
MainTab:Toggle({
    name = "Feature"
})
```

You cannot easily update that toggle later.

## Rule 3: Stop loops and connections

Always include a way to stop repeating code.

```lua
local Running = false

while Running do
    task.wait()
end
```

Disconnect event connections:

```lua
if Connection then
    Connection:Disconnect()
    Connection = nil
end
```

## Rule 4: Use silent updates during resets

```lua
FeatureToggle:Set(false, true)
```

This changes the toggle without calling the callback again.

## Rule 5: Do not reuse configuration flags

Bad:

```lua
flag = "setting"
```

on multiple controls.

Good:

```lua
flag = "featureEnabled"
flag = "featureSpeed"
flag = "featureMode"
```

Each saved control should have its own unique flag.

## Rule 6: Create the UI after creating your functions

Recommended order:

```lua
local function StartFeature()
end

local function StopFeature()
end

local Window = Library:CreateWindow({...})
local Tab = Window:CreateTab({...})

Tab:Toggle({
    callback = function(Value)
        if Value then
            StartFeature()
        else
            StopFeature()
        end
    end
})
```

This keeps the script clean and prevents missing-function errors.
