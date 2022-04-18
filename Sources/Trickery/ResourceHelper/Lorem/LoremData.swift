import Foundation

// MARK: - LoremData

struct LoremData: Codable {
    let words: [String]
}

// MARK: JsonResourceCodable

extension LoremData: JsonResourceCodable {}
