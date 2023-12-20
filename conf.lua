require 'constants'

-- Configuration
function love.conf(g)
    g.title = "Project Nirvana" -- The title of the window the game is in (string)
    g.version = "11.5"          -- The LÖVE version this game was made for (string)
    g.console = true            -- For Windows debugging

    g.window.width = WINDOW_WIDTH
    g.window.height = WINDOW_HEIGHT
    g.window.usedpiscale = true
    g.window.fullscreen = false
    g.window.resizable = false
end