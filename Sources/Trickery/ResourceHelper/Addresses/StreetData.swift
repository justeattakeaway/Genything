import Foundation

struct StreetData: Codable {
    let streets: [String]
}

extension StreetData: JsonResourceCodable {}
