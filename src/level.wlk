import wollok.game.*
import src.settings.*
import src.entity.*
import src.scene.*

class Level1
{
    var running = false

    var num = 1

    method show()
    {
        running = true
        game.onTick(1500, "spawn", { self.createSpike() })
        game.onTick(9000, "goal", { self.createGoal() })
        game.schedule(10000, { if (running) game.removeTickEvent("spawn") })
    }

    method hide()
    {
        running = false
        game.removeTickEvent("spawn")
        game.removeTickEvent("goal")
    }

    method createSpike()
    {
        const newSpike = new Spike(position = new Position(x = game.width(), y = gameSets.standard_height()))
        gameSets.addEntity(newSpike)

        if (num % 3 == 0)
        {
            const otherSpike = new Spike(position = new Position(x = (game.width() * 1.05).round(), y = gameSets.standard_height()))
            gameSets.addEntity(otherSpike)
        }

        num += 1
    }

    method createGoal()
    {
        const finishLine = new Goal(position = new Position(x = game.width() * 2, y = gameSets.standard_height()))
        gameSets.addEntity(finishLine)
    }
}