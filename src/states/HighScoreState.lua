

HighScoreState = Class{__includes = BaseState}

function HighScoreState:enter(params)

	self.highScore = params.highScores

end

function HighScoreState:update(dt)
    if love.keyboard.wasPressed('escape') then
        gSounds['wall-hit']:play()
        
        gStateMachine:change('start', {
            highScores = self.highScores
        })
    end
end


function HighScoreState:render()

	love.graphics.setFont(gFont['large'])
	love.graphics.printf('HIGHSCORE',0,20,VIRTUAL_WIDTH,'center')

	love.graphics.setFont(gFont['medium'])

	for i = 1,10 do
		local name = self.highScore[i].name or '- - -'
		local score = self.highScore[i].score or '- - -'

		love.graphics.printf(tostring(i)..'.',VIRTUAL_WIDTH/4, 60 + i * 13 , 50,'left')
		love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38,60 + i * 13, 50, 'right')
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2,60 + i * 13, 100, 'right')
	end

	love.graphics.setFont(gFont['small'])
	love.graphics.printf('Press Escape to return to Main Menu!',0,VIRTUAL_HEIGHT-30,VIRTUAL_WIDTH,'center')


end