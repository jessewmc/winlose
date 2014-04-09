mortar = {}
math.randomseed(os.time())

function mortar.new()
	return { x = player_sprite.x,
			y = player_sprite.y,
			speed = 300,
			accel_y = 5000,
			velocity_y = -1500,
			velocity_max = 10,
			grounded = false,
			jump = -1500,
			color = {255, math.random(0,255), 0},
			width = 25,
			height = 25,
			touching = false,
			velocity_x = 100,
			accel_x = 10}
end

