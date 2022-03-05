import Foundation

extension Gen {
    /// Returns: A generator which switches to the `next` generator when the `when` predicate returns true
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///    - when: Predicate signalling the change to the `next` generator
    ///
    /// - Returns: The generator
    func switchTo(
        _ next: @escaping @autoclosure () -> Gen<T>,
        when: @escaping (T) -> Bool
    ) -> Gen<T> {
        var curr: Gen<T> = self

        return Gen { ctx in
            var value = curr.generate(context: ctx)
            if when(value) {
                curr = next()
                value = curr.generate(context: ctx)
            }
            return value
        }
    }

    /// Returns: A generator of unwrapped values which switches to the `next` generator whenever `nil` is produced
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///
    /// - Returns: The generator
    func switchUnwrap<R>(
        _ next: @escaping @autoclosure () -> Gen<R?>
    ) -> Gen<R> where T == R? {
        switchTo(next()) { $0 == nil }.map { $0! }
    }

    /// Returns: A generator of unwrapped values which switches to the `next` generator whenever `nil` is produced
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///
    /// - Returns: The generator
    func switchUnwrap<R>(
        _ next: @escaping @autoclosure () -> Gen<R>
    ) -> Gen<R> where T == R? {
        switchTo(
            next().map { value -> R? in value }
        ) { $0 == nil }.map { $0! }
    }
}
