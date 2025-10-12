import src.entity.*
import wollok.game.*

class Scene
{
    const property image_path
    const property music
    var property entities = new List()


    method show()
    {
        game.boardGround(image_path)
        game.schedule(1, {music.play()})

        entities.forEach({ entity => entity.show() })
    }

    method hide()
    {   
        music.stop()
        
        entities.forEach({ entity => entity.hide() })
    }

    method addEntity(new_entity)
    {
        game.addVisual(new_entity)
        entities.add(new_entity)
    }

}