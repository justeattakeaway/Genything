import Foundation

extension Generator {
    /// Returns: A generator which switches to the `next` generator when the `when` predicate returns true
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///    - when: Predicate signalling the change to the `next` generator
    ///
    /// - Returns: The generator
    func switchTo(
        _ nextGenerator: @escaping @autoclosure () -> AnyGenerator<T>,
        when: @escaping (T) -> Bool
    ) -> AnyGenerator<T> {
        var curr: AnyGenerator<T> = self.eraseToAnyGenerator()

        return AnyGenerator { ctx in
            var value = curr.next(ctx)
            if when(value) {
                curr = nextGenerator()
                value = curr.next(ctx)
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
        _ next: @escaping @autoclosure () -> AnyGenerator<R?>
    ) -> AnyGenerator<R> where T == R? {
        switchTo(next()) { $0 == nil }
            .map { $0! }
            .eraseToAnyGenerator()
    }

    /// Returns: A generator of unwrapped values which switches to the `next` generator whenever `nil` is produced
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///
    /// - Returns: The generator
    func switchUnwrap<R>(
        _ next: @escaping @autoclosure () -> AnyGenerator<R>
    ) -> AnyGenerator<R> where T == R? {
        switchTo(
            next()
                .map { value -> R? in value }
                .eraseToAnyGenerator()
        ) {
            $0 == nil
        }
            .map { $0! }
            .eraseToAnyGenerator()
    }
}
