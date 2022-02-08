import Foundation

/// Combines Gen member lookup with the "safe" extensions
public struct SafeGen<T> {
    /// The base Gen instance which has been enhanced by `safe` functionality
    let base: Gen<T>
    /// Creates extensions with base object.
    ///
    /// - parameter base: Base object.
    init(_ base: Gen<T>) {
        self.base = base
    }
}

public extension SafeGen {
    var unsafe: Gen<T> {
        base
    }
}

public extension Gen {
    /// Namespacing for safe extension functions for `Gen`
    var safe: SafeGen<T> {
        SafeGen(self)
    }
}
