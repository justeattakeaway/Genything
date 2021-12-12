import Foundation

/// Combines Gen member lookup with the "safe" extensions
@dynamicMemberLookup
public struct SafeGen<T> {
    /// The base Gen instance which has been enhanced by `safe` functionality
    let base: Gen<T>
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    init(_ base: Gen<T>) {
        self.base = base
    }

    /// Enhances `SafeGen` to include the members of the base `Gen`
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
