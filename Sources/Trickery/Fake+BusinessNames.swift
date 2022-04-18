import Foundation
import Genything

extension Fake {
    public enum BusinessNames {
        private static let data: BusinessNamesData = .loadJson()

        public static var restaurant: AnyGenerator<String> {
            Fake.PersonNames.name
                .zip(data.restaurantEndings.arbitrary) { "\($0)'s \($1)" }
        }

        public static var general: AnyGenerator<String> {
            Generators.one(of: [
                Generators.zip(Fake.PersonNames.name, data.generalEndings.arbitrary) { "\($0)'s \($1)" },
                Generators.zip(Fake.PersonNames.name, data.abreviations.arbitrary) { "\($0) \($1)" },
            ])
        }

        public static var any: AnyGenerator<String> {
            Generators
                .one(of: [restaurant, general])
        }
    }
}
