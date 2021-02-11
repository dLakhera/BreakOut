
Ball = Class{}

function Ball:init(skin)

	self.width = 8
	self.height = 8

	self.x = VIRTUAL_WIDTH / 2 - 4
	self.y = VIRTUAL_HEIGHT / 2 - 4 

	self.dx = 0
	self.dy = 0

	self.skin = skin
	-- body
end

function Ball:collides(target)

	if self.x + self.width > target.x and self.x < target.x + target.width then
		if self.y < target.y + target.height and self.y + self.height > target.y  then
			return true
		end
	else 
		return false
	end

end

function Ball:update(dt)

	self.x = self.x + self.dx * dt
	self.y = self.y + self.dy * dt

	if self.x <= 0 then 
		self.dx = -self.dx
		self.x = 0
		gSounds['wall-hit']:play()
	end

	if self.x >= VIRTUAL_WIDTH - 8 then
		self.x = VIRTUAL_WIDTH -8 
		self.dx = -self.dx
		gSounds['wall-hit']:play()
	end

	if self.y <= 0 then 
		self.y = 0
		self.dy = -self.dy
		gSounds['wall-hit']:play()
	end

	if self.y >= VIRTUAL_HEIGHT - 8 then 
		gSounds['hurt']:play()
		
		gStateMachine:change('gameOver',{
			score
		})
	end
end

function Ball:render()

	love.graphics.draw(gTextures['main'], gFrames['ball'][self.skin] ,self.x,self.y )

end
