import Foundation

// MARK: - StreetData

struct StreetData: Codable {
    let streets: [String]
}

// MARK: JsonResourceCodable

extension StreetData: JsonResourceCodable {}
