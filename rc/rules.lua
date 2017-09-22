
local awful = require("awful")
local beautiful = require("beautiful")



-- {{{ Rules
local rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
		     size_hints_honor = false, } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },

       { rule = { class = "Galculator" },
      properties = { floating = true } },



    { rule = { instance = "plugin-container" },
      properties = {  --fullscreen = true  
      floating = true
      } },


-- { rule = { name=  "Действия над файлами"}, 
-- properties = { floating = true }},


    -- Set Firefox to always map on tags number 2 of screen 1.
    
    { rule = { class = "Firefox" },
      properties = { 
          border_width = 0
      } },



      { rule = { class = "Synapse" },
        properties = {        
--        border_width = 0
      } },  


      


{ rule = { class = "Wine" },
      properties = { 
        
        border_width = 0

      } },  

      { rule = { class = "Conky" },
  properties = {
      floating = true,
      sticky = true,
      ontop = false,
      focusable = false,
      border_width = 0,
      size_hints = {"program_position", "program_size"}
  } },
      

   
    --[[
    { rule = { class = "Thunar" },
      properties = { tag = tags[1][4] } },  
    { rule = { class = "Nautilus" },
      properties = { tag = tags[1][4] } },  
    { rule = { class = "Pcmanfm" },
      properties = { tag = tags[1][4]  } }, 
      ]] 

--[[
    { rule = { class = "jetbrains-phpstorm" },
      properties = { tag = tags[13],
          border_width =  0,
                     --floating = true
                     } },

    { rule = { class = "jetbrains-phpstorm",
        instance = "sun-awt-X11-XDialogPeer"
    },
        properties = {
            border_width =  beautiful.border_width,
            floating = true
        } },
]]


       { rule = { name = "ExitMenu" },
      properties = { 
        floating = true,
        ontop = true,
      } },  



    { rule = { class = "Thunderbird" },
      properties = {
          tag = tags[9],
      }
    },



    { rule = { class = "Deadbeef" },
      properties = {
          tag = tags[11]
      }
    },

    { rule = { class = "VBoxSDL" },
      properties = { tag = tags[6],
                     border_width = 0,
      }
    },


    { rule = { class = "Skype" },
      properties = { tag = tags[12] } },
    { rule = { class = "Pidgin" },
      properties = { tag = tags[12] } },
    { rule = { class = "HipChat" },
      properties = { tag = tags[12] } },
    { rule = { class = "Bitmessagemain.py" },
      properties = { tag = tags[12] } },



    -- awful.tag.setproperty(tags[12], "mwfact", 0.20)

 
    
}


return rules
