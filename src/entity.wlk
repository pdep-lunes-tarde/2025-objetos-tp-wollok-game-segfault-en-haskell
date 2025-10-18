import wollok.game.*
import src.tpIntegrador.*


class Entity
{
    var property position

    const property image

    method show()

    method hide()
}

class Spike inherits Entity 
{
    const property kill = true

    override method show()
    {
        game.addVisual(self)
    }

    override method hide()
    {
        game.removeVisual(self)
    }
}

class Player inherits Entity
{
    var isJumping = false
    const winnerMessage = "VAMOOOOOOOOOOOOOO GANEEEEEEE"

    var verticalSpeed = 0
    const jumpForce = 17
    const gravity = 1.8

    override method show()
    {
        game.addVisual(self)

        game.onTick(1, "playerMove", { position = position.right(1) })
        
        keyboard.up().onPressDo({ self.jump() })

        const posicionGanadora = new Position(x = game.width() * 0.5, y = self.position().y())
        game.onTick(10, "verificacion", {
            if (position.x() >= posicionGanadora.x())
                self.win()
        })

        game.onTick(50, "physics", { self.updatePhysics() })
    }
    
    override method hide()
    {
        game.removeTickEvent("playerMove")
        game.removeTickEvent("physics")
        game.removeTickEvent("verificacion")
        
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
        position = new Position(x = 0, y = gameSets.standard_height())
        isJumping = false
        verticalSpeed = 0
        self.show()
    }

    method win()
    {
        game.say(self, winnerMessage)
    }
}

class Block inherits Entity
{
    
}