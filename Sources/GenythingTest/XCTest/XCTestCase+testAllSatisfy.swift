import Foundation
import Genything
#if canImport(XCTest)
import XCTest

// - MARK: Test

extension XCTestCase {
    /// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
    ///
    /// - Parameters:
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition
    public func testAllSatisfy<G1>(
        _ generator: G1,
        config: TestConfig = .default(),
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T) throws -> Bool
    ) where G1: Generator {
        let result = generator.test(config: config, predicate)

        switch result {
            case .success: return
            case .failure(let info):
                switch info.reason {
                    case .predicate(let value):
                        fail(
                            "testAllSatisfy failed for generated value: `\(value)` after `\(info.iteration) iterations.",
                            randomSource: config.randomSource,
                            file: file,
                            line: line
                        )
                    case .error(let error):
                        fail(error, randomSource: config.randomSource, file: file, line: line)
                }
        }
    }

    /// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
    ///
    /// - Parameters:
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    public func testAllSatisfy<G1, G2>(
        _ gen1: G1,
        _ gen2: G2,
        config: TestConfig = .default(),
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T, G2.T) throws -> Bool
    ) where G1: Generator, G2: Generator {
        testAllSatisfy(
            gen1.zip(gen2),
            config: config,
            file: file,
            line: line,
            predicate: predicate
        )
    }

    /// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
    ///
    /// - Parameters:
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    public func testAllSatisfy<G1, G2, G3>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        config: TestConfig = .default(),
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T, G2.T, G3.T) throws -> Bool
    ) where G1: Generator, G2: Generator, G3: Generator {
        testAllSatisfy(
            gen1.zip(gen2, gen3),
            config: config,
            file: file,
            line: line,
            predicate: predicate
        )
    }

    /// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
    ///
    /// - Parameters:
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    public func testAllSatisfy<G1, G2, G3, G4>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        config: TestConfig = .default(),
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T, G2.T, G3.T, G4.T) throws -> Bool
    ) where G1: Generator, G2: Generator, G3: Generator, G4: Generator {
        testAllSatisfy(
            gen1.zip(gen2, gen3, gen4),
            config: config,
            file: file,
            line: line,
            predicate: predicate
        )
    }

    /// Iterates over a generator sequence and asserts that all values satisfy the given `predicate`
    ///
    /// - Parameters:
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    public func testAllSatisfy<G1, G2, G3, G4, G5>(
        _ gen1: G1,
        _ gen2: G2,
        _ gen3: G3,
        _ gen4: G4,
        _ gen5: G5,
        config: TestConfig = .default(),
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T, G2.T, G3.T, G4.T, G5.T) throws -> Bool
    ) where G1: Generator, G2: Generator, G3: Generator, G4: Generator, G5: Generator {
        testAllSatisfy(
            gen1.zip(gen2, gen3, gen4, gen5),
            config: config,
            file: file,
            line: line,
            predicate: predicate
        )
    }
}
#endif
