// MARK: Combine - Zip

public extension Generatable {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<A>(with other: A) -> Generatables.Zip<Self, A> where A: Generatable {
        Generatables.Zip(self, other)
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<A, R>(with other: A, transform: @escaping (T, A.T) -> R) -> Generatables.Map<(Self.T, A.T), R>
    where A: Generatable {
        self.zip(with: other).map(transform)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///
    /// - Returns: A generator of Tuples
    static func zip<A, B>(
        _ a: A,
        _ b: B
    ) -> Generatables.Zip<A, B> where A: Generatable, B: Generatable {
        Generatables.Zip(a, b)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First generatable
    ///    - b: Second generatable
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generatable of tuple values
    static func zip<A, B>(
        _ a: A,
        _ b: B,
        transform: @escaping (A.T, B.T) -> T
    ) -> Generatables.Zip<A, B> where A: Generatable, B: Generatable {
        a.zip(with: b, transform: transform)
    }
}

// MARK: Combine - Zip3

public extension Generatable {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C>(_ b: B, _ c: C) -> Generatables.Zip3<Self, B, C> where B: Generatable, C: Generatable {
        Generatables.Zip3(self, b, c)
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, R>(_ b: B, _ c: C, transform: @escaping (T, B.T, C.T) -> R) -> Generatables.Zip3<Self.T, B.T, C.T>
    where B: Generatable, C: Generatable {
        zip(b, c).map(transform)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///
    /// - Returns: A generator of Tuples
    static func zip<A, B, C>(
        _ a: A,
        _ b: B,
        _ c: C
    ) -> Generatables.Zip3<A, B, C> where A: Generatable, B: Generatable, C: Generatable {
        Generatables.Zip3(a, b, c)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First generatable
    ///    - b: Second generatable
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generatable of tuple values
    static func zip<A, B, C>(
        _ a: A,
        _ b: B,
        _ c: C,
        transform: @escaping (A.T, B.T, C.T) -> T
    ) -> Generatables.Zip3<A, B, C> where A: Generatable, B: Generatable, C: Generatable {
        a.zip(b, c, transform: transform)
    }
}

// MARK: Combine - Zip4

public extension Gen {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D>(_ b: B, _ c: C, _ d: D) -> Generatables.Zip3<Self, B, C>
    where B: Generatable, C: Generatable, D: Generatable {
        Generatables.Zip4(self, b, c, d)
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, R>(_ b: B, _ c: C, _ d: D, transform: @escaping (T, B.T, C.T, D.T) -> R) -> Generatables.Zip4<Self.T, B.T, C.T, D.T>
    where B: Generatable, C: Generatable, D: Generatable {
        zip(b, c, d).map(transform)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///
    /// - Returns: A generator of Tuples
    static func zip<A, B, C, D>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D
    ) -> Generatables.Zip4<A, B, C, D> where A: Generatable, B: Generatable, C: Generatable, D: Generatable {
        Generatables.Zip4(a, b, c, d)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First generatable
    ///    - b: Second generatable
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generatable of tuple values
    static func zip<A, B, C, D>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D,
        transform: @escaping (A.T, B.T, C.T, D.T) -> T
    ) -> Generatables.Zip4<A, B, C, D> where A: Generatable, B: Generatable, C: Generatable, D: Generatable {
        a.zip(b, c, d, transform: transform)
    }
}

public extension Gen {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, E>(_ b: B, _ c: C, _ d: D, _ e: E) -> Generatables.Zip5<Self, B, C, D, E>
    where B: Generatable, C: Generatable, D: Generatable, E: Generatable {
        Generatables.Zip5(self, b, c, d e)
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, E, R>(_ b: B, _ c: C, _ d: D, _ e: E, transform: @escaping (T, B.T, C.T, D.T, E.T) -> R) -> Generatables.Zip5<Self.T, B.T, C.T, D.T, E.T>
    where B: Generatable, C: Generatable, D: Generatable, E: Generatable {
        zip(b, c, d, e).map(transform)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///
    /// - Returns: A generator of Tuples
    static func zip<A, B, C, D, E>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D,
        _ e: E
    ) -> Generatables.Zip5<A, B, C, D, E>
    where A: Generatable, B: Generatable, C: Generatable, D: Generatable, E: Generatable {
        Generatables.Zip5(a, b, c, d, e)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First generatable
    ///    - b: Second generatable
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generatable of tuple values
    static func zip<A, B, C, D, E>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D,
        _ e: E,
        transform: @escaping (A.T, B.T, C.T, D.T, E.T) -> T
    ) -> Generatables.Zip5<A, B, C, D, E>
    where A: Generatable, B: Generatable, C: Generatable, D: Generatable, E: Generatable {
        a.zip(b, c, d, e, transform: transform)
    }
}

extension Generatables {
    public struct Zip<A, B>: Generatable where A: Generatable, B: Generatable, A.T == B.T {

        /// A generatable to zip.
        public let a: A

        /// Another generatable to zip.
        public let b: B

        /// Creates a generatable that applies the zip function to two upstream generatables.
        /// - Parameters:
        ///   - a: A generatable to zip.
        ///   - b: Another generatable to zip.
        public init(_ a: A, _ b: B) {
            self.a = a
            self.b = b
        }

        public func start() -> Gen<(A.T, B.T)> {
            let gens = (a.start(), b.start())
            return Gen { ctx in
                (gens.0.generate(context: ctx), gens.1.generate(context: ctx))
            }
        }
    }

    public struct Zip3<A, B, C>: Generatable where A: Generatable,
                                                   B: Generatable,
                                                   C: Generatable,
                                                   A.T == B.T,
                                                   B.T == C.T
    {

        /// A generatable to zip.
        public let a: A

        /// Another generatable to zip.
        public let b: B

        /// Another generatable to zip.
        public let c: C

        /// Creates a generatable that applies the zip function to two upstream generatables.
        /// - Parameters:
        ///   - a: A generatable to zip.
        ///   - b: Another generatable to zip.
        ///   - c: Another generatable to zip.
        public init(_ a: A, _ b: B, _ c: C) {
            self.a = a
            self.b = b
            self.c = c
        }

        public func start() -> Gen<(A.T, B.T, C.T)> {
            let gens = (a.start(), b.start(), c.start())
            return Gen { ctx in
                (
                    gens.0.generate(context: ctx),
                    gens.1.generate(context: ctx),
                    gens.2.generate(context: ctx)
                )
            }
        }
    }

    public struct Zip4<A, B, C, D>: Generatable
    where A: Generatable,
          B: Generatable, A.T == B.T,
          C: Generatable, B.T == C.T,
          D: Generatable, C.T == D.T
    {

        /// A generatable to zip.
        public let a: A

        /// Another generatable to zip.
        public let b: B

        /// Another generatable to zip.
        public let c: C

        /// Another generatable to zip.
        public let d: D

        /// Creates a generatable that applies the zip function to two upstream generatables.
        /// - Parameters:
        ///   - a: A generatable to zip.
        ///   - b: Another generatable to zip.
        ///   - c: Another generatable to zip.
        ///   - d: Another generatable to zip.
        public init(_ a: A, _ b: B, _ c: C, _ d: D) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
        }

        public func start() -> Gen<(A.T, B.T, C.T, D.T)> {
            let gens = (a.start(), b.start(), c.start(), d.start())
            return Gen { ctx in
                (
                    gens.0.generate(context: ctx),
                    gens.1.generate(context: ctx),
                    gens.2.generate(context: ctx),
                    gens.4.generate(context: ctx)
                )
            }
        }
    }


    public struct Zip5<A, B, C, D, E>: Generatable
    where A: Generatable,
          B: Generatable, A.T == B.T,
          C: Generatable, B.T == C.T,
          D: Generatable, C.T == D.T,
          E: Generatable, D.T == E.T
    {

        /// A generatable to zip.
        public let a: A

        /// Another generatable to zip.
        public let b: B

        /// Another generatable to zip.
        public let c: C

        /// Another generatable to zip.
        public let d: D

        /// Another generatable to zip.
        public let e: E

        /// Creates a generatable that applies the zip function to two upstream generatables.
        /// - Parameters:
        ///   - a: A generatable to zip.
        ///   - b: Another generatable to zip.
        ///   - c: Another generatable to zip.
        ///   - d: Another generatable to zip.
        ///   - e: Another generatable to zip.
        public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) {
            self.a = a
            self.b = b
            self.c = c
            self.d = d
            self.e = e
        }

        public func start() -> Gen<(A.T, B.T, C.T, D.T)> {
            let gens = (a.start(), b.start(), c.start(), d.start(), e.start())
            return Gen { ctx in
                (
                    gens.0.generate(context: ctx),
                    gens.1.generate(context: ctx),
                    gens.2.generate(context: ctx),
                    gens.4.generate(context: ctx),
                    gens.5.generate(context: ctx)
                )
            }
        }
    }
}
