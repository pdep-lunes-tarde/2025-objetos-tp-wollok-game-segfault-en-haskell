/* Game settings */

import src.scene.*
import wollok.game.*
import src.entity.*

object gameSets
{
    var property standard_height = null

    var property player = null

    var property scene = null

    const property obstacles = []

    const property levelSpeed = 5

    var property player_start_x = null

    var property level = null

    method initializeGame(cell_size, width, height)
    {
        game.cellSize(cell_size)
        game.width(width)
        game.height(height)
        game.title("Engineer Dash")

        standard_height = game.height() / 4
        player_start_x = game.width() / 4

        game.start()

        game.onTick(10, "levelScroll", {
            obstacles.forEach({ obstacle =>
                obstacle.position(obstacle.position().left(levelSpeed))
            })

            const obstaclesToRemove = obstacles.filter({ obstacle => obstacle.position().x() < 0 })
            obstaclesToRemove.forEach({ obstacle =>
                obstacle.hide()
                obstacles.remove(obstacle)
            })
        })
    }

    method createPlayer()
    {
        player = new Player(position = new Position(x = self.player_start_x(), y = standard_height), image = "imagen_reducida.png")

        game.whenCollideDo(self.player(), { otroObjeto =>  
            otroObjeto.whenPlayerCollision(player)
        })
        keyboard.r().onPressDo({ self.resetLevel() })
    }

    method createObstacles()
    {
        if (level == 1)
        {
            const newSpike = new Spike(position = new Position(x = game.width(), y = self.standard_height()))

            const otherSpike = new Spike(position = new Position(x = game.width() * 1.5, y = self.standard_height()))
        
            const finishLine = new Goal(position = new Position(x = game.width() * 2, y = self.standard_height()))

            obstacles.add(newSpike)
            obstacles.add(otherSpike)
            obstacles.add(finishLine)
        }
        
    }

    method createScene()
    {
        if (level == 1)
        {
            scene = new Scene(image_path = "fondo.png",
            music = game.sound("stereo_maddness.mp3"),
            player = self.player(),
            entities = self.obstacles()
            )
        }   

        scene.show()
    }

    method resetLevel()
    {
        scene.hide()

        player.die()

        self.createObstacles()

        obstacles.forEach({ obstacle =>
            obstacle.show()
        })

        game.schedule(100, { scene.playMusic() })
    }
    
    method startGame(level_)
    {
        level = level_

        if (player == null)
                self.createPlayer()
    
        self.createObstacles()
        self.createScene()
    }
}

object menu
{
    const property image_path = "fondo.png"

    const property music = game.sound("musica_menu.mp3")

    method show()
    {
        game.boardGround(image_path)
        music.play()
        music.volume(0.2)

        keyboard.num1().onPressDo({ self.selectLevel(1)})
    }

    method hide()
    {
        music.stop()
    }

    method selectLevel(level)
    {
        self.hide()
        gameSets.startGame(level)
    }
}