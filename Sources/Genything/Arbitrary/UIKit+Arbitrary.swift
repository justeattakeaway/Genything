#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGFloat: ArbitraryGeneratable {
    /// A generator of `CGFloat`s
    public static var arbitrary: AnyGenerator<CGFloat> {
        Double.arbitrary
            .map { CGFloat($0) }
    }
}

extension CGVector: ArbitraryGeneratable {
    /// A generator of `CGVector`s
    public static var arbitrary: AnyGenerator<CGVector> {
        Generators.compose {
            let cgFloatGen: () -> CGFloat = $0.arbitrary
            return CGVector(dx: cgFloatGen(), dy: cgFloatGen())
        }
    }
}
#endif
