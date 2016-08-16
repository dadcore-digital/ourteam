io.stdout:setvbuf('no')
debug = true

function love.load(arg)
end

function love.update(dt)
	require('lovebird').update()
end

function love.draw()
    love.graphics.print('Hello World!', 400, 300)
end