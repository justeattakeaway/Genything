import Foundation
import Genything
import XCTest

private extension FailedTestReport {
    /// String desription of a failing test report
    var failureMessage: String {
        let seedInfo: String = {
            guard let seed = seed else { return "" }
            return "seed:\(seed)"
        }()
        let iterationInfo = "i:\(iteration)"

        let basicMessage = "(\(seedInfo) \(iterationInfo))"

        switch reason {
            case .predicate(let value):
                return "Predicate failed with value: `\(value)` " + basicMessage
            case .error(let error):
                switch error as? GenError {
                    case .some(.maxDepthReached):
                        return "Max generator depth was reached! " + basicMessage
                    default:
                        return "Test failed with exception: \(error.localizedDescription). " + basicMessage
                }
        }
    }
}


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
    func xctest(iterations: Int? = nil,
                context: Context = .default,
                file: StaticString = #filePath,
                line: UInt = #line,
               _ predicate: (T) throws -> Bool
    ) rethrows {
        let result = test(iterations: iterations, context: context, predicate)

        switch result {
            case .success: return
            case .failure(let info):
                XCTFail(info.failureMessage, file: file, line: line)
        }
    }
}
