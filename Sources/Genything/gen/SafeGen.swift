import Foundation

/// Combines Gen member lookup with the "safe" extensions
@dynamicMemberLookup
public struct SafeGen<T> {
    public let base: Gen<T>
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    public init(_ base: Gen<T>) {
        self.base = base
    }

    subscript<Property>(dynamicMember keyPath: KeyPath<Gen<T>, Property>) -> Property {
        return base[keyPath: keyPath]
    }
}

public extension Gen {
    /// Namespacing for safe static extension `Gen`
    static var safe: SafeGen<T>.Type {
        get { SafeGen<T>.self }
    }
    /// Namespacing for safe extension functions for `Gen`
    var safe: SafeGen<T> {
        get { SafeGen(self) }
    }
}
