import Foundation

// MARK: Build

public extension Gen {
    /// Returns: A generator which produces values from the provided collection (in order) or `nil` if the collection becomes exhausted
    ///
    /// - Parameters:
    ///    - collection: Collection of values which will be produced in order
    ///
    /// - Returns: The generator
    static func iterate<C: Collection>(_ collection: C) -> Gen<T?> where C.Element == T {
        var i = collection.startIndex
        return Gen<T?> { _ in
            if i < collection.endIndex {
                defer {
                    collection.formIndex(after: &i)
                }
                return collection[i]
            } else {
                return nil
            }
        }
    }
}
