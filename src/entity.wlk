/* Entities */

import wollok.game.*
import src.settings.*



class Entity
{
    var property position

    const property image

    method show()

    method hide()
}

class Spike inherits Entity(image = "imagen_reducida_8x_recortada.png")
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
    }

    method outOfScreen() = position.x() < 0
    
}

class Block inherits Entity
{
    
}

class Goal inherits Entity(image = "crespo.png")
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
        player.win()
    }

    method moveLeft(n)
    {
        position = position.left(n)
    }

    method outOfScreen() = position.x() < 0
}

object mainPlayer inherits Entity(position = new Position(x = game.height() / 4, y = game.width() / 4), image = "imagen_reducida.png")
{
    var isJumping = false

    const winnerMessage = "VAMOOOOOOOOOOOOOO GANEEEEEEE"

    var verticalSpeed = 0

    const jumpForce = 17

    const gravity = 1.8

    override method show()
    {
        game.addVisual(self)

        game.whenCollideDo(self, { otroObjeto =>  otroObjeto.whenPlayerCollision(self) })
        
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

        if (position.y() <= gameSets.standard_height())
        {
            position = new Position(x = position.x(), y = gameSets.standard_height())
            verticalSpeed = 0
            isJumping = false
        }
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
}