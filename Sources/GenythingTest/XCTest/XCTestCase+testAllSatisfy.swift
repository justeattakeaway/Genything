import Foundation
import Genything
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
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T) throws -> Bool
    ) where G1: Generator {
        let result = generator.test(iterations: TestConfig.maxIterations, randomSource: randomSource, predicate)

        switch result {
        case .success: return
        case .failure(let info):
            switch info.reason {
            case .predicate(let value):
                fail(
                    "testAllSatisfy failed for generated value: `\(value)` after `\(info.iteration) iterations.",
                    randomSource: randomSource,
                    file: file,
                    line: line
                )
            case .error(let error):
                fail(error, randomSource: randomSource, file: file, line: line)
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
        randomSource: RandomSource = .default,
        file: StaticString = #filePath,
        line: UInt = #line,
        predicate: @escaping (G1.T, G2.T) throws -> Bool
    ) where G1: Generator, G2: Generator {
        testAllSatisfy(
            gen1.zip(gen2),
            randomSource: randomSource,
            file: file,
            line: line,
            predicate: predicate
        )
    }

    // TODO: Add more
}
