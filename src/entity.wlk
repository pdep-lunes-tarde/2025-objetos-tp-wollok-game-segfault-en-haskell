import wollok.game.*

class Entity
{
    var property position

    const property image

    method show()

    method hide()
}

class Spike inherits Entity 
{
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

    override method show()
    {
        game.addVisual(self)

        game.onTick(10, "playerMove", { position = position.right(1) })

        // keyboard.up().onPressDo({
        //     game.onTick(100, "name", {
        //         position = position.up(1)})
        // })
        
        keyboard.up().onPressDo({ self.jump() })
        /*
        game.whenCollideDo(self, { otroObjeto =>
        if (otroObjeto.is(Spike))
            self.die()
        })
        */
        const posicionGanadora = new Position(x = game.width() * 0.5, y = self.position().y())
        game.onTick(10, "verificacion", {
            if (position.x() >= posicionGanadora.x())
                self.win()
        })
    }
    
    override method hide()
    {
        game.removeTickEvent("playerMove")
        game.removeTickEvent("jump")
        game.removeTickEvent("down")
        game.removeTickEvent("verificacion")
        
        game.removeVisual(self)
    }

    method jump()
{
    if (not isJumping)
    {
        isJumping = true
        const miliseconds = 1
        const time_jumping = 500
        const n = 2

        game.onTick(miliseconds, "jump", {
            position = position.up(n)
        })
        game.schedule(time_jumping, {
            game.removeTickEvent("jump")
            game.onTick(miliseconds, "down", {
            if (self.position().y() > game.height() / 4) position = position.down(n)
            })

            game.schedule(time_jumping, {
                game.removeTickEvent("down") 
                position = new Position(x = self.position().x(), y = game.height() / 4)
                isJumping = false
            })
        })
    }
}

    method die()
    {
        self.hide()
        position = new Position(x = 0,y = game.height() / 4)
        isJumping = false
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