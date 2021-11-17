import Foundation

struct CityData: Codable {
    let canada: [String]
    let unitedStates: [String]
}

extension CityData: JsonResourceCodable {}
