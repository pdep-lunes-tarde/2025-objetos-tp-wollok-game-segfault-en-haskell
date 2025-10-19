/* Scene */

import src.entity.*
import wollok.game.*

class Scene
{
    const property image_path

    const property music

    const property player

    var property entities = new List()

    method show()
    {
        game.boardGround(image_path)
        player.show()
        entities.forEach({ entity => entity.show() })
        music.shouldLoop(true)
        game.schedule(0, { music.play() })
        music.volume(0.2)
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