
require 'src/Dependencies'

function love.load() 

	love.graphics.setDefaultFilter('nearest', 'nearest')

	math.randomseed(os.time())
	push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = true,
        resizable = true
    })

	gFont = {
		['small'] = love.graphics.newFont('fonts/font.ttf',8),
		['medium'] = love.graphics.newFont('fonts/font.ttf',16),
		['large'] = love.graphics.newFont('fonts/font.ttf',32),
		['flappyMedium'] = love.graphics.newFont('fonts/flappy.ttf',16)
	}

	love.graphics.setFont(gFont['small'])

	gTextures = {
	        ['background'] = love.graphics.newImage('graphics/background.png'),
	        ['main'] = love.graphics.newImage('graphics/breakout.png'),
	        ['arrows'] = love.graphics.newImage('graphics/arrows.png'),
	        ['hearts'] = love.graphics.newImage('graphics/hearts.png'),
	        ['particle'] = love.graphics.newImage('graphics/particle.png')
	    }
	    

	gFrames = {
		['paddles'] = GenerateQuadsPaddles(gTextures['main']),
		['ball'] = GenerateQuadsBalls(gTextures['main']),
		['bricks'] = GenerateQuadsBricks(gTextures['main']),
		['hearts'] = GenerateQuadsHearts(gTextures['hearts']),
		['arrows'] = GenerateQuadsArrows(gTextures['arrows'])
	}

	gSounds = {
	        ['paddle-hit'] = love.audio.newSource('sounds/paddle_hit.wav','static'),
	        ['score'] = love.audio.newSource('sounds/score.wav','static'),
	        ['wall-hit'] = love.audio.newSource('sounds/wall_hit.wav','static'),
	        ['confirm'] = love.audio.newSource('sounds/confirm.wav','static'),
	        ['select'] = love.audio.newSource('sounds/select.wav','static'),
	        ['no-select'] = love.audio.newSource('sounds/no-select.wav','static'),
	        ['brick-hit-1'] = love.audio.newSource('sounds/brick-hit-1.wav','static'),
	        ['brick-hit-2'] = love.audio.newSource('sounds/brick-hit-2.wav','static'),
	        ['hurt'] = love.audio.newSource('sounds/hurt.wav','static'),
	        ['victory'] = love.audio.newSource('sounds/victory.wav','static'),
	        ['recover'] = love.audio.newSource('sounds/recover.wav','static'),
	        ['high-score'] = love.audio.newSource('sounds/high_score.wav','static'),
	        ['pause'] = love.audio.newSource('sounds/pause.wav','static'),

	        ['music'] = love.audio.newSource('sounds/music.wav','static')
	    }

    gStateMachine = StateMachine{
    	['start'] = function() return StartState() end,
    	['serve'] = function() return ServeState() end,
    	['play'] = function() return PlayState() end,
    	['victory'] = function() return VictoryState() end,
    	['gameOver'] = function() return GameOverState() end,
    	['highScore'] = function() return HighScoreState() end,
    	['paddle-select'] = function() return PaddleSelectState() end
    }

    gStateMachine:change('start',{
    	highScores = loadHighScore()
    })

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}

 --    psystem = love.graphics.newParticleSystem(gTextures['particle'],32)
 --    -- psystem:setTimer(2,5)
 --    psystem:setParticleLifetime(2, 5) -- Particles live at least 2s and at most 5s.
	-- psystem:setEmissionRate(5)
	-- psystem:setSizeVariation(1)
	-- psystem:setLinearAcceleration(-20, -20, 20, 20) -- Random movement in all directions.
	-- psystem:setColors(1, 1, 1, 1, 1, 1, 1, 0)

end


function love.keypressed(key)
	
	love.keyboard.keysPressed[key] = true

end

function love.keyboard.wasPressed(key)
	if love.keyboard.keysPressed[key] then 
		return true
	else 
		return false
	end
	-- body
end

function love.update(dt)

	gStateMachine:update(dt)
	love.keyboard.keysPressed = {}

end

function love.resize(w,h)

	push:resize(w,h)

end

function love.draw()

	push:apply('start')

	local backgroundWidth = gTextures['background']:getWidth()
    local backgroundHeight = gTextures['background']:getHeight()

    -- love.graphics.draw(psystem,VIRTUAL_WIDTH/2, VIRTUAL_HEIGHT/2)

    love.graphics.draw(gTextures['background'], 
        0, 0, 
        0,
        VIRTUAL_WIDTH / (backgroundWidth - 1), VIRTUAL_HEIGHT / (backgroundHeight - 1))
    gStateMachine:render()
    displayFPS()

	push:apply('end')

end

function loadHighScore()
	love.filesystem.setIdentity('breakout')

	if not love.filesystem.getInfo('breakout.lst') then
		local scores = ''
		for i = 10,1,-1 do
			scores = scores .. 'CTO\n'
			scores = scores .. tostring(i*1000) .. '\n'
		end

		love.filesystem.write('breakout.lst', scores)
	end

	local name = true
    local currentName = nil
    local counter = 1

    local scores = {}

    for i= 1,10 do 
    	scores[i] = {
    		name = nil,
    		score = nil
    	}
    end

    for line in love.filesystem.lines('breakout.lst') do
    	if name then
    		scores[counter].name = string.sub(line,1,3)
    	else 
    		scores[counter].score = tostring(line)
	    	counter = counter + 1
    	end
    	name = not name
    end

    return scores

end

function renderHealth(health)

	local healthX = VIRTUAL_WIDTH - 40

	for i = 1,health do
		love.graphics.draw(gTextures['hearts'], gFrames['hearts'][1], healthX, 8)
		healthX = healthX + 11
	end

	for i = 1, 3 - health do 
		love.graphics.draw(gTextures['hearts'], gFrames['hearts'][2], healthX , 8)
		healthX = healthX + 11
	end

end

function displayFPS()

	love.graphics.setFont(gFont['small'])
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 5, 5)

end

function renderScore(score)
    love.graphics.setFont(gFont['small'])
    love.graphics.print('Score:', VIRTUAL_WIDTH - 60, 5)
    love.graphics.printf(tostring(score), VIRTUAL_WIDTH - 50, 5, 40, 'right')
end