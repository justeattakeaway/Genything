import Foundation
import Genything
import XCTest

private func rerunInfo(_ randomSource: RandomSource) -> String {
    if let seed = randomSource.originalSeed {
        return "Re-run test with seed `\(seed)`."
    }
    return "Cannot be re-run."
}

func fail(
    _ message: String,
    randomSource: RandomSource,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTFail("[Genything] - \(message) \(rerunInfo(randomSource))", file: file, line: line)
}

func fail(
    _ error: Error,
    randomSource: RandomSource,
    file: StaticString = #filePath,
    line: UInt = #line
) {
    XCTFail("[Genything] - Failed with exception `\(error)`. \(rerunInfo(randomSource))", file: file, line: line)
}
