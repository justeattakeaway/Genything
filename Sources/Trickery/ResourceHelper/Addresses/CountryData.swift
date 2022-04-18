import Foundation

// MARK: - CountryData

// Public domain data taken from https://gist.github.com/keeguon/2310008
struct CountryData: Codable {
    let countries: [Country]
}

// MARK: - Country

struct Country: Codable {
    let code: String
    let name: String
    let states: [State]?

    var statesUnsafe: [State] {
        assert(states != nil, "`Country.statesUnsafe` was invoked on a country without states data")
        return states!
    }
}

// MARK: - State

struct State: Codable {
    let code: String
    let name: String
}

// MARK: - CountryData + JsonResourceCodable

extension CountryData: JsonResourceCodable {}
