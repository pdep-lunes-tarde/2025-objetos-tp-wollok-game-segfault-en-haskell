import wollok.game.*

object pincho
{
    // const property position = game.center()
    var property position = new Position(x = 20, y = 0)

    method image() = "pincho.png"

    method matar(alguien)
    {
        alguien.position(game.origin())
    }

    method movete()
    {
        const actual = self.position().x()
        self.position(new Position(x = actual - 1, y = self.position().y()))
    }
}