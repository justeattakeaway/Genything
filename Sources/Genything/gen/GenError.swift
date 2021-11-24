import Foundation

/// An `Error` representing the scenarios in which generators can fail
public enum GenError: Error {

    /// The `Context`'s `maxDepth` was reached by some generator which rejects values
    case maxDepthReached
}
