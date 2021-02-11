
StartState = Class{__includes = BaseState}

local highlighted = 1

function StartState:enter(params)
    self.highScores = params.highScores
end

function StartState:update(dt)

	if love.keyboard.wasPressed('up') or love.keyboard.wasPressed('down') then
		highlighted = (highlighted == 1 and 2 or 1)

		gSounds['paddle-hit']:play()
	end

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        if highlighted == 1 then
            gStateMachine:change('paddle-select',{
                -- paddle = Paddle(1),
                -- bricks = LevelMaker.createMap(1),
                -- health = 3,
                -- score = 0,
                -- level = 0,
                highScore = self.highScores
            })
        elseif highlighted == 2 then 
            gStateMachine:change('highScore',{
                highScores = self.highScores
            })
        end
    end

	if love.keyboard.wasPressed('escape') then
	        love.event.quit()
    end
	-- body
end

function StartState:render()

	love.graphics.setFont(gFont['large'])
    
    love.graphics.printf("BREAKOUT", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    
    -- instructions
    love.graphics.setFont(gFont['flappyMedium'])

    love.graphics.printf('A Game by Deepak Lakhera', 0, VIRTUAL_HEIGHT/3 + 30 , VIRTUAL_WIDTH ,'center')

    -- if we're highlighting 1, render that option blue

    love.graphics.setFont(gFont['medium'])

    if highlighted == 1 then
        love.graphics.setColor(0, 255, 0, 255)
    end
    love.graphics.printf("START", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)

    -- render option 2 blue if we're highlighting that one
    if highlighted == 2 then
        love.graphics.setColor(0,255,0, 255)
    end
    love.graphics.printf("HIGH SCORES", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(255, 255, 255, 255)
-- body
end