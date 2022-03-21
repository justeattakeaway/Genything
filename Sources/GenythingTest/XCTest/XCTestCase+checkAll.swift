import Foundation
import Genything
import XCTest

// MARK: - Failure Detection / RandomSource storage

/// In order to provide information about the RandomSource we store a static map against `XCTestCase`
/// e.g. the `originalSeed` used for the test run
///
/// - Warning: Great care must be used to clear the randomSource store after a test run
///
private extension XCTestCase {
    static var _randomSourceStore = [String : RandomSource]()

    var address: String {
        String(format: "%p", unsafeBitCast(self, to: Int.self))
    }

    var randomSourceStore: RandomSource? {
        get {
            XCTestCase._randomSourceStore[address]
        }
        set(newValue) {
            XCTestCase._randomSourceStore[address] = newValue
        }
    }

    func setupCheck(_ randomSource: RandomSource) {
        continueAfterFailure = false

        randomSourceStore = randomSource

        addTeardownBlock {
            defer {
                self.randomSourceStore = nil
            }

            if
                let originalSeed = self.randomSourceStore?.originalSeed,
                let failureCount = self.testRun?.failureCount,
                failureCount > 0
            {
                print("[Genything] - Check failed with seed `\(originalSeed)`.")
            }
        }
    }
}

// MARK: - Test

public extension XCTestCase {
    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<T, G1: Generator>(_ gen1: G1,
                     randomSource: RandomSource = .default,
                     file: StaticString = #filePath,
                     line: UInt = #line,
                    _ body: (T) throws -> Void) where G1.T == T {
        setupCheck(randomSource)

        do {
            try gen1.asSequence(size: TestConfig.maxIterations, randomSource: randomSource).forEach(body)
        } catch {
            fail(error, randomSource: randomSource, file: file, line: line)
        }
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<T1, T2, G1: Generator, G2: Generator>(
        _ gen1: G1,
        _ gen2: G2,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2) throws -> Void
    ) where G1.T == T1,
            G2.T == T2
    {
        checkAll(
            gen1.zip(gen2),
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3
    {
        checkAll(
            gen1.zip(gen2, gen3),
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4
    {
        checkAll(
            gen1.zip(gen2, gen3, gen4),
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5
    {
        checkAll(
            gen1.zip(gen2, gen3, gen4, gen5),
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - gen6: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator,
        T6, G6: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5, T6) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5,
            G6.T == T6
    {
        checkAll(
            Generators.compose {
                (
                    $0(gen1),
                    $0(gen2),
                    $0(gen3),
                    $0(gen4),
                    $0(gen5),
                    $0(gen6)
                )
            },
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }


    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - gen6: A generator who's values will be used for testing
    ///   - gen7: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator,
        T6, G6: Generator,
        T7, G7: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5, T6, T7) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5,
            G6.T == T6,
            G7.T == T7
    {
        checkAll(
            Generators.compose {
                (
                    $0(gen1),
                    $0(gen2),
                    $0(gen3),
                    $0(gen4),
                    $0(gen5),
                    $0(gen6),
                    $0(gen7)
                )
            },
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - gen6: A generator who's values will be used for testing
    ///   - gen7: A generator who's values will be used for testing
    ///   - gen8: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator,
        T6, G6: Generator,
        T7, G7: Generator,
        T8, G8: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        _ gen8: G8,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5, T6, T7, T8) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5,
            G6.T == T6,
            G7.T == T7,
            G8.T == T8
    {
        checkAll(
            Generators.compose {
                (
                    $0(gen1),
                    $0(gen2),
                    $0(gen3),
                    $0(gen4),
                    $0(gen5),
                    $0(gen6),
                    $0(gen7),
                    $0(gen8)
                )
            },
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - gen6: A generator who's values will be used for testing
    ///   - gen7: A generator who's values will be used for testing
    ///   - gen8: A generator who's values will be used for testing
    ///   - gen9: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator,
        T6, G6: Generator,
        T7, G7: Generator,
        T8, G8: Generator,
        T9, G9: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        _ gen8: G8,
        _ gen9: G9,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5, T6, T7, T8, T9) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5,
            G6.T == T6,
            G7.T == T7,
            G8.T == T8,
            G9.T == T9
    {
        checkAll(
            Generators.compose {
                (
                    $0(gen1),
                    $0(gen2),
                    $0(gen3),
                    $0(gen4),
                    $0(gen5),
                    $0(gen6),
                    $0(gen7),
                    $0(gen8),
                    $0(gen9)
                )
            },
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `RandomSource` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - randomSource: The randomSource to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - gen5: A generator who's values will be used for testing
    ///   - gen6: A generator who's values will be used for testing
    ///   - gen7: A generator who's values will be used for testing
    ///   - gen8: A generator who's values will be used for testing
    ///   - gen9: A generator who's values will be used for testing
    ///   - gen10: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generator,
        T2, G2: Generator,
        T3, G3: Generator,
        T4, G4: Generator,
        T5, G5: Generator,
        T6, G6: Generator,
        T7, G7: Generator,
        T8, G8: Generator,
        T9, G9: Generator,
        T10, G10: Generator
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        _ gen8: G8,
        _ gen9: G9,
        _ gen10: G10,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4,
            G5.T == T5,
            G6.T == T6,
            G7.T == T7,
            G8.T == T8,
            G9.T == T9,
            G10.T == T10
    {
        checkAll(
            Generators.compose {
                (
                    $0(gen1),
                    $0(gen2),
                    $0(gen3),
                    $0(gen4),
                    $0(gen5),
                    $0(gen6),
                    $0(gen7),
                    $0(gen8),
                    $0(gen9),
                    $0(gen10)
                )
            },
            randomSource: randomSource,
            file: file,
            line: line,
            body
        )
    }
}
