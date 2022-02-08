import Foundation

/// Wrapper to namespace safe (throwing) extension functions for `Gen`
public struct SafeGen<T> {
    /// The base Gen instance
    fileprivate let base: Gen<T>

    /// Initializes a `SafeGen` wrapping `base`
    fileprivate init(_ base: Gen<T>) {
        self.base = base
    }
}

public extension SafeGen {
    /// Reverts back to a standard `Gen`
    var unsafe: Gen<T> {
        base
    }
}

public extension Gen {
    /// Converts the `Gen` to the `SafeGen` wrapper
    var safe: SafeGen<T> {
        SafeGen(self)
    }
}
