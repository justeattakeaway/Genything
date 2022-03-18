import Foundation
import Genything

extension Fake {
    public enum Addresses {
        private static let streetData = StreetData.loadJson()
        private static let cityData = CityData.loadJson()
        private static let stateData = StateData.loadJson()
        private static let countryData = CountryData.loadJson()

        public static var streetNumber: AnyGenerator<String> {
            Fake.Characters.digits
                .expand(toSizeInRange: 1...4)
                .map { String($0) }
                .eraseToAnyGenerator()
        }

        public static var streetName: AnyGenerator<String> {
            Generators
                .of(Self.streetData.streets)
        }

        public static var usCity: AnyGenerator<String> {
            Generators
                .of(Self.cityData.unitedStates)
                .eraseToAnyGenerator()
        }

        public static var caCity: AnyGenerator<String> {
            Generators
                .of(Self.cityData.canada)
                .eraseToAnyGenerator()
        }

        public static var stateCode: AnyGenerator<String> {
            Generators
                .of(Self.stateData.unitedStates.statesUnsafe.map { $0.code })
                .eraseToAnyGenerator()
        }

        public static var state: AnyGenerator<String> {
            Generators
                .of(Self.stateData.unitedStates.statesUnsafe.map { $0.name })
                .eraseToAnyGenerator()
        }

        public static var provinceCode: AnyGenerator<String> {
            Generators
                .of(Self.stateData.canada.statesUnsafe.map { $0.code })
                .eraseToAnyGenerator()
        }

        public static var province: AnyGenerator<String> {
            Generators
                .of(Self.stateData.canada.statesUnsafe.map { $0.name })
                .eraseToAnyGenerator()
        }

        public static var countryCode: AnyGenerator<String> {
            Generators
                .of(Self.countryData.countries.map { $0.code })
                .eraseToAnyGenerator()
        }

        public static var country: AnyGenerator<String> {
            Generators
                .of(Self.countryData.countries.map { $0.name })
                .eraseToAnyGenerator()
        }

        public static var zipCode: AnyGenerator<String> { Fake.Characters.digits
            .expand(toSize: 5)
            .map { String($0) }
            .eraseToAnyGenerator()
        }

        public static var postalCode: AnyGenerator<String> {
            Generators.replacing(
                "&#& #&#",
                with: [
                    (replace: "&", by: Fake.Characters.uppercase.map(String.init)),
                    (replace: "#", by: Fake.Characters.digits.map(String.init))
                ]
            )
            .eraseToAnyGenerator()
        }

        public static var streetLine: AnyGenerator<String> {
            Generators
                .join([streetNumber, streetName], separator: " ")
                .eraseToAnyGenerator()
        }
        public static var usLastLine: AnyGenerator<String> {
            Generators
                .join([usCity, stateCode], separator: ", ")
                .zip(zipCode, transform: { "\($0) \($1)" })
                .eraseToAnyGenerator()
        }
        public static var caLastLine: AnyGenerator<String> {
            Generators
                .join([caCity, provinceCode], separator: " ")
                .zip(postalCode, transform: { "\($0) \($1)" })
                .eraseToAnyGenerator()
        }

        public static var unitedStates: AnyGenerator<String> {
            Generators
                .join([streetLine, usLastLine], separator: "\n")
                .eraseToAnyGenerator()
        }

        public static var canada: AnyGenerator<String> {
            Generators
                .join([streetLine, caLastLine], separator: "\n")
                .eraseToAnyGenerator()
        }
    }
}
