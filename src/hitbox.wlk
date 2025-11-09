import wollok.game.*
import src.settings.*

class Hitbox
{
    var property position

    var property width

    var property height

    method updatePosition(newEntityPosition)
    {
        position = newEntityPosition
    }

    /*
     * Lógica de colisión AABB (Axis-Aligned Bounding Box).
     * Devuelve true si este hitbox se superpone con 'other'.
     */
    method intersects(other)
    {
        return (
            position.x() < other.position().x() + other.width() &&
            position.x() + width > other.position().x() &&
            position.y() < other.position().y() + other.height() &&
            position.y() + height > other.position().y()
        )
    }
}