mortar = {}
math.randomseed(os.time())

function mortar.new()
	local scr_x, scr_y = love.window.getDimensions()

	return { x = scr_x + player_sprite.x - 150,
			y = player_sprite.y - 150,
			speed = 300,
			accel_y = 5000,
			velocity_y = -150,
			velocity_max = 10,
			grounded = false,
			jump = -1500,
			color = {255, math.random(0,255), 0},
			width = 50,
			height = 50,
			touching = false,
			velocity_x = -200,
			accel_x = 10}
end

