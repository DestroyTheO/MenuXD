--[[
    MenuXD Carbon Example
    Made by CrimmyXD
    Discord: zr1xscript
]]

local HelperURL =
    "https://raw.githubusercontent.com/YOUR_USERNAME/YOUR_REPO/refs/heads/main/MenuXD-Documentation/MenuXDHelper.lua"

local MenuXD = loadstring(game:HttpGet(HelperURL))()
local Library = MenuXD.LoadLibrary()

local Window = MenuXD.CreateCarbonWindow(Library, {
    name = "CrimmyXD MenuXD Example",
    subtitle = "Made by CrimmyXD | Discord: zr1xscript",
    toggleKey = Enum.KeyCode.RightShift,
    watermark = "CrimmyXD | zr1xscript"
})

local MainTab = MenuXD.CreateTab(Window, "Main", "🏠")
local SettingsTab = MenuXD.CreateTab(Window, "Settings", "⚙️")

local Status = MainTab:StatusCard({
    title = "Feature Status",
    status = "Stopped",
    value = "0 actions",
    kind = "idle"
})

local ActionCount = 0
local Delay = 1

local FeatureToggle = MenuXD.CreateFeatureToggle(MainTab, {
    Name = "Example Feature",
    Description = "Demonstrates a reusable feature toggle",
    Flag = "exampleFeature",

    Callback = function(IsEnabled)
        Status:SetStatus(
            IsEnabled and "Running" or "Stopped",
            IsEnabled and "success" or "idle"
        )

        MenuXD.Notify(
            Window,
            "Example Feature",
            IsEnabled and "Feature enabled." or "Feature disabled.",
            IsEnabled and "success" or "warning",
            3
        )
    end
})

MenuXD.CreateActionButton(MainTab, {
    Name = "Run One Action",
    Description = "Only runs while the feature is enabled",
    Icon = "⚡",

    Callback = function()
        if not FeatureToggle:Get() then
            MenuXD.Notify(
                Window,
                "Feature Disabled",
                "Enable the feature first.",
                "warning",
                3
            )
            return
        end

        ActionCount += 1
        Status:SetValue(tostring(ActionCount) .. " actions")
        print("Action ran with delay:", Delay)
    end
})

local DelaySetting = MenuXD.CreateNumberSetting(SettingsTab, {
    Name = "Delay",
    Description = "Example reusable slider and display",
    Min = 0.1,
    Max = 5,
    Default = 1,
    Step = 0.1,
    Suffix = "s",
    Decimals = 1,
    Flag = "actionDelay",

    Callback = function(Value)
        Delay = Value
    end
})

SettingsTab:Button({
    name = "Reset Example",
    callback = function()
        ActionCount = 0
        Status:SetValue("0 actions")
        Status:SetStatus("Stopped", "idle")
        FeatureToggle:Set(false)
        DelaySetting.Slider:Set(1)

        MenuXD.Notify(
            Window,
            "Reset",
            "Example reset.",
            "success",
            3
        )
    end
})
