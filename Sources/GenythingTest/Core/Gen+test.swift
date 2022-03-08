// Note: No specific dependency on XCTest and _could_ be moved to the main library
import Foundation
import Genything

extension Gen {
    /// Iterates (lazily) over a generator sequence and tests that all values satisfy the given `predicate`
    ///
    /// Will run n times, where n is the provided `iterations` or the context's value
    ///
    /// - Parameters:
    ///   - iterations: The amount of times the sequence should iterate, default's to the context's `maxIterations` value
    ///   - context: The context to be used for generation
    ///   - predicate: A closure that takes an element of the sequence as its argument and returns a Boolean value that indicates whether the passed element satisfies a condition.
    ///
    /// - Returns: A `Result` indicating wether the test passed or failed, with accompanying `TestReport` information
    ///
    func test(iterations: Int? = nil,
              context: Context = .default,
              _ predicate: (T) throws -> Bool) -> Result<SuccessfulTestReport, FailedTestReport<T>> {

        let iterations = iterations ?? context.maxIterations
        var index = 0

        while index < iterations {
            do {
                let value: T = try safe.generate(context: context)

                if try !predicate(value) {
                    return .failure(
                        FailedTestReport(
                            iteration: index,
                            seed: context.originalSeed,
                            reason: .predicate(value: value)
                        )
                    )
                }
            } catch {
                return .failure(
                    FailedTestReport(
                        iteration: index,
                        seed: context.originalSeed,
                        reason: .error(error: error)
                    )
                )
            }

            index += 1
        }

        return .success(SuccessfulTestReport(
            iteration: index,
            seed: context.originalSeed
        ))
    }
}
