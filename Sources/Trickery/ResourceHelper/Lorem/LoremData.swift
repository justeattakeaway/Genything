import Foundation

struct LoremData: Codable {
    let words: [String]
}

extension LoremData: JsonResourceCodable {}
