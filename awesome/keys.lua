-- Awesome keybindings

-- Importing libraries
local gears = require('gears')
local awful = require('awful')

-- Variables
local keys = {}

metakey = 'Mod4'
tags = 7
keys.tags = tags     --Uncomment this if not using custom tag names
terminal = 'kitty'
editor = 'nvim'
editor_launch = terminal..' -e '..editor

-- Keybindings
keys.globalkeys = gears.table.join(

    -- Awesome
    awful.key({metakey, 'Shift'}, 'r', awesome.restart,
              {description = 'Reload Awesome', group = 'Awesome'}),
    awful.key({metakey}, 'l', function () awesome.util.spawn('exec ~/.config/polybar/defualt/scripts/powermenu.sh') end,
              {description = 'PowerMenu', group = 'Awesome'}),
    awful.key({metakey}, 'Tab', function () awful.layout.inc(1) end,
              {description = 'Toggle Layout', group = 'Awesome'}),

    -- Window management
    awful.key({'Mod1',}, 'Tab', function() awful.client.focus.byidx(1) end,
              {description = 'Switch between windows', group = 'Window Management'}),
    awful.key({metakey}, 'Right', function () awful.tag.incmwfact(0.03) end,
              {description = 'Increase master width factor', group = 'Window Management'}),
    awful.key({metakey}, 'Left', function () awful.tag.incmwfact(-0.03) end,
              {description = 'Decrease master width factor', group = 'Window Management'}),


    -- Applications
    awful.key({metakey}, 'Return', function() awful.util.spawn(terminal) end,
              {description='Terminal', group='Applications'}),
    awful.key({metakey}, 't', function() awful.util.spawn(editor_launch) end,
              {description='Text Editor', group='Applications'}),
    awful.key({metakey}, 'r', function() awful.util.spawn('rofi -show drun') end,
              {description='Application Launcher', group='Applications'}),
    awful.key({metakey}, 'w', function() awful.util.spawn('firefox') end,
              {description='Browser', group='Applications'}),
    awful.key({metakey}, 'e', function() awful.util.spawn('ranger') end,
              {description='File Explorer', group='Applications'}),

    -- Screenshots
    awful.key({metakey}, 'Print', function() awful.util.spawn('flameshot gui') end,
              {description='Take ScreenShot', group='Screenshots'})
)

keys.clientkeys = gears.table.join(
    awful.key({metakey}, 'q', function(c) c:kill() end,
              {description = 'Close', group = 'Window Management'}),
    awful.key({metakey}, 'space', function(c) c.fullscreen = not c.fullscreen; c:raise() end,
              {description = 'Toggle Fullscreen', group = 'Window Management'}),
    awful.key({metakey, 'Shift'}, 'space', function() awful.client.floating.toggle() end,
              {description = 'Toggle Floating', group = 'Window Management'})
)

-- Mouse controls
keys.clientbuttons = gears.table.join(
    awful.button({}, 1, function(c) client.focus = c end),

    -- Meta + left click to move window
    awful.button({metakey}, 1, function() awful.mouse.client.move() end),

    -- Meta + middle click to kill window
     awful.button({metakey}, 2, function(c) c:kill() end),

    -- Meta + right click to resize window
    awful.button({metakey}, 3, function() awful.mouse.client.resize() end)
)

for i = 1, tags do
    keys.globalkeys = gears.table.join(keys.globalkeys,
        -- View tag
        awful.key({metakey}, '#'..i + 9,
                  function ()
                        local tag = awful.screen.focused().tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = 'View tag #'..i, group = 'Tags'}),

        -- Move window to tag
        awful.key({metakey, 'Shift'}, '#'..i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = 'Move focused window to tag #'..i, group = 'Tags'}),

        -- Toggle tag display.
        awful.key({metakey, 'Control'}, '#'..i + 9,
            function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then
                    awful.tag.viewtoggle(tag)
                end
            end,
            {description = 'Toggle tag #' .. i, group = 'Tags'}))
end

-- Set globalkeys
root.keys(keys.globalkeys)

return keys
