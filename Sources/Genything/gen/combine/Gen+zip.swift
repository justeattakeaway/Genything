// - MARK: zip

public extension Gen {
    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///
    /// - Returns: A generator of Tuples
    func zip<R>(with other: Gen<R>) -> Gen<(T, R)> {
        Gen<(T, R)> { ctx in
            (self.generate(context: ctx), other.generate(context: ctx))
        }
    }

    /// Returns: A generator by zipping together the values produced by the receiver and `other`
    ///
    /// - Parameters:
    ///    - other: Another generator to zip with
    ///    - transform: Transforms the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of Tuples
    func zip<U, R>(with other: Gen<U>, transform: @escaping (T, U) -> R) -> Gen<R> {
        self.zip(with: other).map({ t in transform(t.0, t.1) })
    }
}

// - MARK: zip2

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///
    /// - Returns: A generator of Tuples
    static func zip<T1, T2>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>
    ) -> Gen<(T1, T2)> where T == (T1, T2) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    static func zip<T1, T2>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        transform: @escaping (T1, T2) -> T
    ) -> Gen {
        Gen<(T1, T2)>.zip(gen1, gen2).map({ t in transform(t.0, t.1) })
    }
}

// - MARK: zip3

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>
    ) -> Gen<(T1, T2, T3)> where T == (T1, T2, T3) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        transform: @escaping (T1, T2, T3) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3)>.zip(gen1, gen2, gen3).map({ t in transform(t.0, t.1, t.2) })
    }
}

// - MARK: zip4

extension Gen {

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///
    /// - Returns: A generator of values
    static func zip<T1, T2, T3, T4>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>
    ) -> Gen<(T1, T2, T3, T4)> where T == (T1, T2, T3, T4) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    static func zip<T1, T2, T3, T4>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        transform: @escaping (T1, T2, T3, T4) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4)>.zip(gen1, gen2, gen3, gen4).map({ t in transform(t.0, t.1, t.2, t.3) })
    }
}

// - MARK: zip5

public extension Gen {

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///
    /// - Returns: A generator of values
    static func zip<T1, T2, T3, T4, T5>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>
    ) -> Gen<(T1, T2, T3, T4, T5)> where T == (T1, T2, T3, T4, T5) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    static func zip<T1, T2, T3, T4, T5>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        transform: @escaping (T1, T2, T3, T4, T5) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5)>.zip(gen1, gen2, gen3, gen4, gen5).map({ t in transform(t.0, t.1, t.2, t.3, t.4) })
    }
}

// - MARK: zip6

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>
    ) -> Gen<(T1, T2, T3, T4, T5, T6)> where T == (T1, T2, T3, T4, T5, T6) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5),
                $0.generate(gen6)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        transform: @escaping (T1, T2, T3, T4, T5, T6) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5, T6)>
            .zip(gen1, gen2, gen3, gen4, gen5, gen6)
            .map({ t in transform(t.0, t.1, t.2, t.3, t.4, t.5) })
    }
}

// - MARK: zip7

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///    - gen7: Seventh generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>
    ) -> Gen<(T1, T2, T3, T4, T5, T6, T7)> where T == (T1, T2, T3, T4, T5, T6, T7) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5),
                $0.generate(gen6),
                $0.generate(gen7)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen5: Sixth generator
    ///    - gen7: Seventh generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        transform: @escaping (T1, T2, T3, T4, T5, T6, T7) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5, T6, T7)>
            .zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7)
            .map({ t in transform(t.0, t.1, t.2, t.3, t.4, t.5, t.6) })
    }
}

// - MARK: zip8

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>
    ) -> Gen<(T1, T2, T3, T4, T5, T6, T7, T8)> where T == (T1, T2, T3, T4, T5, T6, T7, T8) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5),
                $0.generate(gen6),
                $0.generate(gen7),
                $0.generate(gen8)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen5: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        transform: @escaping (T1, T2, T3, T4, T5, T6, T7, T8) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5, T6, T7, T8)>
            .zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8)
            .map({ t in transform(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7) })
    }
}

// - MARK: zip9

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///    - gen9: Ninth generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        _ gen9: Gen<T9>
    ) -> Gen<(T1, T2, T3, T4, T5, T6, T7, T8, T9)> where T == (T1, T2, T3, T4, T5, T6, T7, T8, T9) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5),
                $0.generate(gen6),
                $0.generate(gen7),
                $0.generate(gen8),
                $0.generate(gen9)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen5: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///    - gen9: Ninth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        _ gen9: Gen<T9>,
        transform: @escaping (T1, T2, T3, T4, T5, T6, T7, T8, T9) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5, T6, T7, T8, T9)>
            .zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8, gen9)
            .map({ t in transform(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8) })
    }
}

// - MARK: zip10

extension Gen {
    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen6: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///    - gen9: Ninth generator
    ///    - gen10: Tenth generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        _ gen9: Gen<T9>,
        _ gen10: Gen<T10>
    ) -> Gen<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)> where T == (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) {
        Gen.compose {
            (
                $0.generate(gen1),
                $0.generate(gen2),
                $0.generate(gen3),
                $0.generate(gen4),
                $0.generate(gen5),
                $0.generate(gen6),
                $0.generate(gen7),
                $0.generate(gen8),
                $0.generate(gen9),
                $0.generate(gen10)
            )
        }
    }

    /// Returns: A generator by zipping together the values produced by the supplied generators
    ///
    /// - Note: This is a very complex zip operation. Perhaps you should consider using `Gen.compose` instead!
    ///
    /// - Parameters:
    ///    - gen1: First generator
    ///    - gen2: Second generator
    ///    - gen3: Third generator
    ///    - gen4: Fourth generator
    ///    - gen5: Fifth generator
    ///    - gen5: Sixth generator
    ///    - gen7: Seventh generator
    ///    - gen8: Eighth generator
    ///    - gen9: Ninth generator
    ///    - gen10: Tenth generator
    ///    - transform: A function capable of transforming the values produced by the resulting zipped generator
    ///
    /// - Returns: A generator of values
    public static func zip<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        _ gen9: Gen<T9>,
        _ gen10: Gen<T10>,
        transform: @escaping (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) -> T
    ) -> Gen<T> {
        Gen<(T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)>
            .zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8, gen9, gen10)
            .map({ t in transform(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8, t.9) })
    }
}
