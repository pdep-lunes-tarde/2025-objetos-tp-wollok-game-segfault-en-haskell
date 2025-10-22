import wollok.game.*
import src.settings.*
import src.entity.*
import src.scene.*

const newSpike = new Spike(position = new Position(x = game.width(), y = self.standard_height()))

const otherSpike = new Spike(position = new Position(x = game.width() * 1.5, y = self.standard_height()))
        
const finishLine = new Goal(position = new Position(x = game.width() * 2, y = self.standard_height()))

const firstLevelEntities = [newSpike, otherSpike, finishLine]


class Level1
{
    method show()
    {
        const newSpike = new Spike(position = new Position(x = game.width(), y = gameSets.standard_height()))

        const otherSpike = new Spike(position = new Position(x = game.width() * 1.5, y = gameSets.standard_height()))
        
        const finishLine = new Goal(position = new Position(x = game.width() * 2, y = gameSets.standard_height()))

        gameSets.obstacles().add(newSpike)
        gameSets.obstacles().add(otherSpike)
        gameSets.obstacles().add(finishLine)
    }
}