--smoking rabbit rabid frog productions
--srrf pronounced surf

--bejezzuses

require "vector"
require "camera"
require "mortar"

player_sprite = {	x = 250,
					y = 10,
					speed = 300,
					accel_y = 5000,
					velocity_y = 0,
					velocity_max = 10,
					grounded = false,
					jump = -1500,
					color = {255, 105, 180},
					width = 50,
					height = 50,
					touching = false,
					velocity_x = 500,
					accel_x = 10
				}
				
ground = {	x = 200,
			y = 400,
			width = 40000,
			height =  50,
			color = {0, 150, 33}
		}
		
obstacles = {}
math.randomseed(os.time())
clouds = {}
clouds2 = {}
for i = 1, 100, 1 do
	table.insert(clouds, { x = math.random(-100, 40000),
				y = math.random(-100, 500),
				width = math.random(200, 1000),
				height = math.random(50, 150),
				color = {255, 255, 255}
				})
	table.insert(clouds2, { x = math.random(-100, 40000),
				y = math.random(-100, 500),
				width = math.random(200, 1000),
				height = math.random(50, 150),
				color = {190, 190, 190}
				})
	table.insert(obstacles, {x = math.random(-100, 40000),
				y = math.random(-100, 800),
				width = math.random(50, 1000),
				height = 50,
				color = {255, math.random(0,255), 0}})
end
--[[cloud1 = { x = 300,
					y = 100,
					width = 300,
					height = 100,
					color = {255, 255, 255}
					}
	]]	
npos = {ground, unpack(obstacles)}
objects = {player_sprite, ground, unpack(obstacles)}
moveable = {player_sprite}
collide ={player_sprite}
str = ""
mort = nil
words = 0
elapsed = 0
start_time =  0

--to allow easy key remapping
local right = "right"
local left = "left"
local down = "down"
local up = "up"

local collisions = false

function love.load()
	start_time= os.time()
	camera.newLayer(camera, 0.3,  function()
		for o in values(clouds2) do
			love.graphics.setColor(o.color)
			love.graphics.rectangle("fill", o.x, o.y, o.width, o.height)
		end
	end)
	camera.newLayer(camera, 0.5, function()
		for o in values(clouds) do
			love.graphics.setColor(o.color)
			love.graphics.rectangle("fill", o.x, o.y, o.width, o.height)
		end
	end)
	camera.newLayer(camera, 1, function()
		for o in values(objects) do
			love.graphics.setColor(o.color)
			love.graphics.rectangle("fill", o.x, o.y, o.width, o.height)
		end
		love.graphics.setColor({255,255,255})
		--math.floor stops shaking when stationary, but not when moving
		--love.graphics.print("FPS: " .. love.timer.getFPS(), math.floor(camera.x), math.floor(camera.y))
	end)
end

function love.keypressed(key, isrepeat)
	str = str .. key

	if key == " " then
		words = words + 1
	end
end

function love.update(dt)
	elapsed= elapsed + os.difftime(os.time(), start_time)
	if love.keyboard.isDown("escape") then
		love.event.push("quit")
		--os.exit()
	end

	collisions = check_collisions(collide, npos)

	if mort and aabb_collision(player_sprite, mort) then
		love.event.push("quit")
	end

	for o in values(moveable) do
		o.y = o.y + o.velocity_y * dt
		o.velocity_y = o.velocity_y + o.accel_y * dt
		o.x = o.x + o.velocity_x * dt
		o.velocity_x = o.velocity_x + o.accel_x * dt
	end
	--[[if not player_sprite.grounded or not player_sprite.touching then
		player_sprite.y = player_sprite.y + player_sprite.velocity_y * dt
		player_sprite.velocity_y = player_sprite.velocity_y + player_sprite.accel_y * dt
	--end]]

	if love.keyboard.isDown("/") and mort==nil then
		mort = mortar.new()
		table.insert(objects, mort)
		table.insert(moveable, mort)
		table.insert(collide, mort)
	end

	--make function to abstract this
	if mort and mort.x < player_sprite.x - 1500 then
		table.remove(objects)
		table.remove(moveable)
		table.remove(collide)
		mort = nil
	end

	if love.keyboard.isDown("z") and player_sprite.grounded then
		player_sprite.velocity_y = player_sprite.jump
		player_sprite.grounded=false
	end
	camera.setPosition(camera, player_sprite.x - 150, player_sprite.y - 300)
end
	
function love.draw()
	camera.draw(camera)
	love.graphics.print("FPS: " .. love.timer.getFPS(), 0, 0)
	love.graphics.print("elapsed: " .. elapsed, 0, 75)
end

function apply_gravity()
end	

function check_collisions(a,b)
	for p in values(a) do
		for o in values(b) do 
			local col, vec = aabb_collision(p, o)
			if col then
				if min_x(vec) then
					p.x = p.x + vec.x
				else
					p.y = p.y + vec.y
					p.velocity_y = 0
					if(vec.y <= 0) then
						p.grounded = true
					end
				end
				return true
			end
			--[[if(vec.y == 0) then
				player_sprite.touching = true
			end]]
		end
	end
end

