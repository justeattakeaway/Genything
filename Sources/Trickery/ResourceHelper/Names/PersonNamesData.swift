import Foundation

// MARK: - PersonNamesData

// Public domain data taken from https://www.gutenberg.org/ebooks/3201
struct PersonNamesData: Codable {
    let names: [String]
}

// MARK: JsonResourceCodable

extension PersonNamesData: JsonResourceCodable {}
