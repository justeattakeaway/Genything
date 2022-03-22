import Foundation

// MARK: - StateData

struct StateData: Codable {
    let canada: Country
    let unitedStates: Country
}

// MARK: JsonResourceCodable

extension StateData: JsonResourceCodable {}
