import Foundation
import Genything

extension Fake {
    public enum Addresses {
        private static let streetData = StreetData.loadJson()
        private static let cityData = CityData.loadJson()
        private static let stateData = StateData.loadJson()
        private static let countryData = CountryData.loadJson()

        public static let streetNumber: Gen<String> = Fake.Characters.digits
            .expand(toSizeInRange: 1...4)
            .map { String($0) }
        public static let streetName: Gen<String> = .of(streetData.streets)

        public static let usCity: Gen<String> = .of(cityData.unitedStates)
        public static let caCity: Gen<String> = .of(cityData.canada)

        public static let stateCode: Gen<String> = .of(stateData.unitedStates.statesUnsafe.map { $0.code })
        public static let state: Gen<String> = .of(stateData.unitedStates.statesUnsafe.map { $0.name })

        public static let provinceCode: Gen<String> = .of(stateData.canada.statesUnsafe.map { $0.code })
        public static let province: Gen<String> = .of(stateData.canada.statesUnsafe.map { $0.name })

        public static let countryCode: Gen<String> = .of(countryData.countries.map { $0.code })
        public static let country: Gen<String> = .of(countryData.countries.map { $0.name })

        public static let zipCode: Gen<String> = Fake.Characters.digits
            .expand(toSize: 5)
            .map { String($0) }
        public static let postalCode: Gen<String> = Gen<String>.replacing(
            "&#& #&#",
            with: [
                (replace: "&", by: Fake.Characters.uppercase.map(String.init)),
                (replace: "#", by: Fake.Characters.digits.map(String.init))
            ]
        )

        public static let streetLine: Gen<String> = .join([streetNumber, streetName], separator: " ")
        public static let usLastLine: Gen<String> = .join([usCity, stateCode], separator: ", ")
            .zip(with: zipCode, transform: { "\($0) \($1)" })
        public static let caLastLine: Gen<String> = .join([caCity, provinceCode], separator: " ")
            .zip(with: postalCode, transform: { "\($0) \($1)" })

        public static let unitedStates: Gen<String> = .join([streetLine, usLastLine], separator: "\n")
        public static let canada: Gen<String> = .join([streetLine, caLastLine], separator: "\n")
    }
}
