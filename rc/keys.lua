local awful = require("awful")
-- local APW = require("apw/widget")
local lain = require("lain")

local sharetags = require("sharetags")



function runCalc()
    local current_tag = awful.tag.selected();
    if (current_tag) then

        local filter = function (c)
            return awful.rules.match(c, {class = "Galculator"})
        end
        local found = false

        for c in awful.client.iterate(filter) do

            awful.client.movetotag(current_tag, c)
            client.focus = c
            c.minimized = false
            c:raise()
            --
            found = true
        end
        if (not found) then
            awful.util.spawn("galculator")
        end
    end
end

globalkeys = awful.util.table.join(

    awful.key({ modkey }, ";", function () hints.focus() end),

    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    -- awful.key({ modkey,           }, "Escape", awful.tag.history.restore),


    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),

    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),


    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
         function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),




    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    --awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),

    awful.key({ modkey  }, "Next",  function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey  }, "Prior", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

  awful.key({ "Mod1", "Control" }, "a", function () awful.util.spawn("keepass --auto-type") end),


    awful.key({ modkey }, "'",
        function()
            awful.menu.menu_keys.down = { "Down", "Alt_L", "Tab", "j" }
            awful.menu.menu_keys.up = { "Up", "k" }
            lain.util.menu_clients_current_tags({ width = 350 }, { keygrabber = true })
        end),



    -- Run
    awful.key({ modkey }, "d", function()
      if (awful.tag.selected()) then
        awful.util.spawn("synapse")
      end
    end),




    awful.key({ }, "XF86PowerOff",          function () awful.util.spawn("xkill") end),
    awful.key({ "Control" }, "XF86PowerOff",          function () awful.util.spawn("exitmenu") end),


    -- awful.key({ }, "XF86AudioRaiseVolume",  APW.Up),
    -- awful.key({ }, "XF86AudioLowerVolume",  APW.Down),
    -- awful.key({ }, "XF86AudioMute",         APW.ToggleMute),


    --lang
    awful.key({ }, "#130",   function () awful.util.spawn("xkb-switch -s us") end), --E
    awful.key({ }, "#131",   function () awful.util.spawn("xkb-switch -s ru") end), --R


    awful.key({ modkey }, "F12",function () runCalc() end),
    awful.key({ }, "XF86Calculator",function () runCalc() end),



    awful.key({ modkey }, "/", function() cheeky.util.switcher() end),

    awful.key({ }, "XF86ZoomIn",function () awful.tag.viewprev() end),
    awful.key({ }, "XF86ZoomOut",function () awful.tag.viewnext() end),


    --[[ Audio player
    awful.key({ }, "XF86AudioPlay",function () awful.util.spawn("guayadeque_playpause.sh")  end),
    awful.key({ }, "XF86AudioPrev",function () awful.util.spawn("guayadeque_prev.sh")  end),
    awful.key({ }, "XF86AudioNext",function () awful.util.spawn("guayadeque_next.sh")  end),
    ]]

    -- Audio player
    awful.key({ }, "XF86AudioPlay",function () awful.util.spawn("deadbeef --play-pause")  end),
    awful.key({ }, "XF86AudioPrev",function () awful.util.spawn("deadbeef --prev")  end),
    awful.key({ }, "XF86AudioNext",function () awful.util.spawn("deadbeef --next")  end),



    awful.key({modkey}, "x", function() sharetags.tag_move(nil, 2) end),





    awful.key({ }, "Print",function () awful.util.spawn("doc-shoot") end),



    awful.key({ modkey, "Control" }, "l",function () awful.util.spawn("dm-tool switch-to-greeter") end), -- xscreensaver-command -lock

    -- Скрывает теги с текущего экрана. При повторном нажатии с дополнительного.
    awful.key({ modkey }, "z",     function ()
      if (awful.tag.selected()) then
        awful.tag.viewnone()
      else
        screen = mouse.screen+1
        if (screen > 2) then screen = 1 end
        if (awful.tag.selected(screen)) then
          awful.tag.viewnone(screen)
        end
      end
    end),


    -- Переход на другой экран
    awful.key({ modkey,           }, "space",    function ()
      num = mouse.screen+1
      if (num > 2) then num = 1 end
      awful.screen.focus(num)
    end),

    awful.key({ modkey,           }, "o",  function () sharetags.swap_screen(1, 2) end)
)



-- Keys: ~, 1-9, 0, Q-R, A-S
local keys = {"#49", "#10", "#11", "#12", "#13", "#14", "#15", "#16", "#17", "#18", "#19", 'q', 'w', 'e', 'r', 'a', 's'}

for i, key in ipairs(keys) do
        globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, key,
                  function ()
                      local screen = mouse.screen
                      local tag = tags[i]
                      sharetags.select_tag(tag, screen)

                  end),
        awful.key({ modkey, "Control" }, key,
                  function ()
                      local screen = mouse.screen
                      local tag = tags[i]
                      sharetags.toggle_tag(tag, screen)
                  end),
        awful.key({ modkey, "Shift" }, key,
                  function ()
                      --if client.focus then
                          local tag = tags[i]
                          awful.client.movetotag(tag)
                          --awful.client.focus.maximized = false
                          --if client.maximized then
                          --  client.maximized = false
                          --  client.maximized = true
                          --end
                      --end
                  end)
        --[[
        awful.key({ modkey, "Control", "Shift" }, key,
                  function ()
                      if client.focus then
                          local tag = tags[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end)
        ]]
        )
end




return globalkeys
