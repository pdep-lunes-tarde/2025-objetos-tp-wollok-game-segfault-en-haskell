import src.level.*
/* Game settings */

import src.scene.*
import wollok.game.*
import src.entity.*

object gameSets
{
    var property player_start_x = null

    var property standard_height = null

    var scene = null

    const property obstacles = []

    const levelSpeed = 5

    var level = null

    var level_object = null

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
                obstacle.moveLeft(levelSpeed)
            })

            obstacles.forEach({ obstacle =>
                if (obstacle.outOfScreen())
                {
                    obstacle.hide()
                    obstacles.remove(obstacle)
                }
            })
        })

        mainPlayer.position(new Position(x = player_start_x, y = standard_height))

        keyboard.r().onPressDo({ self.resetLevel() })
    }

    method createObstacles()
    {
        if (level == 1)
            level_object = new Level1()
        else if (level == 2)
        {

        }
        else
        {
            
        }
        
        
        level_object.show()
    }

    method createScene()
    {
        if (level == 1)
        {
            scene = new Scene(image_path = "fondo.png",
            music = game.sound("stereo_maddness.mp3"),
            entities = self.obstacles()
            )
        }
        else if (level == 2)
        {

        }
        else
        {

        }

        scene.show()
    }

    method resetLevel()
    {
        scene.hide()

        mainPlayer.die()

        if (level_object != null)
            level_object.hide()

        self.createObstacles()

        obstacles.forEach({ obstacle =>
            obstacle.show()
        })

        game.schedule(100, { scene.playMusic() })
    }
    
    method startGame(level_)
    {
        level = level_
    
        self.createObstacles()
        self.createScene()
    }

    method win()
    {
        mainPlayer.hide()
        scene.hide()
        level_object.hide()
        menu.show()
    }

    method addEntity(newEntity)
    {
        scene.addEntity(newEntity)
    }
}

object menu
{
    const menu_text = "dale pibe selecciona un nivel del 1-3"

    const property image = "messi.png"

    var property position = new Position()

    const property image_path = "fondo.png"

    const property music = game.sound("musica_menu.mp3")

    method show()
    {
        position = game.center()
        game.addVisual(self)
        game.boardGround(image_path)
        music.play()
        game.onTick(30000, "menu_music", {
            music.stop()
            game.schedule(100, {
                music.play()
                music.volume(0.2)
                })
            })
        music.volume(0.2)

        game.say(self, menu_text)
        game.onTick(1000, "menu_text", { game.say(self, menu_text) })

        keyboard.num1().onPressDo({ self.selectLevel(1)})
    }

    method hide()
    {
        music.stop()
        game.removeTickEvent("menu_text")
        game.removeTickEvent("menu_music")
        game.removeVisual(self)
    }

    method selectLevel(level)
    {
        self.hide()
        gameSets.startGame(level)
    }
}