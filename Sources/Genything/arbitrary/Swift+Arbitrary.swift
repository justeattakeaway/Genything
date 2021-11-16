extension Bool: Arbitrary {
    public static var arbitrary: Gen<Bool> {
        Gen.of([true, false])
    }
}

extension Double: Arbitrary {
    public static var arbitrary: Gen<Double> {
        Gen<Double>.from(Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
    }
}

extension Int: Arbitrary {
    public static var arbitrary: Gen<Int> {
        Gen<Int>.from(Int.min...Int.max)
    }
}

extension UInt: Arbitrary {
    public static var arbitrary: Gen<UInt> {
        Gen<UInt>.from(UInt.min...UInt.max)
    }
}

extension Int32: Arbitrary {
    public static var arbitrary: Gen<Int32> {
        Gen<Int32>.from(Int32.min...Int32.max)
    }
}

extension UInt32: Arbitrary {
    public static var arbitrary: Gen<UInt32> {
        Gen<UInt32>.from(UInt32.min...UInt32.max)
    }
}

extension UnicodeScalar: Arbitrary {
    public static var arbitrary: Gen<UnicodeScalar> {
        Gen<UnicodeScalar>.from(UnicodeScalar(32)...UnicodeScalar(255))
    }
}

extension Character: Arbitrary {
    public static var arbitrary: Gen<Character> {
        UnicodeScalar.arbitrary.map { Character($0) }
    }
}

extension String: Arbitrary {
    public static var arbitrary: Gen<String> {
        arbitrary()
    }

    public static func arbitrary(in range: ClosedRange<Int> = 0...100) -> Gen<String> {
        Character.arbitrary.proliferate(in: range).map {
            String($0)
        }
    }
}

extension Array: Arbitrary where Element: Arbitrary {
    public static var arbitrary: Gen<Array> {
        arbitrary()
    }

    public static func arbitrary(in range: ClosedRange<Int> = 0...33) -> Gen<Array> {
        Element.arbitrary.proliferate(in: range)
    }
}

extension Optional: Arbitrary where Wrapped: Arbitrary {
    public static var arbitrary: Gen<Wrapped?> {
        Wrapped.arbitrary.orNil()
    }
}

extension AnySequence: Arbitrary where Element : Arbitrary {
    public static var arbitrary : Gen<AnySequence> {
        [Element].arbitrary.map(AnySequence.init)
    }
}

extension AnyBidirectionalCollection: Arbitrary where Element : Arbitrary {
    public static var arbitrary : Gen<AnyBidirectionalCollection> {
        [Element].arbitrary.map(AnyBidirectionalCollection.init)
    }
}

extension ArraySlice: Arbitrary where Element : Arbitrary {
    public static var arbitrary : Gen<ArraySlice> {
        [Element].arbitrary.map(ArraySlice.init)
    }
}

extension Dictionary: Arbitrary where Key : Arbitrary, Value : Arbitrary {
    public static var arbitrary : Gen<Dictionary> {
        [Key].arbitrary.flatMap { (k : [Key]) in
            [Value].arbitrary.flatMap { (v : [Value]) in
                Gen.constant(Dictionary(zip(k, v)) { $1 })
            }
        }
    }
}

extension EmptyCollection: Arbitrary {
    public static var arbitrary : Gen<EmptyCollection> {
        Gen.constant(EmptyCollection())
    }
}

extension Range: Arbitrary where Bound : Arbitrary {
    public static var arbitrary : Gen<Range> {
        Bound.arbitrary.flatMap { l in
            Bound.arbitrary.flatMap { r in
                Gen.constant((Swift.min(l, r) ..< Swift.max(l, r)))
            }
        }
    }
}

extension LazySequence: Arbitrary where Base : Arbitrary {
    public static var arbitrary : Gen<LazySequence> {
        Base.arbitrary.map({ $0.lazy })
    }
}

extension Repeated: Arbitrary where Element : Arbitrary {
    public static var arbitrary : Gen<Repeated> {
        let constructor: (Element, Int) -> Repeated<Element> = { (element, count) in
            return repeatElement(element , count: count)
        }

        return Element.arbitrary
            .zip(with: Int.arbitrary)
            .map({ t in constructor(t.0, t.1) })
    }
}

extension Set: Arbitrary where Element : Arbitrary {
    public static var arbitrary : Gen<Set> {
        AnySequence<Element>.arbitrary.map { Set($0) }
    }
}

extension Result: Arbitrary where Success: Arbitrary, Failure: Arbitrary {
    public static var arbitrary : Gen<Result<Success, Failure>> {
        Gen<Result<Success, Failure>>.one(of: [
            Success.arbitrary.map(Result<Success, Failure>.success),
            Failure.arbitrary.map(Result<Success, Failure>.failure),
        ])
    }
}
