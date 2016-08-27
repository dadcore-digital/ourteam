local shine = require 'shine'

-- Shaders
local grain = shine.filmgrain()
grain.opacity = 0.1

local vignette = shine.vignette()
vignette.opacity = 0.5

local scanlines = shine.scanlines()
scanlines.opacity = 0.1

local crt = shine.crt()
crt.x = 0.05
crt.y = 0.05

local post_effect = grain:chain(vignette):chain(scanlines):chain(crt)

return post_effect