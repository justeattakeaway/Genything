import Foundation

// MARK: - BusinessNamesData

struct BusinessNamesData: Codable {
    let generalEndings: [String]
    let restaurantEndings: [String]
    let abreviations: [String]
}

// MARK: JsonResourceCodable

extension BusinessNamesData: JsonResourceCodable {}
