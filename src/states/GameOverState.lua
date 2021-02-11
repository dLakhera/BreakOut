
GameOverState = Class{__includes = BaseState}

function GameOverState:enter(params)
	-- body
	self.score = params.score
	self.highScore = params.highScore
end

function GameOverState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start',{
        	highScore = loadHighScore()
        })
    elseif love.keyboard.wasPressed('escape') then
    	love.event.quit()
    end
end

function GameOverState:render()

	love.graphics.setFont(gFont['large'])
	love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

	love.graphics.setFont(gFont['medium'])
	love.graphics.printf('Game Over', 0, VIRTUAL_HEIGHT/2 - 50, VIRTUAL_WIDTH, 'center')
	love.graphics.printf('Press Enter to Play Again!', 0, 130, VIRTUAL_WIDTH, 'center')
end