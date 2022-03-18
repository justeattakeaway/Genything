import Foundation
import Genything

extension Fake {
    public enum BusinessNames {
        private static let data: BusinessNamesData = BusinessNamesData.loadJson()

        public static var restaurant: AnyGenerator<String> {
            Fake.PersonNames.first
                .zip(Generators.of(data.restaurantEndings)) { "\($0)'s \($1)" }
                .eraseToAnyGenerator()
        }
        public static var general: AnyGenerator<String> {
            Generators.one(of: [
                Generators.zip(Fake.PersonNames.first, Generators.of(data.generalEndings)) { "\($0)'s \($1)" },
                Generators.zip(Fake.PersonNames.first, Generators.of(data.abreviations)) {  "\($0) \($1)" }
            ])
            .eraseToAnyGenerator()
        }
        public static var any: AnyGenerator<String> {
            Generators
                .one(of: [ restaurant, general ])
                .eraseToAnyGenerator()
        }
    }
}
