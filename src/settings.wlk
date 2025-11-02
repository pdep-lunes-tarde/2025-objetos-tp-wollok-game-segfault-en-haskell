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

    const property levelSpeed = 5 // hecho property por TESTS

    var property level = null // hecho property por TESTS

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
        keyboard.m().onPressDo({ self.returnToMenu()})
    }

    method createObstacles()
    {
        level_object = level.createLevel()
        level_object.show()
    }

    method createScene()
    {
        scene = level.createScene()
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

    method returnToMenu()
    {
        if (level_object != null)
        {
            level_object.hide()
            level_object = null
        }
        
        if (scene != null)
        {
            scene.hide()
            scene = null
        }

        mainPlayer.hide()

        menu.show()
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

        keyboard.num1().onPressDo({ self.selectLevel(level1) })
        keyboard.num2().onPressDo({ self.selectLevel(level2) })
        keyboard.num3().onPressDo({ self.selectLevel(level3) })
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