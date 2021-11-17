import Foundation

// Public domain data taken from https://gist.github.com/keeguon/2310008
struct CountryData: Codable {
    let countries: [Country]
}

struct Country: Codable {
    let code: String
    let name: String
    let states: [State]?

    var statesUnsafe: [State] {
        assert(states != nil, "`Country.statesUnsafe` was invoked on a country without states data")
        return states!
    }
}

struct State: Codable {
    let code: String
    let name: String
}

extension CountryData: JsonResourceCodable {}
