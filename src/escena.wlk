import wollok.game.*

class Scene
{
    const property image_path
    
    const property music_path

    method music() = game.sound(music_path)

    method show()
    {
        game.clear()
        game.boardGround(image_path)
        self.music().play()

        
    }

}