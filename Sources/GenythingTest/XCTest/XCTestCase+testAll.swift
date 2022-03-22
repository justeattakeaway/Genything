import Foundation
import Genything
import XCTest

// MARK: - Failure Detection / RandomSource storage

/// In order to provide information about the RandomSource we store a static map against `XCTestCase`
/// e.g. the `originalSeed` used for the test run
///
/// - Warning: Great care must be used to clear the randomSource store after a test run
///
extension XCTestCase {

    // MARK: Fileprivate

    fileprivate static var _randomSourceStore = [String: RandomSource]()

    // MARK: Private

    private var address: String {
        String(format: "%p", unsafeBitCast(self, to: Int.self))
    }

    private var randomSourceStore: RandomSource? {
        get {
            XCTestCase._randomSourceStore[address]
        }
        set(newValue) {
            XCTestCase._randomSourceStore[address] = newValue
        }
    }

    private func setupCheck(_ randomSource: RandomSource) {
        continueAfterFailure = false

        randomSourceStore = randomSource

        addTeardownBlock {
            defer {
                self.randomSourceStore = nil
            }

            if
                let originalSeed = self.randomSourceStore?.originalSeed,
                let failureCount = self.testRun?.failureCount,
                failureCount > 0 {
                print("[Genything] - Check failed with seed `\(originalSeed)`.")
            }
        }
    }
}

// MARK: - Test

extension XCTestCase {
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
    public func testAll<G1>(
        _ gen1: G1,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T) throws -> Void
    ) where G1: Generator {
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
    public func testAll<G1, G2>(
        _ gen1: G1,
        _ gen2: G2,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T, G2.T) throws -> Void
    ) where G1: Generator, G2: Generator {
        testAll(
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
    public func testAll<G1, G2, G3>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T, G2.T, G3.T) throws -> Void
    ) where G1: Generator, G2: Generator, G3: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T, G2.T, G3.T, G4.T) throws -> Void
    ) where G1: Generator, G2: Generator, G3: Generator, G4: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T) throws -> Void
    ) where G1: Generator, G2: Generator, G3: Generator, G4: Generator,
        G5: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5, G6>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T) throws -> Void
    ) where G1: Generator, G2: Generator, G3: Generator,
        G4: Generator,
        G5: Generator, G6: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5, G6, G7>(
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
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T, G7.T) throws -> Void
    ) where G1: Generator, G2: Generator, G3: Generator,
        G4: Generator, G5: Generator, G6: Generator, G7: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5, G6, G7, G8>(
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
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T, G7.T, G8.T) throws -> Void
    ) where G1: Generator,
        G2: Generator,
        G3: Generator,
        G4: Generator,
        G5: Generator,
        G6: Generator,
        G7: Generator,
        G8: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5, G6, G7, G8, G9>(
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
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T, G7.T, G8.T, G9.T) throws -> Void
    ) where G1: Generator,
        G2: Generator,
        G3: Generator,
        G4: Generator,
        G5: Generator,
        G6: Generator,
        G7: Generator,
        G8: Generator,
        G9: Generator {
        testAll(
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
    public func testAll<G1, G2, G3, G4, G5, G6, G7, G8, G9, G10>(
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
        _ body: (G1.T, G2.T, G3.T, G4.T, G5.T, G6.T, G7.T, G8.T, G9.T, G10.T) throws -> Void
    ) where G1: Generator, G2: Generator,
        G3: Generator, G4: Generator, G5: Generator, G6: Generator, G7: Generator, G8: Generator, G9: Generator, G10: Generator {
        testAll(
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
