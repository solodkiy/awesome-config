

local awful = require("awful")
local sharetags = require("sharetags")

local lain = require("lain")


local default = lain.layout.uselesstile;

layouts = {
    default,
    
    awful.layout.suit.tile.left,
--    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,

    awful.layout.suit.max,
    --awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,

    lain.layout.termfair,
    lain.layout.centerfair,
    lain.layout.cascade,
    lain.layout.centerwork,
}

lain.layout.termfair.nmaster = 3
lain.layout.termfair.ncol = 1

lain.layout.centerfair.nmaster = 3
lain.layout.centerfair.ncol = 1




local tags_names  = {
    "~: notes", "1: text", "2: www", "3: file", "4: console", "5: win", "6", "7", "8: email", "9: torrents", "0: music",
    "Q: im", "W: code", "E: work", "R",
    "A: skype", "S" }


local tags_layout = {
    default, -- ~
    lain.layout.centerfair, -- 1
    lain.layout.centerwork, -- 2
    lain.layout.centerwork, -- 3
    lain.layout.centerfair, -- 4
    awful.layout.suit.max, -- 5
    layouts[2], -- 6 
    layouts[2], -- 7
    layouts[2], -- 8
    layouts[2], -- 9
    layouts[2], -- 0
    awful.layout.suit.tile, -- Q
    layouts[2], 
    layouts[2], 
    layouts[2],
    lain.layout.centerwork, 
    layouts[2]
}





--[[
 tags_s2 = {
   names  = { "0: other",  "1: mlo", "2: www", "3: file", "4: console", "5: windows", "6", "7", "8: email", "9: music", "10", "Q: IM", "W", "E: git"  },
   layout = { layouts[2], layouts[2], awful.layout.suit.max, layouts[2], awful.layout.suit.tile.bottom, awful.layout.suit.max,
              layouts[2], layouts[2], layouts[2], layouts[2], layouts[2],  awful.layout.suit.fair, layouts[2], layouts[2]
 }}
  ]]

 --for s = 1, screen.count() do
     -- Each screen has its own tag table.
 --end

--tags = {}
--tags[1] = awful.tag(tags_s1.names, 1, tags_s1.layout)
--tags[2] = awful.tag(tags_s2.names, 2, tags_s2.layout)

--dump(sharetags.taglist)

function get_buttons(screen)
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function (t) sharetags.select_tag(t, screen) end),
        awful.button({ modkey }, 1, awful.client.movetotag),
        awful.button({ }, 3,  function (t) sharetags.toggle_tag(t, screen) end),
        awful.button({ modkey }, 3, awful.client.toggletag)
    -- awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    -- awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
    )
    return buttons
end




    -- Create widget
    local sharetags_taglist = require("sharetags.taglist")
    tags = sharetags.create_tags(tags_names, tags_layout)
    mytaglist = {}
    for s = 1, screen.count() do
        -- Create a taglist widget
        --mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, buttons)
        mytaglist[s] = sharetags_taglist(tags, s, awful.widget.taglist.filter.all, get_buttons(s))
    end

return mytaglist
