
PlayState = Class{__includes = BaseState}

function PlayState:enter(params)

	self.paddle = params.paddle
	self.ball = params.ball
	self.bricks = params.bricks
	self.health = params.health
	self.score = params.score
	self.level = params.level
	self.highScore = params.highScores
	--[[
	self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.ball = params.ball
--]]

	self.ball.dx = math.random(2) == 1 and math.max(math.abs(math.random(-200,-100)),math.random(100,200)) 
					or -math.max(math.abs(math.random(-200,-100)),math.random(100,200))
	self.ball.dy = math.random(-50,-60)

	self.paused = false
end

function PlayState:update(dt)

	if self.paused then
		if love.keyboard.wasPressed('space') then
			self.paused = false
			gSounds['pause']:play()
		else 
			return
		end
	elseif self.paused == false then
		if love.keyboard.wasPressed('space') then
			self.paused = true
			gSounds['pause']:play()
			return
		end
	end

	self.paddle:update(dt)
	self.ball:update(dt)


	if self.ball:collides(self.paddle) then 
		-- //self.ball.dy = -self.ball.dy
		
		self.ball.y = self.paddle.y - 8
        self.ball.dy = -self.ball.dy

		if self.paddle.dx<0 and self.ball.x < self.paddle.x + self.paddle.width/2 then
			self.ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - self.ball.x))
		elseif self.ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
			self.ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - self.ball.x))
		end

		gSounds['paddle-hit']:play()
	end

	for k,brick in pairs(self.bricks) do 
		if brick.inPlay and self.ball:collides(brick) then
			brick:hit()
			self.score = self.score + (brick.tier * 200 + brick.color * 25)
        	if self:checkVictory() then
	           	gSounds['victory']:play()

	            gStateMachine:change('victory', {
	                level = self.level + 1,
	                paddle = self.paddle,
	                health = self.health,
	                score = self.score,
	                ball = self.ball,
	                highScore = self.highScores

	            })
	        end
			-- gSounds
			if self.ball.dx > 0 and self.ball.x + 2 < brick.x then
				self.ball.dx = -self.ball.dx
                self.ball.x = brick.x - 8
            elseif self.ball.dx < 0 and self.ball.x + 6 > brick.width + brick.x then
            	self.ball.dx = -self.ball.dx
                self.ball.x = brick.x + 32
            elseif self.ball.y < brick.y then
            	self.ball.dy = -self.ball.dy
                self.ball.y = brick.y - 8
            else 
            	self.ball.dy = -self.ball.dy
                self.ball.y = brick.y + 16
            end
            self.ball.dy = self.ball.dy * 1.02
        	-- break
        
        	-- if self:checkVictory() then
        end
	end

	if self.ball.y >= VIRTUAL_HEIGHT - 8 then 
		gSounds['hurt']:play()
		
		if self.health > 1 then
			self.health = self.health - 1
			
			gStateMachine:change('serve',{
				paddle = self.paddle,
				ball = self.ball,
				health = self.health,
				score = self.score,
				bricks = self.bricks,
				level = self.level,
				highScores =self.highScores 
			})
		elseif self.health == 1 then
			gStateMachine:change('gameOver',{
				score = self.score,
				highScores = self.highScores
			})
		end
	end

	for k, brick in pairs(self.bricks) do
	        brick:update(dt)
    end

	if love.keyboard.wasPressed('escape') then
		love.event.quit()
	end

end
	
function PlayState:render()
	
    renderHealth(self.health)

	for k,brick in pairs(self.bricks) do 
		brick:render()
		-- brick:renderParticles()
	end

	for k, brick in pairs(self.bricks) do
	       brick:renderParticles()
   end

	self.paddle:render()
	self.ball:render()



	love.graphics.setFont(gFont['small'])
	love.graphics.print('Score:'..tostring(self.score) , 5, 12)

	if self.paused then
		love.graphics.setFont(gFont['large'])
		love.graphics.printf('PAUSED', 0, VIRTUAL_HEIGHT/2 - 16, VIRTUAL_WIDTH, 'center')
	end
end

function PlayState:checkVictory()
	for k,brick in pairs(self.bricks) do
		if brick.inPlay then
			return false
		end
	end

	return true
	-- body
end