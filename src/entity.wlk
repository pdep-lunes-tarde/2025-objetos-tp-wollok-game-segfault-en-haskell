import wollok.game.*

class Entity
{
    var property position

    const property image

    method show()

    method hide()
}


class Player inherits Entity
{
    override method show()
    {
        game.addVisual(self)

        game.onTick(100, "playerMove", { position = position.right(1) })
    }
    
    override method hide()
    {
        game.removeTickEvent("playerMove")
        
        game.removeVisual(self)
    }
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

class Block inherits Entity
{
    
}