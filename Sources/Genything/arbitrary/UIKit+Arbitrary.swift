#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGFloat: Arbitrary {
    /// A generator of `CGFloat`s
    public static var arbitrary: AnyGenerator<CGFloat> {
        Double.arbitrary
            .map { CGFloat($0) }
            .eraseToAnyGenerator()
    }
}

extension CGVector: Arbitrary {
    /// A generator of `CGVector`s
    public static var arbitrary: AnyGenerator<CGVector> {
        AnyGenerator.compose {
            let cgFloatGen: () -> CGFloat = $0.arbitrary
            return CGVector(dx: cgFloatGen(), dy: cgFloatGen())
        }
    }
}
#endif
