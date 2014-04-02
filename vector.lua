function aabb_collision(box2, box1)
	local box1c = centre(box1)
	local box2c = centre(box2)
	local dist = vec_sub(box2c, box1c)
	local abs_dist = vec_abs(dist)
	local half1 = halfs(box1)
	local half2 = halfs(box2)
	local half_sum = vec_sum(half1, half2)
	local interm = vec_sub(abs_dist, half_sum)
	local calc = vec_abs(interm)
	if interm.x < 0 and interm.y < 0 then
		if dist.x  < 0 then calc.x = -math.abs(calc.x) end
		if dist.y < 0 then calc.y = -math.abs(calc.y) end
		return true, calc
	end
	return false, calc
end

function min_x(vec)
	if math.abs(vec.x)  <  math.abs(vec.y) then
		return true
	else
		return false
	end
end

function halfs(obj)
	return {x = obj.width/2, y = obj.height/2}
end

function vec_abs(vec)
	return {x = math.abs(vec.x), y = math.abs(vec.y)}
end

function vec_sub(vec1, vec2)
	return {x = vec1.x - vec2.x, y = vec1.y - vec2.y}
end

function vec_sum(vec1, vec2)
	return {x = vec1.x + vec2.x,  y =  vec1.y + vec2.y}
end

function centre(box)
	return {x = box.x + box.width/2, y = box.y + box.height/2}
end

function box_collision(box1, box2)
	local left1 = box1.x
	local left2 = box2.x
	local right1 = box1.x + box1.width
	local right2 = box2.x + box2.width
	local top1 =  box1.y
	local top2 = box2.y
	local bottom1 = box1.y + box1.height
	local bottom2 = box2.y + box2.height
	
	if bottom1 < top2 then return false end
	if top1 > bottom2 then return false end
	if right1 < left2 then return false end
	if left1 > right2 then return false end
	
	return true
end

function printv(vec)
	print("x: " .. vec.x .. "y: " .. vec.y)
end

function values (t)
	local i = 0
	return function ()
		i = i + 1
		return t[i]
	end
end
