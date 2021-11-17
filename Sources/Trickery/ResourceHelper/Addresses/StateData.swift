import Foundation

struct StateData: Codable {
    let canada: Country
    let unitedStates: Country
}

extension StateData: JsonResourceCodable {}
