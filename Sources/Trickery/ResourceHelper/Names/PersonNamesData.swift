import Foundation

// Public domain data taken from https://www.gutenberg.org/ebooks/3201
struct PersonNamesData: Codable {
    let names: [String]
}

extension PersonNamesData: JsonResourceCodable {}

