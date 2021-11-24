import SwiftUI
import Genything

private let colorGen: Gen<Color> = {
    var colors = [
        Color.red,
        Color.yellow,
        Color.pink,
        Color.purple,
        Color.black,
        Color.green
    ]

    if #available(iOS 15.0, *) {
        colors.append(contentsOf: [
            Color.indigo,
            Color.cyan
        ])
    }

    return Gen.of(colors)
}()

private let polygonGen = Gen<PolygonShape>.compose {
    PolygonShape(
            id: UUID(),
            sides: $0.generate(Gen.from(3...8)),
            scale: $0.generate(Gen.from(0.3...0.9)),
            color: $0.generate(colorGen),
            offset: CGFloat($0.generate(Gen.from(-250.0...250.0))),
            xOffset:CGFloat($0.generate(Gen.from(-150.0...150.0)))
        )
}.expand(toSizeInRange: 6...12)

struct ShapeDrawingView: View {
    @State private var polygons: [PolygonShape] = polygonGen.sample()

    var body: some View {
        GeometryReader { geometry in
            ForEach (polygons) { polygon in
                polygon
                    .fill(polygon.color)
                    .opacity(0.5)
                    .offset(x: polygon.xOffset, y: polygon.offset)
            }
        }.overlay(Button("Again") {
            polygons = polygonGen.sample()
        }.padding(), alignment: .bottom)
    }
}

struct ShapeDrawingView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeDrawingView()
    }
}
