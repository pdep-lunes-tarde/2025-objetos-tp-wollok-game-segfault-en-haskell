/* Scene */

import src.entity.*
import wollok.game.*

class Scene
{
    const image_path

    const music

    const entities = new List()

    method show()
    {
        game.boardGround(image_path)
        mainPlayer.show()
        entities.forEach({ entity => entity.show() })
        music.play()
        music.volume(0.2)
    }

    method hide()
    {   
        music.stop()
        entities.forEach({ entity => entity.hide() })
        entities.clear()
    }

    method addEntity(new_entity)
    {
        game.addVisual(new_entity)
        entities.add(new_entity)
    }

    method playMusic()
    {
        music.play()
    }
}