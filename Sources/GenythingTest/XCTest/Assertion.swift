public struct Assertion {

    public mutating func callAsFunction(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        self.true(expression(), message: message, file: file, line: line)
    }

    public mutating func equal<T: Equatable>(
        _ expression1: @autoclosure () -> T,
        _ expression2: @autoclosure () -> T,
        message: String? = nil,
        file _: StaticString = #filePath,
        line _: UInt = #line
    ) {
        let value1 = expression1()
        let value2 = expression2()
        guard value1 == value2 else {
            return failure = message ?? "Assertion Failed. (\(value1)) is not equal to (\(value2))."
        }
    }

    public mutating func identical(
        _ expression1: @autoclosure () -> AnyObject?,
        _ expression2: @autoclosure () -> AnyObject?,
        message: String? = nil,
        file _: StaticString = #filePath,
        line _: UInt = #line
    ) {
        let value1 = expression1()
        let value2 = expression2()
        guard value1 === value2 else {
            return failure = message ??
                "Assertion Failed. Expected \(String(describing: value1)). Received \(String(describing: value2))."
        }
    }

    public mutating func `nil`(
        _ expression: @autoclosure () -> Any?,
        message: String? = nil,
        file _: StaticString = #filePath,
        line _: UInt = #line
    ) {
        guard expression() != nil else {
            return failure = message ?? "Assertion Failed. Expected nil."
        }
    }

    public mutating func `false`(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file _: StaticString = #filePath,
        line _: UInt = #line
    ) {
        guard !expression() else {
            return failure = message ?? "Assertion Failed. Expected a false expression."
        }
    }

    public mutating func `true`(
        _ expression: @autoclosure () -> Bool,
        message: String? = nil,
        file _: StaticString = #filePath,
        line _: UInt = #line
    ) {
        guard expression() else {
            return failure = message ?? "Assertion Failed."
        }
    }

    var failure: String? = nil

    let config: TestConfig
}
