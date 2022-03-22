import Foundation
import Genything

extension Fake {
    public enum Addresses {

        // MARK: Public

        public static var streetNumber: AnyGenerator<String> {
            Fake.Characters.digits
                .expand(toSizeInRange: 1 ... 4)
                .map { String($0) }
        }

        public static var streetName: AnyGenerator<String> {
            streetData.streets.arbitrary
        }

        public static var usCity: AnyGenerator<String> {
            cityData.unitedStates.arbitrary
        }

        public static var caCity: AnyGenerator<String> {
            cityData.canada.arbitrary
        }

        public static var stateCode: AnyGenerator<String> {
            stateData.unitedStates.statesUnsafe.arbitrary.map { $0.code }
        }

        public static var state: AnyGenerator<String> {
            stateData.unitedStates.statesUnsafe.arbitrary.map { $0.name }
        }

        public static var provinceCode: AnyGenerator<String> {
            stateData.canada.statesUnsafe.arbitrary.map { $0.code }
        }

        public static var province: AnyGenerator<String> {
            stateData.canada.statesUnsafe.arbitrary.map { $0.name }
        }

        public static var countryCode: AnyGenerator<String> {
            countryData.countries.arbitrary.map { $0.code }
        }

        public static var country: AnyGenerator<String> {
            countryData.countries.arbitrary.map { $0.name }
        }

        public static var zipCode: AnyGenerator<String> { Fake.Characters.digits
            .expand(toSize: 5)
            .map { String($0) }
        }

        public static var postalCode: AnyGenerator<String> {
            Generators.replacing(
                "&#& #&#",
                with: [
                    (replace: "&", by: Fake.Characters.uppercase.map(String.init)),
                    (replace: "#", by: Fake.Characters.digits.map(String.init)),
                ])
        }

        public static var streetLine: AnyGenerator<String> {
            Generators
                .join([streetNumber, streetName], separator: " ")
        }

        public static var usLastLine: AnyGenerator<String> {
            Generators
                .join([usCity, stateCode], separator: ", ")
                .zip(zipCode, transform: { "\($0) \($1)" })
        }

        public static var caLastLine: AnyGenerator<String> {
            Generators
                .join([caCity, provinceCode], separator: " ")
                .zip(postalCode, transform: { "\($0) \($1)" })
        }

        public static var unitedStates: AnyGenerator<String> {
            Generators
                .join([streetLine, usLastLine], separator: "\n")
        }

        public static var canada: AnyGenerator<String> {
            Generators
                .join([streetLine, caLastLine], separator: "\n")
        }

        // MARK: Private

        private static let streetData = StreetData.loadJson()
        private static let cityData = CityData.loadJson()
        private static let stateData = StateData.loadJson()
        private static let countryData = CountryData.loadJson()

    }
}
