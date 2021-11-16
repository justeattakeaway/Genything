import Foundation

struct BusinessNamesData: Codable {
    let generalEndings: [String]
    let restaurantEndings: [String]
    let abreiviations: [String]
}

extension BusinessNamesData: JsonResourceCodable {}
