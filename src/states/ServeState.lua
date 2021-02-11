
ServeState = Class{__includes = BaseState}

function ServeState:enter(params)
	-- self.paddle = Paddle()
	
	self.paddle = params.paddle
	-- self.ball = params.ball
	self.bricks = params.bricks
	self.score = params.score
	self.health = params.health
    self.level = params.level
    self.highScore = params.highScores
	self.ball = Ball()
	self.ball.skin = math.random(7)

	-- body
end

function ServeState:update( dt )

	self.paddle:update(dt)
    self.ball.x = self.paddle.x + (self.paddle.width / 2) - 4
    self.ball.y = self.paddle.y - 8

	if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then

		gStateMachine: change('play',{
			paddle = self.paddle,
			ball = self.ball,
			health = self.health,
			score = self.score,
			bricks = self.bricks,
			level = self.level,
			highScore = self.highScore
		})
	end
	-- body
end

function ServeState:render()

	self.paddle:render()
    self.ball:render()

    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    love.graphics.setFont(gFont['small'])
    love.graphics.print('Score:'..tostring(self.score) , 5, 12)

    renderHealth(self.health)
    love.graphics.setFont(gFont['medium'])
    love.graphics.printf('Press Enter to serve!', 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')

end
