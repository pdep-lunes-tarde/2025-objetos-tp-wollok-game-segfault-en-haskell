import wollok.game.*
import src.settings.*
import src.entity.*
import src.scene.*


class Level
{
    var running = false

    const levelDuration

    method show()
    {
        running = true
        game.onTick(levelDuration, "goal", { self.createGoal() })
    }

    method hide()
    {
        running = false
        game.removeTickEvent("goal")
        game.removeTickEvent("spawn")
    }

    method createSpike()
    {
        const newSpike = new Spike(position = new Position(x = game.width(), y = gameSets.standard_height()))
        gameSets.addEntity(newSpike)
    }

    method createGoal()
    {
        const finishLine = new Goal(position = new Position(x = game.width() * 1.5, y = gameSets.standard_height()))
        gameSets.addEntity(finishLine)
    }
}
class Level1 inherits Level(levelDuration = 9000)
{
    var num = 1

    override method show()
    {
        super()
        game.onTick(1500, "spawn", { self.createSpike() })
        game.schedule(levelDuration + 1000, { if (running) game.removeTickEvent("spawn") })
    }

    override method createSpike()
    {
        super()

        if (num % 3 == 0)
        {
            const otherSpike = new Spike(position = new Position(x = (game.width() * 1.05).round(), y = gameSets.standard_height()))
            gameSets.addEntity(otherSpike)
        }

        num += 1
    }
}

class Level2 inherits Level(levelDuration = 12000)
{
    var num = 1

    override method show()
    {
        super()
        game.onTick(1200, "spawn", { self.createSpike() }) 
        game.schedule(levelDuration + 1000, { if (running) game.removeTickEvent("spawn") })
    }

    override method createSpike()
    {
        super()

        if (num % 2 == 0)
        {
            const otherSpike = new Spike(position = new Position(x = (game.width() * 1.05).round(), y = gameSets.standard_height()))
            gameSets.addEntity(otherSpike)
        }

        num += 1
    }
}

class Level3 inherits Level(levelDuration = 20000)
{
    override method show()
    {
        super()

        game.onTick(1000, "spawn", { self.createSpike() }) 
        game.schedule(levelDuration + 1000, { if (running) game.removeTickEvent("spawn") })
    }

    override method createSpike()
    {
        super()

        const otherSpike = new Spike(position = new Position(x = (game.width() * 1.05).round(), y = gameSets.standard_height()))
        gameSets.addEntity(otherSpike)
    }
}

object level1
{
    method createLevel()
    {
        return new Level1()
    }

    method createScene()
    {
        game.schedule(1000, { game.say(mainPlayer, ":D")})
        return new Scene(image_path = "fondo.png",
            music = game.sound("stereo_maddness.mp3"),
            entities = gameSets.obstacles()
            )
    }
}



object level2
{
    method createLevel()
    {
        return new Level2()
    }

    method createScene()
    {
        game.schedule(1000, { game.say(mainPlayer, ":O")})
        return new Scene(image_path = "fondo.png",
            music = game.sound("back_on_track.mp3"),
            entities = gameSets.obstacles()
            )
    }
}

object level3
{
    method createLevel()
    {
        return new Level3()
    }

    method createScene()
    {
        game.schedule(1000, { game.say(mainPlayer, ":V")})
        return new Scene(image_path = "fondo.png",
                music = game.sound("blood.mp3"), 
                entities = gameSets.obstacles()
            )
    }
}