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


    func replaceNil<Other>(with other: Other) -> Generatables.Replace<Self, Other> where T == Other? {
        Generatables.Replace(self, other) {
            $0 == nil
        }
    }
}

extension Generatables {
    struct Replace<A, B>: Generatable where A: Generatable, B: Generatable, A.T == B.T {
        let a: A
        let b: B
        let predicate: (A.T) -> Bool

        init(_ a: A, _ b: B, predicate: @escaping (A.T) -> Bool) {
            self.a = a
            self.b = b
            self.predicate = predicate
        }

        func start() -> Gen<A.T> {
            var isReplaced: Bool = false

            let aGen = a.start()
            let bGen = b.start()

            return Gen { ctx in
                guard !isReplaced else {
                    return bGen.generate(context: ctx)
                }

                let aValue = aGen.generate(context: ctx)
                if !predicate(aValue) {
                    return aValue
                } else {
                    isReplaced = true
                    return bGen.generate(context: ctx)
                }
            }
        }
    }
}
