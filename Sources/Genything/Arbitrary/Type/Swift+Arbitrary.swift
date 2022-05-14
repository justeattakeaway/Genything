// MARK: - Bool + Arbitrary

extension Bool: Arbitrary {
    /// A generator of arbitrary `Bool`eans
    public static var arbitrary: AnyGenerator<Bool> {
        AnyGenerator { ctx in
            Bool.random(using: &ctx.rng)
        }
    }
}

// MARK: - Double + Arbitrary

extension Double: Arbitrary {
    /// A generator of arbitrary `Double`s
    public static var arbitrary: AnyGenerator<Double> {
        (Self.leastNormalMagnitude ... Self.greatestFiniteMagnitude).arbitrary
    }
}

// MARK: - Int + Arbitrary

extension Int: Arbitrary {
    /// A generator of arbitrary `Int`s
    public static var arbitrary: AnyGenerator<Int> {
        (Self.min ... Self.max).arbitrary
    }
}

// MARK: - UInt + Arbitrary

extension UInt: Arbitrary {
    /// A generator of arbitrary `UInt`s
    public static var arbitrary: AnyGenerator<UInt> {
        (Self.min ... Self.max).arbitrary
    }
}

// MARK: - Int32 + Arbitrary

extension Int32: Arbitrary {
    /// A generator of arbitrary `Int32`s
    public static var arbitrary: AnyGenerator<Int32> {
        (Self.min ... Self.max).arbitrary
    }
}

// MARK: - UInt32 + Arbitrary

extension UInt32: Arbitrary {
    /// A generator of arbitrary `UInt32`s
    public static var arbitrary: AnyGenerator<UInt32> {
        (Self.min ... Self.max).arbitrary
    }
}

// MARK: - UnicodeScalar + Arbitrary

extension UnicodeScalar: Arbitrary {
    /// A generator of arbitrary `UnicodeScalar`s
    public static var arbitrary: AnyGenerator<UnicodeScalar> {
        (UnicodeScalar(32) ... UnicodeScalar(255)).arbitrary
    }
}

// MARK: - Character + Arbitrary

extension Character: Arbitrary {
    /// A generator of arbitrary `Character`s
    public static var arbitrary: AnyGenerator<Character> {
        UnicodeScalar.arbitrary
            .map { Character($0) }
    }
}

// MARK: - String + Arbitrary

extension String: Arbitrary {
    /// A generator of arbitrary `String`s of random sizes
    public static var arbitrary: AnyGenerator<String> {
        AnyGenerator { $0 }.flatMap { rs in
            arbitrary(in: 0 ... rs.maxArbitraryCollectionSize)
        }
    }

    /// A generator of arbitrary `String`s of random sizes in`range`
    public static func arbitrary(in range: ClosedRange<Int>) -> AnyGenerator<String> {
        Character.arbitrary
            .expand(toSizeInRange: range)
            .map { String($0) }
    }
}

// MARK: - Array + Arbitrary

extension Array: Arbitrary where Element: Arbitrary {
    /// A generator of arbitrary `Array`s of random sizes
    public static var arbitrary: AnyGenerator<Array> {
        AnyGenerator { $0 }.flatMap { rs in
            arbitrary(in: 0 ... rs.maxRecursiveArbitraryCollectionSize)
        }
    }

    /// A generator of arbitrary `Array`s of random sizes in `range`
    public static func arbitrary(in range: ClosedRange<Int>) -> AnyGenerator<Array> {
        Element.arbitrary
            .expand(toSizeInRange: range)
    }
}

// MARK: - Optional + Arbitrary

extension Optional: Arbitrary where Wrapped: Arbitrary {
    /// A generator of `Optional`s where `Wrapped` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<Wrapped?> {
        Wrapped.arbitrary
            .orNil()
    }
}

// MARK: - AnySequence + Arbitrary

extension AnySequence: Arbitrary where Element: Arbitrary {
    /// A generator of `AnySequence`s where `Element` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<AnySequence> {
        [Element].arbitrary
            .map(AnySequence.init)
    }
}

// MARK: - AnyBidirectionalCollection + Arbitrary

extension AnyBidirectionalCollection: Arbitrary where Element: Arbitrary {
    /// A generator of `AnyBidirectionalCollection`s where `Element` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<AnyBidirectionalCollection> {
        [Element].arbitrary
            .map(AnyBidirectionalCollection.init)
    }
}

// MARK: - ArraySlice + Arbitrary

extension ArraySlice: Arbitrary where Element: Arbitrary {
    /// A generator of `ArraySlice`s where `Element` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<ArraySlice> {
        [Element].arbitrary
            .map(ArraySlice.init)
    }
}

// MARK: - Dictionary + Arbitrary

extension Dictionary: Arbitrary where Key: Arbitrary, Value: Arbitrary {
    /// A generator of `Dictionary`s where `Key` and `Value` conform to `Arbitrary`
    public static var arbitrary: AnyGenerator<Dictionary> {
        [Key].arbitrary.flatMap { (k: [Key]) in
            [Value].arbitrary.flatMap { (v: [Value]) in
                Generators.constant(Dictionary(zip(k, v)) { $1 })
            }
        }
    }
}

// MARK: - EmptyCollection + Arbitrary

extension EmptyCollection: Arbitrary {
    /// A generator of `EmptyCollection`s
    public static var arbitrary: AnyGenerator<EmptyCollection> {
        Generators.constant(EmptyCollection()).eraseToAnyGenerator()
    }
}

// MARK: - Range + Arbitrary

extension Range: Arbitrary where Bound: Arbitrary {
    /// A generator of `Range`s where `Bound` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<Range> {
        Bound.arbitrary.flatMap { l in
            Bound.arbitrary.flatMap { r in
                Generators.constant(Swift.min(l, r) ..< Swift.max(l, r))
            }
        }
    }
}

// MARK: - LazySequence + Arbitrary

extension LazySequence: Arbitrary where Base: Arbitrary {
    /// A generator of `LazySequence`s where `Base` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<LazySequence> {
        Base.arbitrary
            .map { $0.lazy }
    }
}

// MARK: - Repeated + Arbitrary

extension Repeated: Arbitrary where Element: Arbitrary {
    /// A generator of `Repeated`s where `Element` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<Repeated> {
        let constructor: (Element, Int) -> Repeated<Element> = { element, count in
            repeatElement(element, count: count)
        }

        return Element.arbitrary
            .zip(Int.arbitrary)
            .map { t in constructor(t.0, t.1) }
    }
}

// MARK: - Set + Arbitrary

extension Set: Arbitrary where Element: Arbitrary {
    /// A generator of `Set`s where `Element` conforms to `Arbitrary`
    public static var arbitrary: AnyGenerator<Set> {
        AnySequence<Element>.arbitrary
            .map { Set($0) }
    }
}

// MARK: - Result + Arbitrary

extension Result: Arbitrary where Success: Arbitrary, Failure: Arbitrary {
    /// A generator of `Result`s where `Success` and `Failure` conform to `Arbitrary`
    public static var arbitrary: AnyGenerator<Result<Success, Failure>> {
        Generators.one(of: [
            Success.arbitrary.map(Result<Success, Failure>.success),
            Failure.arbitrary.map(Result<Success, Failure>.failure),
        ])
    }
}
