/* Entities */

import wollok.game.*
import src.settings.*
import src.hitbox.*

class Entity
{
    var property position

    const property image

    const property hitbox

    method show()

    method hide()
}

class Spike inherits Entity(image = "imagen_reducida_8x_recortada.png", hitbox = new Hitbox(position = self.position(), width = 50, height = 30))
{
    override method show()
    {
        game.addVisual(self)
    }

    override method hide()
    {
        game.removeVisual(self)
    }

    method whenPlayerCollision(player)
    {
        gameSets.resetLevel()
    }

    method moveLeft(n)
    {
        position = position.left(n)
        hitbox.updatePosition(position)
    }

    method outOfScreen() = position.x() < 0
    
}

class Block inherits Entity
{
    
}

class Goal inherits Entity(image = "crespo.png", hitbox = new Hitbox(position = self.position(), width = 20, height = 20))
{
    override method show()
    {
        game.addVisual(self)
    }

    override method hide()
    {
        game.removeVisual(self)
    }

    method whenPlayerCollision(player)
    {
        game.sound("complete.mp3").play()
        player.win()
        game.schedule(2000, { gameSets.win() })
    }

    method moveLeft(n)
    {
        position = position.left(n)
        hitbox.updatePosition(position)
    }

    method outOfScreen() = position.x() < 0
}

object mainPlayer inherits Entity(position = game.center(), image = "imagen_reducida.png", hitbox = new Hitbox(position = self.position(), width = 50, height = 50))
{
    var isJumping = false

    const winnerMessage = "VAMOOOOOOOOOOOOOO GANEEEEEEE"

    var verticalSpeed = 0

    const jumpForce = 17

    const gravity = 1.8

    override method show()
    {
        game.addVisual(self)

        // game.whenCollideDo(self, { otroObjeto => otroObjeto.whenPlayerCollision(self) })
        
        keyboard.up().onPressDo({ self.jump() })
        keyboard.space().onPressDo({ self.jump() })

        game.onTick(50, "physics", { self.updatePhysics() })
    }

    override method hide()
    {
        game.removeTickEvent("physics")  
        game.removeVisual(self)
    }

    method updatePhysics()
    {
        verticalSpeed = verticalSpeed - gravity
        position = position.up(verticalSpeed)

        hitbox.updatePosition(position)

        if (position.y() <= gameSets.standard_height())
        {
            position = new Position(x = position.x(), y = gameSets.standard_height())
            verticalSpeed = 0
            isJumping = false

            hitbox.updatePosition(position)
        }

        self.checkCollisions()
    }

    method jump()
    {
        if (not isJumping)
        {
            verticalSpeed = jumpForce
            isJumping = true
        }
    }

    method die()
    {
        self.hide()

        position = new Position(x = gameSets.player_start_x(), y = gameSets.standard_height())

        game.sound("death.mp3").play()

        isJumping = false
        verticalSpeed = 0

        self.show()
    }

    method win()
    {
        game.say(self, winnerMessage)
    }

    method checkCollisions()
    {
        gameSets.obstacles().forEach({ obstacle =>
            if (self.hitbox().intersects(obstacle.hitbox()))
                obstacle.whenPlayerCollision(self)
        })
    }
}