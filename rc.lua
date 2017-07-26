

--require("eminent")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")

local inspect = require("inspect")

require("hints")
require("cheeky")


local APW = require("apw/widget")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

function dump(data)
    naughty.notify({ text = inspect(data) })
end


-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}



-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("~/.config/awesome/theme.lua")
beautiful.init("/home/doc/.config/awesome/themes/doc/theme.lua")

hints.init()


-- This is used later as the default terminal and editor to run.
terminal = "terminator"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.





-- {{{ Wallpaper
for s = 1, screen.count() do
  gears.wallpaper.centered("/home/doc/Desktop/crimsonking.png", s)
end
-- }}}


-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock(" %d.%m.%Y   %H:%M   ", 1)

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}



mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end)
                      --[[,
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end)
]])




  kbdwidget = wibox.widget.textbox()
  kbdwidget:set_text(" En ")


    dbus.add_match("session", "interface='ru.gentoo.kbdd',member='layoutChanged'")
    dbus.connect_signal("ru.gentoo.kbdd", function(...)


        kbdwidget:set_text("--")
        local data = {...}
        local layout = data[2]
        lts = {[0] = "En", [1] = "Ru"}
        kbdwidget:set_text(" "..lts[layout].." ")
        end
    )

    systray = wibox.widget.systray()


--myprogressbar = {}
local mytaglist = require('rc/tags')

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()


    -- left_layout:add(mylauncher)


     --myprogressbar[s] = awful.widget.progressbar()
     --myprogressbar[s]:set_width(16)
     --myprogressbar[s]:set_height(16)
     --myprogressbar[s]:set_vertical(true)
     --myprogressbar[s]:set_background_color('#222222')
     --myprogressbar[s]:set_color('#0000FF')
     --myprogressbar[s]:set_value(0)

    --myprogressbar:set_gradient_colors({ '#AECF96', '#88A175', '#FF5656' })


    --left_layout:add(myprogressbar[s])
    left_layout:add(mytaglist[s])
    --left_layout:add(mypromptbox[s])
    left_layout:add(wibox.widget.textbox("        "))

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(systray) end



    -- {{{ Lang
    right_layout:add(kbdwidget)
    -- }}}


    right_layout:add(APW)
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])


    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 16 })


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    --[[
    local const = wibox.layout.constraint()
    const:set_widget(layout)
    const:set_strategy("exact")
    const:set_height(16)

    local layout2 = wibox.layout.align.horizontal()
    --layout2:set_left(left_layout)
    layout2:set_left(mytasklist[s])


    local l = wibox.layout.fixed.vertical()
    l:add(const)
    l:add(layout2)


    mywibox[s]:set_widget(l)
    ]]
    mywibox[s]:set_widget(layout)


end
-- }}}




-- {{{ Key bindings

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    --awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),

    awful.key({ modkey,           }, "Escape",
      function (c)

        -- Не убивать VBox
        if (c.class == "VBoxSDL") then return end

        c:kill()


      end),

    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),


    --[[
    awful.key({ modkey,           }, "o",
      function (c)
        screen = mouse.screen+1
        if (screen > 2) then screen = 1 end
        if (awful.tag.selected(mouse.screen) and awful.tag.selected(screen)) then
          awful.client.movetoscreen()
        end
      end),
      ]]


    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)


clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize)--,
    --awful.button({ 3 }, 1, awful.mouse.client.move)
    )


-- Set keys
root.keys(require('rc/keys'))
-- }}}




awful.rules.rules = require('rc/rules')




--[[
 mytimer = timer({ timeout = 0.2 })
 mytimer:connect_signal("timeout", function()

 for i = 1, 2 do
  myprogressbar[i]:set_value(0)
 end
  s = mouse.screen
   myprogressbar[s]:set_value(1)

  end)
 mytimer:start()
]]





-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)

        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c)
            and c.class ~= 'jetbrains-phpstorm'
            then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        --awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = true
    if titlebars_enabled and (
       --c.type == "normal" or
       c.type == "dialog")
       and (c.class ~= "jetbrains-phpstorm") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                )

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        --[[ Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))
        ]]

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)



        awful.titlebar(c):set_widget(layout)

    end
end)

client.connect_signal("focus", function(c)
   c.border_color = beautiful.border_focus
 end)
client.connect_signal("unfocus", function(c)
   c.border_color = beautiful.border_normal
  end)


 client.disconnect_signal("request::activate", awful.ewmh.activate)
   function awful.ewmh.activate(c)
       if c:isvisible() then
           client.focus = c
           c:raise()
       end
   end
   client.connect_signal("request::activate", awful.ewmh.activate)



--[[

client.connect_signal("tagged",function(c,new_tag)
   if ( #(new_tag:clients())==1 ) then
       --c.maximized_horizontal = true
       --c.maximized_vertical = true
       awful.titlebar.hide(c)
   else
        for _,cl in ipairs(new_tag:clients()) do
          awful.titlebar.show(c)
       end
   end


    --
    --
end)

client.connect_signal("untagged",function(c,old_tag)
   if ( #(old_tag:clients())==1 ) then
       local myclients = old_tag:clients()
       for _,cl in ipairs(myclients) do
          --cl.maximized_horizontal = true
          --cl.maximized_vertical = true
       end
   end
end)
]]

-- }}}





--run_once("dex -ae Awesome")
--awful.util.spawn_with_shell("wmname LG3D")
awful.util.spawn_with_shell("wmname Sawfish")




-- {{{
--
-- Autostarting for Awesome <3.4!
-- Add this section to the end of your rc.lua
-- configuration file within ~/.config/awesome/rc.lua
--
-- If you're using Awesome 3.5 change:
-- add_signal -> connect_signal
-- remove_signal --> disconnect_signal
--
-- Thanks to eri_trabiccolo as well as psychon
--
function spawn_once(command, class, tag)
-- create move callback
local callback
callback = function(c)
if c.class == class then
awful.client.movetotag(tag, c)
client.disconnect_signal("manage", callback)
end
end
client.connect_signal("manage", callback)
-- now check if not already running!
local findme = command
local firstspace = findme:find(" ")
if firstspace then
findme = findme:sub(0, firstspace-1)
end
-- finally run it

--local cmd = "pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. command .. ")"

local cmd = "run_once.sh " .. command


awful.util.spawn_with_shell(cmd)
end

-- use the spawn_once





spawn_once("subl3", "Subl3", tags[1])
--spawn_once("subl", "Sublime_text", tags[1][2])

--spawn_once("pcmanfm", "Pcmanfm", tags[1][4])
spawn_once("thunderbird", "Thunderbird", tags[9])


--spawn_once("deadbeef", "Deadbeef", tags[2][10])
--spawn_once("guayadeque", "Guayadeque", tags[2][10])

--spawn_once("roxterm", "Roxterm", tags[1][5])

--spawn_once("mlo.sh", "Wine", tags[2][2]) -- 1: mlo
spawn_once("firefox-main.sh", "Firefox", tags[3])





-- }}}
