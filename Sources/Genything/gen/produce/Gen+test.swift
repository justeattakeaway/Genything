import Foundation

public protocol TestResultInformation {
    var iteration: Int { get }
    var seed: UInt64? { get }
}

public struct TestSuccess: TestResultInformation {
    public let iteration: Int
    public let seed: UInt64?
}

public struct TestFailure<T>: Error, TestResultInformation {
    public let iteration: Int
    public let seed: UInt64?
    public let reason: TestFailure.Reason<T>

    public enum Reason<T> {
        case predicate(value: T)
        case error(error: Error)
    }
}

extension Result {
    var isSuccess: Bool {
        switch self {
            case .success: return true
            case .failure: return false
        }
    }
}

public extension Gen {
    func test(iterations: Int? = nil,
               context: Context = .default,
               _ predicate: (T) throws -> Bool) -> Result<TestSuccess, TestFailure<T>> {

        let iterations = iterations ?? context.maxIterations
        var index = 0

        while index < iterations {
            do {
                let value: T = try safeGenerate(context: context)

                if try !predicate(value) {
                    return .failure(
                        TestFailure(
                            iteration: index,
                            seed: context.originalSeed,
                            reason: .predicate(value: value)
                        )
                    )
                }
            } catch {
                return .failure(
                    TestFailure(
                        iteration: index,
                        seed: context.originalSeed,
                        reason: .error(error: error)
                    )
                )
            }

            index += 1
        }

        return .success(TestSuccess(
            iteration: index,
            seed: context.originalSeed
        ))
    }
}
