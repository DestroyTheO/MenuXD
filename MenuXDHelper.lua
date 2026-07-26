--[[
    MenuXD Helper
    Made by CrimmyXD
    Discord: zr1xscript
]]

local MenuXD = {}

MenuXD.Author = "CrimmyXD"
MenuXD.Discord = "zr1xscript"
MenuXD.LibraryURL =
    "https://raw.githubusercontent.com/DestroyTheO/MenuXD/refs/heads/main/Main"

function MenuXD.LoadLibrary()
    local Source = game:HttpGet(MenuXD.LibraryURL)
    local Compiled, CompileError = loadstring(Source)

    if not Compiled then
        error("MenuXD compile failed: " .. tostring(CompileError))
    end

    local Success, Library = pcall(Compiled)

    if not Success then
        error("MenuXD runtime failed: " .. tostring(Library))
    end

    if type(Library) ~= "table" then
        error("MenuXD did not return a library table")
    end

    return Library
end

function MenuXD.CreateCarbonWindow(Library, Options)
    Options = Options or {}

    local Window = Library:CreateWindow({
        name = Options.name or "MenuXD",
        subtitle = Options.subtitle
            or "Made by CrimmyXD | Discord: zr1xscript",
        theme = "Carbon",
        toggleKey = Options.toggleKey or Enum.KeyCode.RightShift,
        loadingTime = Options.loadingTime or 1,
        watermark = Options.watermark
            or "CrimmyXD | Discord: zr1xscript",
        watermarkStats = Options.watermarkStats ~= false,
        watermarkRuntime = Options.watermarkRuntime ~= false,
        safeLoad = Options.safeLoad ~= false,
        controlErrorIsolation = Options.controlErrorIsolation ~= false,
        destroyOnRespawn = Options.destroyOnRespawn == true,
        reconnectOnRespawn = Options.reconnectOnRespawn == true,
        autoLoad = Options.autoLoad == true,
        autoSave = Options.autoSave == true,
        configProfile = Options.configProfile or "CrimmyXDMenuXD"
    })

    if type(Window.SetTheme) == "function" then
        Window:SetTheme("Carbon", true)
    end

    if type(Window.UseThemeAccent) == "function" then
        Window:UseThemeAccent(true)
    end

    if type(Window.SetThemeDesign) == "function" then
        Window:SetThemeDesign("carbon", true)
    end

    if type(Window.SetThemeAnimationStyle) == "function" then
        Window:SetThemeAnimationStyle("void", true)
    end

    if type(Window.SetThemeOverlayVisible) == "function" then
        Window:SetThemeOverlayVisible(true)
    end

    if type(Window.ForceThemeSync) == "function" then
        Window:ForceThemeSync()
    end

    return Window
end

function MenuXD.CreateTab(Window, Name, Icon)
    return Window:CreateTab({
        name = Name or "Tab",
        icon = Icon or "🏠"
    })
end

function MenuXD.CreateFeatureToggle(Parent, Config)
    Config = Config or {}

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

function MenuXD.CreateActionButton(Parent, Config)
    Config = Config or {}

    return Parent:Button({
        name = Config.Name or "Action",
        description = Config.Description or "",
        icon = Config.Icon or "",
        badge = Config.Badge,

        callback = function()
            if type(Config.Callback) ~= "function" then
                return
            end

            local Success, Error = pcall(Config.Callback)

            if not Success then
                warn((Config.Name or "Action") .. " failed:", Error)
            end
        end
    })
end

function MenuXD.CreateNumberSetting(Parent, Config)
    Config = Config or {}

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

function MenuXD.Notify(Window, Title, Text, Kind, Duration)
    local Method = Window.Notify or Window.notify

    if type(Method) == "function" then
        local Success = pcall(
            Method,
            Window,
            tostring(Title or "MenuXD"),
            tostring(Text or ""),
            tonumber(Duration) or 3,
            tostring(Kind or "info")
        )

        if not Success then
            pcall(
                Method,
                tostring(Title or "MenuXD"),
                tostring(Text or ""),
                tonumber(Duration) or 3,
                tostring(Kind or "info")
            )
        end
    end
end

return MenuXD
