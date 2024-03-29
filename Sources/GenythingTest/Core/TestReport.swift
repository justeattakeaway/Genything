// Note: No specific dependency on XCTest and _could_ be moved to the main library
import Foundation

// MARK: - TestReport

/// Generic information about a test
protocol TestReport {
    /// The number of iterations that ran during the test.
    var iteration: Int { get }
    /// The seed which was used to start the test. Can be used to replay a test.
    var seed: UInt64? { get }
}

// MARK: - SuccessfulTestReport

/// Information regarding a successful test
struct SuccessfulTestReport: TestReport {
    let iteration: Int
    let seed: UInt64?
}

// MARK: - FailedTestReport

/// Information regarding a test's failure
struct FailedTestReport<T>: Error, TestReport {
    let iteration: Int
    let seed: UInt64?
    let reason: FailedTestReport.Reason<T>

    /// A reason for the test's failure
    enum Reason<T> {
        case predicate(value: T)
    }
}
