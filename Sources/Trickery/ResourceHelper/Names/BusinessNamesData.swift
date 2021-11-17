import Foundation

struct BusinessNamesData: Codable {
    let generalEndings: [String]
    let restaurantEndings: [String]
    let abreviations: [String]
}

extension BusinessNamesData: JsonResourceCodable {}
