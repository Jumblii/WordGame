-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local composer = require("composer")
display.setStatusBar(display.HiddenStatusBar)
local path = system.pathForFile("words.txt", system.ResourceDirectory)
local file, errorString = io.open(path, "r")
words = {}

if not file then 
    print("File error"..errorString)
else 
    for line in file:lines() do 
        table.insert(words, line)
    end
    io.close(file)
end

function shuffle(array)
	for i=#array, 2, -1 do
		local j = math.random(i)
		array[i], array[j] = array[j], array[i]
	end
	return array
end


math.randomseed( os.time() )
composer.gotoScene("menu")
