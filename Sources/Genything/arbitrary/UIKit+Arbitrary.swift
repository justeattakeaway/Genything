#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGFloat: Arbitrary {
    /// A generator of `CGFloat`s
    public static var arbitrary: Gen<CGFloat> {
        Double.arbitrary.map { CGFloat($0) }
    }
}

extension CGVector: Arbitrary {
    /// A generator of `CGVector`s
    public static var arbitrary: Gen<CGVector> {
        Gen.compose {
            let cgFloatGen: () -> CGFloat = $0.arbitrary
            return CGVector(dx: cgFloatGen(), dy: cgFloatGen())
        }
    }
}
#endif
