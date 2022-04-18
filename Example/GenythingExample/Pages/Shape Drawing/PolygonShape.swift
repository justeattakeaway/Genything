import CoreGraphics
import Genything
import SwiftUI

struct PolygonShape: Shape, Identifiable {
    var id: UUID
    var sides: Double
    var scale: Double
    var color: Color
    var offset: CGFloat
    var xOffset: CGFloat

    var animatableData: AnimatablePair<Double, Double> {
        get { AnimatablePair(sides, scale) }
        set {
            sides = newValue.first
            scale = newValue.second
        }
    }

    func path(in rect: CGRect) -> Path {
        // hypotenuse
        let h = Double(min(rect.size.width, rect.size.height)) / 2.0 * scale

        // center
        let c = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)

        var path = Path()

        let extra: Int = sides != Double(Int(sides)) ? 1 : 0

        for i in 0 ..< Int(sides) + extra {
            let angle = (Double(i) * (360.0 / sides)) * (Double.pi / 180)

            // Calculate vertex
            let pt = CGPoint(x: c.x + CGFloat(cos(angle) * h), y: c.y + CGFloat(sin(angle) * h))

            if i == 0 {
                path.move(to: pt) // move to first vertex
            } else {
                path.addLine(to: pt) // draw line to next vertex
            }
        }

        path.closeSubpath()

        return path
    }
}
