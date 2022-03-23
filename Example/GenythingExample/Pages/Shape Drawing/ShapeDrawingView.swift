import Genything
import SwiftUI

private let colorGen: AnyGenerator<Color> = {
    var colors = [
        Color.red,
        Color.yellow,
        Color.pink,
        Color.purple,
        Color.black,
        Color.green,
    ]

    if #available(iOS 15.0, *) {
        colors.append(contentsOf: [
            Color.indigo,
            Color.cyan,
        ])
    }

    return colors.arbitrary
}()

private let polygonGen = Generators.compose {
    PolygonShape(
        id: UUID(),
        sides: $0((3 ... 8).arbitrary),
        scale: $0((0.3 ... 0.9).arbitrary),
        color: $0(colorGen),
        offset: CGFloat($0((-250.0 ... 250.0).arbitrary)),
        xOffset: CGFloat($0((-150.0 ... 150.0).arbitrary))
    )
}.expand(toSizeInRange: 6 ... 12)

private let randomSource = RandomSource(determinism: .random)

// MARK: - ShapeDrawingView

struct ShapeDrawingView: View {
    @State private var polygons: [PolygonShape] = polygonGen.next(randomSource)

    var body: some View {
        GeometryReader { _ in
            ForEach(polygons) { polygon in
                polygon
                    .fill(polygon.color)
                    .opacity(0.5)
                    .offset(x: polygon.xOffset, y: polygon.offset)
            }
        }.overlay(Button("Again") {
            polygons = polygonGen.next(randomSource)
        }.padding(), alignment: .bottom)
    }
}

// MARK: - ShapeDrawingView_Previews

struct ShapeDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDrawingView()
    }
}
