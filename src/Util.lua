

Util = Class{}

function GenerateQuads(atlas, tilewidth,tileheight)

	local sheetWidth = atlas:getWidth() / tilewidth
	local sheetHeight = atlas:getHeight() / tileheight

	local sheetcounter = 1
	local spritesheet = {}

	for y = 0, sheetHeight -1 do
		for x = 0, sheetWidth - 1 do 
			spritesheet[sheetcounter] = love.graphics.newQuad(x * tilewidth , y* tileheight , tilewidth, tileheight, atlas:getDimensions())
			sheetcounter = sheetcounter + 1
		end
	end

	return spritesheet

end

function table.slice(tbl, first, last, step)
    local sliced = {}
  
    for i = first or 1, last or #tbl, step or 1 do
      sliced[#sliced+1] = tbl[i]
    end
  
    return sliced
end

function GenerateQuadsPaddles(atlas)

	local x =0
	local y = 64

	local counter = 1
	local quads = {}

	
	for i = 0, 3 do
	    -- smallest
	    quads[counter] = love.graphics.newQuad(x, y, 32, 16,
	        atlas:getDimensions())
	    counter = counter + 1
	    -- medium
	    quads[counter] = love.graphics.newQuad(x + 32, y, 64, 16,
	        atlas:getDimensions())
	    counter = counter + 1
	    -- large
	    quads[counter] = love.graphics.newQuad(x + 96, y, 96, 16,
	        atlas:getDimensions())
	    counter = counter + 1
	    -- huge
	    quads[counter] = love.graphics.newQuad(x, y + 16, 128, 16,
	        atlas:getDimensions())
	    counter = counter + 1

	    -- prepare X and Y for the next set of paddles
	    x = 0
	    y = y + 32
	end

	return quads

end

function GenerateQuadsBalls(atlas)

	local x = 96 
	local y = 48

	local counter = 1
	local quads = {}

	for i = 0,3 do 
		quads[counter] = love.graphics.newQuad(x,y,8,8,
			atlas:getDimensions())
		counter = counter + 1
		x = x + 8 
	end

	x = 96
	y = 56

	for i = 0,2 do 

		quads[counter] = love.graphics.newQuad(x,y,8,8,
			atlas:getDimensions())
		counter = counter + 1
		x = x + 8 

	end

		-- quads[counter] = love.graphics.newQuad(x + 8,y,8,8,
		-- 	atlas:getDimensions())
		-- counter = counter + 1

		-- quads[counter] = love.graphics.newQuad(x + 8,y,8,8,
		-- 	atlas:getDimensions())
		-- counter = counter + 1

		-- if not i == 1 then
		-- 	quads[counter] = love.graphics.newQuad(x + 8,y,8,8,
		-- 		atlas:getDimensions())
		-- 	counter = counter + 1
		-- end

		-- x = 96
		-- y = y + 8
	-- end

	return quads

end

function GenerateQuadsBricks(atlas)
    return table.slice(GenerateQuads(atlas, 32, 16), 1, 21)
    -- local x = 0
    -- local y = 0

    -- local counter = 1
    -- local quads = {}

    -- for i= 0,2 do
    -- 	for j = 0,3 do
    -- 		quads[counter] = love.graphics.newQuad(x,y,32,16,
    -- 			atlas:getDimensions())
    -- 		counter = counter + 1
    -- 		x = x + 32
    -- 	end
    -- 	x = 0 
    -- 	y = y + 16
    -- end	

    -- x = 0 
    -- y = 48
    -- for i = 0,2 do 
    -- 	quads[counter] = love.graphics.newQuad(x,y,32,16,
    -- 		atlas:getDimensions())
    -- 	counter = counter + 1
    -- 	x = x + 32 
    -- end
--end
end

function  GenerateQuadsHearts(atlas)
	local x = 0
	local y = 0

	local counter = 1
	local quads = {}

	quads[counter] = love.graphics.newQuad(x,y,8,8,
		atlas:getDimensions())
	counter = counter + 1
	x = x + 8
	quads[counter] = love.graphics.newQuad(x,y,8,8,
		atlas:getDimensions())

	return quads
	-- body
end

function GenerateQuadsArrows( atlas )
	return table.slice(GenerateQuads(atlas,24,24),1,2)
	-- local x = 0
	-- local y = 0

	-- local counter = 1;
	-- local quads = {}

	-- for i =0,1 do
	-- 	quads[counter] = love.graphics.newQuad(x,y, 24, 24,
	-- 		atlas:getDimensions())
	-- 	x = x + 24
	-- 	counter = counter + 1
	-- end

	-- return quads
	-- body
end























	-- local x = 0
	-- local y = 0

	-- local counter = 1
	-- local quads = {}

	-- for i= 0,2 do
	-- 	for j = 0,3 do
	-- 		quads[counter] = love.graphics.newQuad(x,y,32,16,
	-- 			atlas:getDimensions())
	-- 		counter = counter + 1
	-- 		x = x + 32
	-- 	end
	-- 	x = 0 
	-- 	y = y + 16
	-- end	

	-- x = 0 
	-- y = 48
	-- for i = 0,2 do 
	-- 	quads[counter] = love.graphics.newQuad(x,y,32,16,
	-- 		atlas:getDimensions())
	-- 	counter = counter + 1
	-- 	x = x + 32 
	-- end