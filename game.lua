local composer = require "composer"
local scene = composer.newScene()
local sound = require "scripts.sound"
local physics = require "physics"
local OmNom = require "scripts.entities.OmNom"
local Candy = require "scripts.entities.Candy"
local Hook = require "scripts.entities.Hook"
----------------------------------------------------------------------------------
--
--      NOTE:
--
--      Code outside of listener functions (below) will only be executed once,
--      unless storyboard.removeScene() is called.
--
---------------------------------------------------------------------------------


-- local forward references should go here --


---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

function scene:create( event )
    print ('create game')
    local group = self.view

    physics.start()
    physics.setGravity( 0, 20 )
    -- physics.setDrawMode( "hybrid" )

    -- bg
    local background = display.newImageRect( "images/levelbg1.jpg", 640, 960 )
    background.x = halfX
    background.y = halfY
    group:insert(background)

    -- touch helper
    local lx, ly
    group:addEventListener( "touch", function (e)
        if e.phase == 'began' then
            lx, ly = e.x, e.y
            lx = lx - 1
            ly = ly - 1
            display.getCurrentStage():setFocus(group)
            group.hasFocus = true
        elseif group.hasFocus then
            if e.phase == 'moved' then
                local a = (e.x - lx)
                local b = (e.y - ly)
                local hyp = math.sqrt(a * a + b * b)
                local rect = display.newRoundedRect( lx, ly,
                    -- width
                    hyp,
                    -- height
                    math.max(hyp / 7, 10),
                    -- radius
                    2 )
                rect.rotation = math.atan2(e.y - ly, e.x - lx) * 180 / math.pi

                -- check intersections
                for i=1, #self.hooks do
                    self.hooks[i]:checkIntersections(rect)
                end

                transition.to(rect, {
                    alpha = 0,
                    time = 500,
                    onComplete = function ()
                        rect:removeSelf()
                    end
                })
                lx, ly = e.x, e.y
            elseif e.phase == 'ended' or e.phase == 'cancelled' then
                display.getCurrentStage():setFocus(nil)
                group.hasFocus = false
            end
        end

        -- create a candy on touch
        -- if e.phase == "ended" then
        --     local candy = Candy:new()
        --     candy.sprite.x = e.x
        --     candy.sprite.y = e.y
        -- end
    end )

    local reload = display.newCircle( group, X - 40, 40, 20 )
    reload:addEventListener( 'touch', function (e)
        if e.phase == 'began' then
            local currScene = composer.getSceneName( "current" )
            composer.removeScene(currScene)
            composer.gotoScene(currScene)
            return true
        end
    end )

    audio.stop()
    audio.play(sound.game, {
        loops = -1,
        fadeIn = 500
    })
end

-- Called when the scene's view does not exist:
function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then

        -- add world objects
        self.omnom = OmNom:new()
        self.omnom:translate(halfX, Y - 100)
        self.omnom:idleAnimation()

        self.hooks = {}

        -- candy :)
        self.candy = Candy:new()
        self.candy:setPosition(halfX + 200, 100)
        self.candy.sprite:addEventListener( 'candyIsDead', function(e)
            self.omnom:sadAnimation()
            timer.performWithDelay( 1000, function ()
                local currScene = composer.getSceneName( "current" )
                composer.removeScene(currScene)
                composer.gotoScene(currScene)
            end )
        end )


        local hook
        -- initially the candy is joined to this hook
        hook = Hook:new()
        hook:setPosition(halfX, 100)
        hook:join(self.candy)
        table.insert( self.hooks, hook )

        hook = Hook:new()
        hook:setPosition(X - 100, halfY - 100)
        table.insert( self.hooks, hook )

        hook = Hook:new()
        hook:setPosition(halfX, halfY)
        table.insert( self.hooks, hook )
    end
end

function scene:destroy( event )
    local group = self.view
    self.omnom:dispose()
    self.candy:dispose()
    for i=1, #self.hooks do
        self.hooks[i]:dispose()
    end
end

-- "create" event is dispatched if scene's view does not exist
-- "show" event is dispatched whenever scene transition has finished
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "destroy", scene )
return scene

