import Foundation
import XCTest
import Genything

private func rerunInfo(_ context: Context) -> String {
    if let seed = context.originalSeed {
        return "Re-run test with seed `\(seed)`."
    } else {
        return ""
    }
}

func fail(_ message: String,
          context: Context,
          file: StaticString = #filePath,
          line: UInt = #line
) {
    XCTFail("[Genything] - \(message) \(rerunInfo(context))", file: file, line: line)
}

func fail(_ error: Error,
          context: Context,
          file: StaticString = #filePath,
          line: UInt = #line
) {
    switch error as? GenError {
        case .some(.maxDepthReached):
            XCTFail("[Genything] - Reached maximum generator depth `\(context.maxDepth)`! Check that any calls to `filter` or `unique` are possible with the provided iteration count of `\(context.maxIterations)`. \(rerunInfo(context))", file: file, line: line)
        default:
            XCTFail("[Genything] - Failed with exception `\(error)`. \(rerunInfo(context))", file: file, line: line)
    }
}
