// MARK: Combine - Zip

public extension Generator {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B>(_ other: B) -> AnyGenerator<(Self.T, B.T)> where B: Generator {
        Zip(self, other).eraseToAnyGenerator()
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, R>(_ other: B, transform: @escaping (Self.T, B.T) -> R) -> AnyGenerator<R>
    where B: Generator {
        zip(other).map(transform)
    }
}

public extension Generators {
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
    ) -> AnyGenerator<(A.T, B.T)> where A: Generator, B: Generator {
        a.zip(b)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First Generator
    ///    - b: Second Generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A Generator of tuple values
    static func zip<A, B, R>(
        _ a: A,
        _ b: B,
        transform: @escaping (A.T, B.T) -> R
    ) -> AnyGenerator<R> where A: Generator, B: Generator {
        a.zip(b, transform: transform)
    }
}

// MARK: Combine - Zip3

public extension Generator {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C>(_ b: B, _ c: C) -> AnyGenerator<(Self.T, B.T, C.T)> where B: Generator, C: Generator {
        Zip3(self, b, c).eraseToAnyGenerator()
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, R>(_ b: B, _ c: C, transform: @escaping (T, B.T, C.T) -> R) -> AnyGenerator<R>
    where B: Generator, C: Generator {
        zip(b, c).map(transform)
    }
}

public extension Generators {
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
    ) -> AnyGenerator<(A.T, B.T, C.T)> where A: Generator, B: Generator, C: Generator {
        a.zip(b, c)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First Generator
    ///    - b: Second Generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A Generator of tuple values
    static func zip<A, B, C, R>(
        _ a: A,
        _ b: B,
        _ c: C,
        transform: @escaping (A.T, B.T, C.T) -> R
    ) -> AnyGenerator<R> where A: Generator, B: Generator, C: Generator {
        a.zip(b, c, transform: transform)
    }
}

// MARK: Combine - Zip4

public extension Generator {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D>(_ b: B, _ c: C, _ d: D) -> AnyGenerator<(Self.T, B.T, C.T, D.T)>
    where B: Generator, C: Generator, D: Generator {
        Zip4(self, b, c, d).eraseToAnyGenerator()
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, R>(_ b: B, _ c: C, _ d: D, transform: @escaping (T, B.T, C.T, D.T) -> R) -> AnyGenerator<R>
    where B: Generator, C: Generator, D: Generator {
        zip(b, c, d).map(transform)
    }
}

public extension Generators {
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
    ) -> AnyGenerator<(A.T, B.T, C.T, D.T)>
    where A: Generator, B: Generator, C: Generator, D: Generator {
        Zip4(a, b, c, d).eraseToAnyGenerator()
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First Generator
    ///    - b: Second Generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A Generator of tuple values
    static func zip<A, B, C, D, R>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D,
        transform: @escaping (A.T, B.T, C.T, D.T) -> R
    ) -> AnyGenerator<R>
    where A: Generator, B: Generator, C: Generator, D: Generator {
        a.zip(b, c, d, transform: transform)
    }
}

public extension Generator {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, E>(_ b: B, _ c: C, _ d: D, _ e: E) -> AnyGenerator<(Self.T, B.T, C.T, D.T, E.T)>
    where B: Generator, C: Generator, D: Generator, E: Generator {
        Zip5(self, b, c, d, e).eraseToAnyGenerator()
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<B, C, D, E, R>(_ b: B, _ c: C, _ d: D, _ e: E, transform: @escaping (Self.T, B.T, C.T, D.T, E.T) -> R) -> AnyGenerator<R>
    where B: Generator, C: Generator, D: Generator, E: Generator {
        zip(b, c, d, e).map(transform)
    }
}

extension Generators {
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
    ) -> AnyGenerator<(A.T, B.T, C.T, D.T, E.T)>
    where A: Generator, B: Generator, C: Generator, D: Generator, E: Generator {
        a.zip(b, c, d, e)
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - a: First Generator
    ///    - b: Second Generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A Generator of tuple values
    static func zip<A, B, C, D, E, R>(
        _ a: A,
        _ b: B,
        _ c: C,
        _ d: D,
        _ e: E,
        transform: @escaping (A.T, B.T, C.T, D.T, E.T) -> R
    ) -> AnyGenerator<R>
    where A: Generator, B: Generator, C: Generator, D: Generator, E: Generator {
        a.zip(b, c, d, e, transform: transform)
    }
}

private struct Zip<A, B>: Generator where A: Generator, B: Generator {

    /// A Generator to zip.
    public let a: A

    /// Another Generator to zip.
    public let b: B

    /// Creates a Generator that applies the zip function to two upstream Generators.
    /// - Parameters:
    ///   - a: A Generator to zip.
    ///   - b: Another Generator to zip.
    public init(_ a: A, _ b: B) {
        self.a = a
        self.b = b
    }

    public func next(_ randomSource: RandomSource) -> (A.T, B.T) {
        (
            a.next(randomSource),
            b.next(randomSource)
        )
    }
}

private struct Zip3<A, B, C>: Generator where A: Generator,
                                               B: Generator,
                                               C: Generator
{

    /// A Generator to zip.
    public let a: A

    /// Another Generator to zip.
    public let b: B

    /// Another Generator to zip.
    public let c: C

    /// Creates a Generator that applies the zip function to two upstream Generators.
    /// - Parameters:
    ///   - a: A Generator to zip.
    ///   - b: Another Generator to zip.
    ///   - c: Another Generator to zip.
    public init(_ a: A, _ b: B, _ c: C) {
        self.a = a
        self.b = b
        self.c = c
    }


    public func next(_ randomSource: RandomSource) -> (A.T, B.T, C.T) {
        (
            a.next(randomSource),
            b.next(randomSource),
            c.next(randomSource)
        )
    }
}

private struct Zip4<A, B, C, D>: Generator
where A: Generator,
      B: Generator,
      C: Generator,
      D: Generator
{

    /// A Generator to zip.
    public let a: A

    /// Another Generator to zip.
    public let b: B

    /// Another Generator to zip.
    public let c: C

    /// Another Generator to zip.
    public let d: D

    /// Creates a Generator that applies the zip function to two upstream Generators.
    /// - Parameters:
    ///   - a: A Generator to zip.
    ///   - b: Another Generator to zip.
    ///   - c: Another Generator to zip.
    ///   - d: Another Generator to zip.
    public init(_ a: A, _ b: B, _ c: C, _ d: D) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
    }

    public func next(_ randomSource: RandomSource) -> (A.T, B.T, C.T, D.T) {
        (
            a.next(randomSource),
            b.next(randomSource),
            c.next(randomSource),
            d.next(randomSource)
        )
    }
}


private struct Zip5<A, B, C, D, E>: Generator
where A: Generator,
      B: Generator,
      C: Generator,
      D: Generator,
      E: Generator
{

    /// A Generator to zip.
    public let a: A

    /// Another Generator to zip.
    public let b: B

    /// Another Generator to zip.
    public let c: C

    /// Another Generator to zip.
    public let d: D

    /// Another Generator to zip.
    public let e: E

    /// Creates a Generator that applies the zip function to two upstream Generators.
    /// - Parameters:
    ///   - a: A Generator to zip.
    ///   - b: Another Generator to zip.
    ///   - c: Another Generator to zip.
    ///   - d: Another Generator to zip.
    ///   - e: Another Generator to zip.
    public init(_ a: A, _ b: B, _ c: C, _ d: D, _ e: E) {
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
    }

    public func next(_ randomSource: RandomSource) -> (A.T, B.T, C.T, D.T, E.T) {
        (
            a.next(randomSource),
            b.next(randomSource),
            c.next(randomSource),
            d.next(randomSource),
            e.next(randomSource)
        )
    }
}
