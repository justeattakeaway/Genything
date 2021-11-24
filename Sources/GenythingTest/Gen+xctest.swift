import Foundation
import Genything
import XCTest

extension TestFailure {
    var description: String {
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
                XCTFail(info.description, file: file, line: line)
        }
    }
}
