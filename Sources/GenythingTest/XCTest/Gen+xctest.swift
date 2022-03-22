import Foundation
import Genything
import XCTest

// - MARK: Test

public extension XCTestCase {
    /// Iterates (lazily) over a generator sequence and tests that all values satisfy the given `predicate`
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the randomSource's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the randomSource's `maxIterations` value
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - randomSource: The randomSource to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    func testAllSatisfy<G: Generator>(_ generator: G,
                                    randomSource: RandomSource = .default,
                                    file: StaticString = #filePath,
                                    line: UInt = #line,
                                    _ predicate: (G.T) throws -> Bool) {
        let result = generator.test(iterations: TestConfig.maxIterations, randomSource: randomSource, predicate)

        switch result {
            case .success: return
            case .failure(let info):
                switch info.reason {
                    case let .predicate(value):
                        fail("testAllSatisfy failed for generated value: `\(value)` after `\(info.iteration) iterations.", randomSource: randomSource, file: file, line: line)
                    case let .error(error):
                        fail(error, randomSource: randomSource, file: file, line: line)
                }

        }
    }
}
