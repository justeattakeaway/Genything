import Foundation
import Genything
import XCTest

// - MARK: Test

public extension Gen {
    /// Iterates (lazily) over a generator sequence and tests that all values satisfy the given `predicate`
    ///
    /// Will run a maximum of n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - file: The file this test was called from
    ///   - line: The line this test was called from
    ///   - context: The context to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    ///
    /// - Attention: A failing predicate will assert with `XCTFail`
    ///
    func assertForAll(iterations: Int? = nil,
                context: Context = .default,
                file: StaticString = #filePath,
                line: UInt = #line,
               _ predicate: (T) throws -> Bool
    ) rethrows {
        let result = test(iterations: iterations, context: context, predicate)

        switch result {
            case .success: return
            case .failure(let info):
                switch info.reason {
                    case let .predicate(value):
                        fail("assertForAll failed with value: `\(value)`", context: context, file: file, line: line)
                    case let .error(error):
                        fail(error, context: context, file: file, line: line)
                }

        }
    }
}
