import Foundation
import Genything

#if DEBUG
public func XCTFail(
    _ message: String,
    file: StaticString,
    line: UInt
) {
    handler(nil, true, "\(file)", line, message, nil)
}

private typealias XCTFailureHandler = @convention(c) (
    AnyObject?, Bool, UnsafePointer<CChar>, UInt, String, String?
) -> Void

private let handler = unsafeBitCast(
    dlsym(dlopen(nil, RTLD_LAZY), "_XCTFailureHandler"),
    to: XCTFailureHandler.self
)
#else
public func XCTFail(
    _: String = "",
    file _: StaticString,
    line _: UInt
) {}
#endif

private func rerunInfo(_ randomSource: RandomSource) -> String {
    if let seed = randomSource.originalSeed {
        return "Re-run with seed `\(seed)`."
    }
    return ""
}

func fail(
    _ message: String,
    randomSource: RandomSource,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTFail("\(message) \(rerunInfo(randomSource))", file: file, line: line)
}

func fail(
    _ error: Error,
    randomSource: RandomSource,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTFail("Test failed with exception `\(error)`. \(rerunInfo(randomSource))", file: file, line: line)
}
