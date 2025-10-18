import src.scene.*
import wollok.game.*
import src.entity.*

object gameSets
{
    var property standard_height = null

    var property player = null

    const property obstacles = []

    const property levelSpeed = 5

    var property player_start_x = null

    method initializeGame()
    {
        game.cellSize(1)
        game.width(1280)
        game.height(720)
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
            try
                if (otroObjeto.kill())
                    self.resetLevel()  
            catch e {}

            try
                if (otroObjeto.isGoal())
                    self.player().win()
            catch e {}
    })
    }

    method createObstacles()
    {
        const newSpike = new Spike(position = new Position(x = game.width(), y = self.standard_height()),
            image = "imagen_reducida_8x_recortada.png")

        const otherSpike = new Spike(position = new Position(x = game.width() * 1.2, y = self.standard_height()),
            image = "imagen_reducida_8x_recortada.png")
        
        const finishLine = new Goal(position = new Position(x = game.width() * 2, y = self.standard_height()),
            image = "crespo.png")

        obstacles.add(newSpike)
        obstacles.add(otherSpike)
        obstacles.add(finishLine)
    }

    method createScene()
    {
        const scene = new Scene(image_path = "fondo.png",
        music = game.sound("stereo_maddness.mp3"),
        player = self.player(),
        entities = self.obstacles()
        )

        scene.show()
    }

    method resetLevel()
    {
        player.die()

        obstacles.forEach({ obstacle =>
            obstacle.hide()
        })
        obstacles.clear()

        self.createObstacles()

        obstacles.forEach({ obstacle =>
            obstacle.show()
        })
    }
    
}