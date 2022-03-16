extension Bool: Arbitrary {
    /// A generator of arbitrary `Bool`eans
    public static var arbitrary: AnyGeneratable<Bool> {
        Gen { ctx in
            Bool.random(using: &ctx.rng)
        }
        .eraseToAnyGeneratable()
    }
}

extension Double: Arbitrary {
    /// A generator of arbitrary `Doubles`s
    public static var arbitrary: AnyGeneratable<Double> {
        Gen.from(Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
            .withEdgeCases(
                Gen.of([.leastNormalMagnitude, -1.0, -0.0, 0.0, 1.0, .greatestFiniteMagnitude])
            )
            .eraseToAnyGeneratable()
    }
}

extension Int: Arbitrary {
    /// A generator of arbitrary `Int`s
    public static var arbitrary: AnyGeneratable<Int> {
        Gen.from(Int.min...Int.max)
            .withEdgeCases(Gen.of([Int.min, -1, 0, 1, Int.max]))
            .eraseToAnyGeneratable()
    }
}

extension UInt: Arbitrary {
    /// A generator of arbitrary `UInt`s
    public static var arbitrary: AnyGeneratable<UInt> {
        Gen.from(UInt.min...UInt.max)
            .withEdgeCases(Gen.of([.min, 1, .max]))
            .eraseToAnyGeneratable()
    }
}

extension Int32: Arbitrary {
    /// A generator of arbitrary `Int32`s
    public static var arbitrary: AnyGeneratable<Int32> {
        Gen.from(Int32.min...Int32.max)
            .withEdgeCases(.of([.min, -1, 0, 1, .max]))
            .eraseToAnyGeneratable()
    }
}

extension UInt32: Arbitrary {
    /// A generator of arbitrary `UInt32`s
    public static var arbitrary: AnyGeneratable<UInt32> {
        Gen.from(UInt32.min...UInt32.max)
            .withEdgeCases(Gen.of([.min, 1, .max]))
            .eraseToAnyGeneratable()
    }
}

extension UnicodeScalar: Arbitrary {
    /// A generator of arbitrary `UnicodeScalar`s
    public static var arbitrary: AnyGeneratable<UnicodeScalar> {
        Gen.from(UnicodeScalar(32)...UnicodeScalar(255))
            .eraseToAnyGeneratable()
    }
}

extension Character: Arbitrary {
    /// A generator of arbitrary `Character`s
    public static var arbitrary: AnyGeneratable<Character> {
        UnicodeScalar.arbitrary
            .map { Character($0) }
            .eraseToAnyGeneratable()
    }
}

extension String: Arbitrary {
    /// A generator of arbitrary `String`s of random sizes
    public static var arbitrary: AnyGeneratable<String> {
        arbitrary()
    }

    /// A generator of arbitrary `String`s of random sizes in`range`
    public static func arbitrary(in range: ClosedRange<Int> = 0...100) -> AnyGeneratable<String> {
        Character.arbitrary
            .expand(toSizeInRange: range)
            .map { String($0) }
            .withEdgeCases(Generatables.Constant(""))
            .eraseToAnyGeneratable()
    }
}

extension Array: Arbitrary where Element: Arbitrary {
    /// A generator of arbitrary `Array`s of random sizes
    public static var arbitrary: AnyGeneratable<Array> {
        arbitrary()
    }

    /// A generator of arbitrary `Array`s of random sizes in `range`
    public static func arbitrary(in range: ClosedRange<Int> = 0...33) -> AnyGeneratable<Array> {
        Element.arbitrary
            .expand(toSizeInRange: range)
            .withEdgeCases(Generatables.Constant([]))
            .eraseToAnyGeneratable()
    }
}

extension Optional: Arbitrary where Wrapped: Arbitrary {
    /// A generator of `Optional`s where `Wrapped` conforms to `Arbitrary`
    public static var arbitrary: AnyGeneratable<Wrapped?> {
        Wrapped.arbitrary
            .orNil()
    }
}

extension AnySequence: Arbitrary where Element : Arbitrary {
    /// A generator of `AnySequence`s where `Element` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<AnySequence> {
        [Element].arbitrary
            .map(AnySequence.init)
            .eraseToAnyGeneratable()
    }
}

extension AnyBidirectionalCollection: Arbitrary where Element : Arbitrary {
    /// A generator of `AnyBidirectionalCollection`s where `Element` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<AnyBidirectionalCollection> {
        [Element].arbitrary
            .map(AnyBidirectionalCollection.init)
            .eraseToAnyGeneratable()
    }
}

extension ArraySlice: Arbitrary where Element : Arbitrary {
    /// A generator of `ArraySlice`s where `Element` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<ArraySlice> {
        [Element].arbitrary
            .map(ArraySlice.init)
            .eraseToAnyGeneratable()
    }
}

extension Dictionary: Arbitrary where Key : Arbitrary, Value : Arbitrary {
    /// A generator of `Dictionary`s where `Key` and `Value` conform to `Arbitrary`
    public static var arbitrary : AnyGeneratable<Dictionary> {
        [Key].arbitrary.flatMap { (k : [Key]) in
            [Value].arbitrary.flatMap { (v : [Value]) in
                Gen.constant(Dictionary(zip(k, v)) { $1 })
            }
        }
    }
}

extension EmptyCollection: Arbitrary {
    /// A generator of `EmptyCollection`s
    public static var arbitrary : AnyGeneratable<EmptyCollection> {
        Generatables.Constant(EmptyCollection())
            .eraseToAnyGeneratable()
    }
}

extension Range: Arbitrary where Bound: Arbitrary {
    /// A generator of `Range`s where `Bound` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<Range> {
        Bound.arbitrary.flatMap { l in
            Bound.arbitrary.flatMap { r in
                Generatables.Constant((Swift.min(l, r) ..< Swift.max(l, r)))
            }
        }.eraseToAnyGeneratable()
    }
}

extension LazySequence: Arbitrary where Base: Arbitrary {
    /// A generator of `LazySequence`s where `Base` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<LazySequence> {
        Base.arbitrary
            .map({ $0.lazy })
            .eraseToAnyGeneratable()
    }
}

extension Repeated: Arbitrary where Element: Arbitrary {
    /// A generator of `Repeated`s where `Element` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<Repeated> {
        let constructor: (Element, Int) -> Repeated<Element> = { (element, count) in
            return repeatElement(element , count: count)
        }

        return Element.arbitrary
            .zip(Int.arbitrary)
            .map({ t in constructor(t.0, t.1) })
            .eraseToAnyGeneratable()
    }
}

extension Set: Arbitrary where Element : Arbitrary {
    /// A generator of `Set`s where `Element` conforms to `Arbitrary`
    public static var arbitrary : AnyGeneratable<Set> {
        AnySequence<Element>.arbitrary
            .map { Set($0) }
            .eraseToAnyGeneratable()
    }
}

extension Result: Arbitrary where Success: Arbitrary, Failure: Arbitrary {
    /// A generator of `Result`s where `Success` and `Failure` conform to `Arbitrary`
    public static var arbitrary : AnyGeneratable<Result<Success, Failure>> {
        one(of: [
            Success.arbitrary.map(Result<Success, Failure>.success),
            Failure.arbitrary.map(Result<Success, Failure>.failure),
        ])
    }
}
