import Foundation

public protocol Arbitrary {
    /**
     * Returns a generator for this type
     */
    static var arbitrary : Gen<Self> { get }
}
