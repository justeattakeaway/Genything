import Foundation
import Genything

extension Fake {
    public enum BusinessNames {
        private static let data: BusinessNamesData = BusinessNamesData.loadJson()

        public static var restaurant: AnyGenerator<String> {
            Fake.PersonNames.name
                .zip(Generators.of(data.restaurantEndings)) { "\($0)'s \($1)" }
        }
        public static var general: AnyGenerator<String> {
            Generators.one(of: [
                Generators.zip(Fake.PersonNames.name, Generators.of(data.generalEndings)) { "\($0)'s \($1)" },
                Generators.zip(Fake.PersonNames.name, Generators.of(data.abreviations)) {  "\($0) \($1)" }
            ])
        }
        public static var any: AnyGenerator<String> {
            Generators
                .one(of: [restaurant, general])
        }
    }
}
