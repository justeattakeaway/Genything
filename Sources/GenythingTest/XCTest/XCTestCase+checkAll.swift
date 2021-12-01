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
                let totalFailureCount = self.testRun?.totalFailureCount,
                totalFailureCount > 0
            {
                print("GenythingTest check failed with seed `\(originalSeed)`.")
            }
        }
    }
}

// MARK: - Test

public extension XCTestCase {

    func checkAll<T>(_ gen1: Gen<T>,
                     context: Context = .default,
                     _ body: (T) throws -> Void) rethrows {
        setupCheck(context)
        try gen1
            .forEach(body)
    }

    func checkAll<T1, T2>(_ gen1: Gen<T1>,
                          _ gen2: Gen<T2>,
                          context: Context = .default,
                          _ body: (T1, T2) throws -> Void) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2)
            .forEach(body)
    }

    func checkAll<T1, T2, T3>(_ gen1: Gen<T1>,
                              _ gen2: Gen<T2>,
                              _ gen3: Gen<T3>,
                              context: Context = .default,
                              _ body: (T1, T2, T3) throws -> Void) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4>(_ gen1: Gen<T1>,
                                  _ gen2: Gen<T2>,
                                  _ gen3: Gen<T3>,
                                  _ gen4: Gen<T4>,
                                  context: Context = .default,
                                  _ body: (T1, T2, T3, T4) throws -> Void) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4, T5>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        context: Context = .default,
        _ body: (T1, T2, T3, T4, T5) throws -> Void
    ) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4, gen5)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4, T5, T6>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        context: Context = .default,
        _ body: (T1, T2, T3, T4, T5, T6) throws -> Void
    ) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4, gen5, gen6)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4, T5, T6, T7>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        context: Context = .default,
        _ body: (T1, T2, T3, T4, T5, T6, T7) throws -> Void
    ) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4, T5, T6, T7, T8>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        context: Context = .default,
        _ body: (T1, T2, T3, T4, T5, T6, T7, T8) throws -> Void
    ) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8)
            .forEach(body)
    }

    func checkAll<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
        _ gen1: Gen<T1>,
        _ gen2: Gen<T2>,
        _ gen3: Gen<T3>,
        _ gen4: Gen<T4>,
        _ gen5: Gen<T5>,
        _ gen6: Gen<T6>,
        _ gen7: Gen<T7>,
        _ gen8: Gen<T8>,
        _ gen9: Gen<T9>,
        context: Context = .default,
        _ body: (T1, T2, T3, T4, T5, T6, T7, T8, T9) throws -> Void
    ) rethrows {
        setupCheck(context)
        try Gen.zip(gen1, gen2, gen3, gen4, gen5, gen6, gen7, gen8, gen9)
            .forEach(body)
    }
}
