extension StatefulGen {
    /// Returns: A generator which switches to the `other` generatable when the `when` predicate returns true
    ///
    /// - Parameters:
    ///    - other: Factory which produces the next generatable
    ///    - when: Predicate signalling the change to the `other` generator
    ///
    /// - Returns: The generator
    func switchTo(
        _ other: StatefulGen<T>,
        when: @escaping (T) -> Bool
    ) -> StatefulGen<T> {
        StatefulGen {
            var gen: Gen<T>!
            return Gen { ctx in
                if gen == nil {
                    gen = start()
                }
                var value = try gen.safe.generate(context: ctx)
                if when(value) {
                    gen = other.start()
                    value = try gen.safe.generate(context: ctx)
                }
                return value
            }
        }
    }

    /// Returns: A generator of unwrapped values which switches to the `other` generator whenever `nil` is produced
    ///
    /// - Parameters:
    ///    - other: Other generatable
    ///
    /// - Returns: The generator
    func switchUnwrap<R>(
        _ other: StatefulGen<R?>
    ) -> StatefulGen<R> where T == R? {
        switchTo(other) { $0 == nil }.map { $0! }
    }

    /// Returns: A generator of unwrapped values which switches to the `next` generator whenever `nil` is produced
    ///
    /// - Parameters:
    ///    - next: Factory which produces the next generator
    ///
    /// - Returns: The generator
    func switchUnwrap<R>(
        _ other: StatefulGen<R>
    ) -> StatefulGen<R> where T == R? {
        switchTo(
            other.map { value -> R? in value }
        ) { $0 == nil }.map { $0! }
    }
}
