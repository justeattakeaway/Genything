import Foundation
import Genything
import XCTest

// MARK: - Failure Detection / Context storage

/// In order to provide information about the Context we store a static map against `XCTestCase`
/// e.g. the `originalSeed` used for the test run
///
/// - Warning: Great care must be used to clear the context store after a test run
///
private extension XCTestCase {
    static var _contextStore = [String : Context]()

    var address: String {
        String(format: "%p", unsafeBitCast(self, to: Int.self))
    }

    var contextStore: Context? {
        get {
            XCTestCase._contextStore[address]
        }
        set(newValue) {
            XCTestCase._contextStore[address] = newValue
        }
    }

    func setupCheck(_ context: Context) {
        continueAfterFailure = false

        contextStore = context

        addTeardownBlock {
            defer {
                self.contextStore = nil
            }

            if
                let originalSeed = self.contextStore?.originalSeed,
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
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<T, G1: Generatable>(_ gen1: G1,
                     context: Context = .default,
                     file: StaticString = #filePath,
                     line: UInt = #line,
                    _ body: (T) throws -> Void) where G1.T == T {
        setupCheck(context)

        do {
            try gen1
                .start()
                .safe
                .forEach(context: context, body)
        } catch {
            fail(error, context: context, file: file, line: line)
        }
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<T1, T2, G1: Generatable, G2: Generatable>(
        _ gen1: G1,
        _ gen2: G2,
        context: Context = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2) throws -> Void
    ) where G1.T == T1,
            G2.T == T2
    {
        checkAll(
            Gen<(T1, T2)>.zip(gen1.start(), gen2.start()),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        context: Context = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3
    {
        checkAll(
            Gen.zip(gen1.start(), gen2.start(), gen3.start()),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
    ///   - gen1: A generator who's values will be used for testing
    ///   - gen2: A generator who's values will be used for testing
    ///   - gen3: A generator who's values will be used for testing
    ///   - gen4: A generator who's values will be used for testing
    ///   - body: A closure body where you may make your XCTest assertions
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func checkAll<
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        context: Context = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        _ body: (T1, T2, T3, T4) throws -> Void
    ) where G1.T == T1,
            G2.T == T2,
            G3.T == T3,
            G4.T == T4
    {
        checkAll(
            Gen.zip(gen1.start(), gen2.start(), gen3.start(), gen4.start()),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable,
        T6, G6: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start(),
                gen6.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }


    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable,
        T6, G6: Generatable,
        T7, G7: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start(),
                gen6.start(),
                gen7.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable,
        T6, G6: Generatable,
        T7, G7: Generatable,
        T8, G8: Generatable
    >(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        _ gen6: G6,
        _ gen7: G7,
        _ gen8: G8,
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start(),
                gen6.start(),
                gen7.start(),
                gen8.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable,
        T6, G6: Generatable,
        T7, G7: Generatable,
        T8, G8: Generatable,
        T9, G9: Generatable
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
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start(),
                gen6.start(),
                gen7.start(),
                gen8.start(),
                gen9.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }

    /// Iterates (lazily) over the provided generators, passing values to the `body` block for testing
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the `Context` value
    ///
    /// - Note: This is a very complex check. Consider combining your generators first.
    ///
    /// - Attention: Sets `continueAfterFailure` to `false` for this `XCTestCase`
    ///
    /// - Parameters:
    ///   - context: The context to be used for generation
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
        T1, G1: Generatable,
        T2, G2: Generatable,
        T3, G3: Generatable,
        T4, G4: Generatable,
        T5, G5: Generatable,
        T6, G6: Generatable,
        T7, G7: Generatable,
        T8, G8: Generatable,
        T9, G9: Generatable,
        T10, G10: Generatable
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
        context: Context = .default,
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
            Gen.zip(
                gen1.start(),
                gen2.start(),
                gen3.start(),
                gen4.start(),
                gen5.start(),
                gen6.start(),
                gen7.start(),
                gen8.start(),
                gen9.start(),
                gen10.start()
            ),
            context: context,
            file: file,
            line: line,
            body
        )
    }
}
