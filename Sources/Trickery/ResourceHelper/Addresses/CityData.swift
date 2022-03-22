import Foundation

// MARK: - CityData

struct CityData: Codable {
    let canada: [String]
    let unitedStates: [String]
}

// MARK: JsonResourceCodable

extension CityData: JsonResourceCodable {}
