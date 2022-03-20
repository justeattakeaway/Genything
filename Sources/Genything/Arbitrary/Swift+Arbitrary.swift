extension Bool: ArbitraryGeneratable {
    /// A generator of arbitrary `Bool`eans
    public static var arbitrary: AnyGenerator<Bool> {
        AnyGenerator { ctx in
            Bool.random(using: &ctx.rng)
        }
        .eraseToAnyGenerator()
    }
}

extension Double: ArbitraryGeneratable {
    /// A generator of arbitrary `Doubles`s
    public static var arbitrary: AnyGenerator<Double> {
        Generators.from(Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
            .eraseToAnyGenerator()
    }
}

extension Int: ArbitraryGeneratable {
    /// A generator of arbitrary `Int`s
    public static var arbitrary: AnyGenerator<Int> {
        Generators.from(Int.min...Int.max)
            .eraseToAnyGenerator()
    }
}

extension UInt: ArbitraryGeneratable {
    /// A generator of arbitrary `UInt`s
    public static var arbitrary: AnyGenerator<UInt> {
        Generators.from(UInt.min...UInt.max)
            .eraseToAnyGenerator()
    }
}

extension Int32: ArbitraryGeneratable {
    /// A generator of arbitrary `Int32`s
    public static var arbitrary: AnyGenerator<Int32> {
        Generators.from(Int32.min...Int32.max)
            .eraseToAnyGenerator()
    }
}

extension UInt32: ArbitraryGeneratable {
    /// A generator of arbitrary `UInt32`s
    public static var arbitrary: AnyGenerator<UInt32> {
        Generators.from(UInt32.min...UInt32.max)
            .eraseToAnyGenerator()
    }
}

extension UnicodeScalar: ArbitraryGeneratable {
    /// A generator of arbitrary `UnicodeScalar`s
    public static var arbitrary: AnyGenerator<UnicodeScalar> {
        Generators.from(UnicodeScalar(32)...UnicodeScalar(255))
            .eraseToAnyGenerator()
    }
}

extension Character: ArbitraryGeneratable {
    /// A generator of arbitrary `Character`s
    public static var arbitrary: AnyGenerator<Character> {
        UnicodeScalar.arbitrary
            .map { Character($0) }
            .eraseToAnyGenerator()
    }
}

extension String: ArbitraryGeneratable {
    /// A generator of arbitrary `String`s of random sizes
    public static var arbitrary: AnyGenerator<String> {
        arbitrary()
    }

    /// A generator of arbitrary `String`s of random sizes in`range`
    public static func arbitrary(in range: ClosedRange<Int> = 0...100) -> AnyGenerator<String> {
        Character.arbitrary
            .expand(toSizeInRange: range)
            .map { String($0) }
            .eraseToAnyGenerator()
    }
}

extension Array: ArbitraryGeneratable where Element: ArbitraryGeneratable {
    /// A generator of arbitrary `Array`s of random sizes
    public static var arbitrary: AnyGenerator<Array> {
        arbitrary()
    }

    /// A generator of arbitrary `Array`s of random sizes in `range`
    public static func arbitrary(in range: ClosedRange<Int> = 0...33) -> AnyGenerator<Array> {
        Element.arbitrary
            .expand(toSizeInRange: range)
            .eraseToAnyGenerator()
    }
}

extension Optional: ArbitraryGeneratable where Wrapped: ArbitraryGeneratable {
    /// A generator of `Optional`s where `Wrapped` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Wrapped?> {
        Wrapped.arbitrary
            .orNil()
    }
}

extension AnySequence: ArbitraryGeneratable where Element : ArbitraryGeneratable {
    /// A generator of `AnySequence`s where `Element` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<AnySequence> {
        [Element].arbitrary
            .map(AnySequence.init)
            .eraseToAnyGenerator()
    }
}

extension AnyBidirectionalCollection: ArbitraryGeneratable where Element : ArbitraryGeneratable {
    /// A generator of `AnyBidirectionalCollection`s where `Element` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<AnyBidirectionalCollection> {
        [Element].arbitrary
            .map(AnyBidirectionalCollection.init)
            .eraseToAnyGenerator()
    }
}

extension ArraySlice: ArbitraryGeneratable where Element : ArbitraryGeneratable {
    /// A generator of `ArraySlice`s where `Element` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<ArraySlice> {
        [Element].arbitrary
            .map(ArraySlice.init)
            .eraseToAnyGenerator()
    }
}

extension Dictionary: ArbitraryGeneratable where Key : ArbitraryGeneratable, Value : ArbitraryGeneratable {
    /// A generator of `Dictionary`s where `Key` and `Value` conform to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Dictionary> {
        [Key].arbitrary.flatMap { (k : [Key]) in
            [Value].arbitrary.flatMap { (v : [Value]) in
                Generators.Constant(Dictionary(zip(k, v)) { $1 })
            }
        }.eraseToAnyGenerator()
    }
}

extension EmptyCollection: ArbitraryGeneratable {
    /// A generator of `EmptyCollection`s
    public static var arbitrary: AnyGenerator<EmptyCollection> {
        Generators.Constant(EmptyCollection())
            .eraseToAnyGenerator()
    }
}

extension Range: ArbitraryGeneratable where Bound: ArbitraryGeneratable {
    /// A generator of `Range`s where `Bound` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Range> {
        Bound.arbitrary.flatMap { l in
            Bound.arbitrary.flatMap { r in
                Generators.Constant((Swift.min(l, r) ..< Swift.max(l, r)))
            }
        }.eraseToAnyGenerator()
    }
}

extension LazySequence: ArbitraryGeneratable where Base: ArbitraryGeneratable {
    /// A generator of `LazySequence`s where `Base` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<LazySequence> {
        Base.arbitrary
            .map({ $0.lazy })
            .eraseToAnyGenerator()
    }
}

extension Repeated: ArbitraryGeneratable where Element: ArbitraryGeneratable {
    /// A generator of `Repeated`s where `Element` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Repeated> {
        let constructor: (Element, Int) -> Repeated<Element> = { (element, count) in
            return repeatElement(element , count: count)
        }

        return Element.arbitrary
            .zip(Int.arbitrary)
            .map({ t in constructor(t.0, t.1) })
            .eraseToAnyGenerator()
    }
}

extension Set: ArbitraryGeneratable where Element : ArbitraryGeneratable {
    /// A generator of `Set`s where `Element` conforms to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Set> {
        AnySequence<Element>.arbitrary
            .map { Set($0) }
            .eraseToAnyGenerator()
    }
}

extension Result: ArbitraryGeneratable where Success: ArbitraryGeneratable, Failure: ArbitraryGeneratable {
    /// A generator of `Result`s where `Success` and `Failure` conform to `ArbitraryGeneratable`
    public static var arbitrary: AnyGenerator<Result<Success, Failure>> {
        Generators.one(of: [
            Success.arbitrary.map(Result<Success, Failure>.success).eraseToAnyGenerator(),
            Failure.arbitrary.map(Result<Success, Failure>.failure).eraseToAnyGenerator(),
        ])
    }
}
