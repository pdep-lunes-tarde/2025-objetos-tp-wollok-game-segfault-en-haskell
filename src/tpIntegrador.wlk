import src.scene.Scene
import src.entity.Spike
import src.entity.Player
import wollok.game.*

object gameSets
{
    var property standard_height = null

    var property player = null

    const property obstacles = []

    method initializeGame()
    {
        game.cellSize(1)
        game.width(1280)
        game.height(720)
        game.title("Engineer Dash")

        standard_height = game.height() / 4

        game.start()
    }

    method createPlayer()
    {
        player = new Player(position = new Position(x = 0, y = standard_height), image = "imagen_reducida.png")

        game.whenCollideDo(self.player(), { otroObjeto =>
            if (otroObjeto.kill()) self.player().die()
    })
    }

    method createObstacles()
    {
        const newSpike = new Spike(position = new Position(x = game.width() / 4, y = self.standard_height()),
            image = "imagen_reducida_8x_recortada.png")

        const otherSpike = new Spike(position = new Position(x = game.width() / 3, y = self.standard_height()),
            image = "imagen_reducida_8x_recortada.png")

        obstacles.add(newSpike)
        obstacles.add(otherSpike)
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

    
}