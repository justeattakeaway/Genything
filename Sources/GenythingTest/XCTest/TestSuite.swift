public struct TestSuite {
    public let config: TestConfig

    public init(config: TestConfig = .default()) {
        self.config = config
    }
}

public struct Assertion {
    public func callAsFunction(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        self.true(expression(), message: message, file: file, line: line)
    }

    public func equal<T: Equatable>(
        _ expression1: @autoclosure () -> T,
        _ expression2: @autoclosure () -> T,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let value1 = expression1()
        let value2 = expression2()
        guard value1 == value2 else {
            return fail(
                message ?? "Assertion Failed. Expected \(value1). Received \(value2).",
                randomSource: config.randomSource,
                file: file,
                line: line
            )
        }
    }

    public func identical(
        _ expression1: @autoclosure () -> AnyObject?,
        _ expression2: @autoclosure () -> AnyObject?,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let value1 = expression1()
        let value2 = expression2()
        guard value1 === value2 else {
            return fail(
                message ?? "Assertion Failed. Expected \(String(describing: value1)). Received \(String(describing: value2)).",
                randomSource: config.randomSource,
                file: file,
                line: line
            )
        }
    }

    public func `nil`(
        _ expression: @autoclosure () -> Any?,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard expression() != nil else {
            return fail(
                message ?? "Assertion Failed. Expected nil.",
                randomSource: config.randomSource,
                file: file,
                line: line
            )
        }
    }

    public func `false`(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard !expression() else {
            return fail(
                message ?? "Assertion Failed. Expected nil.",
                randomSource: config.randomSource,
                file: file,
                line: line
            )
        }
    }

    public func `true`(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        guard expression() else {
            return fail(
                message ?? "Assertion Failed",
                randomSource: config.randomSource,
                file: file,
                line: line
            )
        }
    }

    let config: TestConfig

}
