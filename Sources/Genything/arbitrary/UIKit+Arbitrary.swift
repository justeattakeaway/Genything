#if canImport(CoreGraphics)
import CoreGraphics
import Foundation

extension CGFloat: Arbitrary {
    public static var arbitrary: Gen<CGFloat> {
        Double.arbitrary.map { CGFloat($0) }
    }
}
#endif
