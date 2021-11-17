import Foundation
import Genything

extension Fake {
    public enum BusinessNames {
        private static let data: BusinessNamesData = BusinessNamesData.loadJson()
        public static let restaurant: Gen<String> = .zipWith(Fake.PersonNames.first, Gen<String>.of(data.restaurantEndings)) { "\($0)'s \($1)" }
        public static let general: Gen<String> = .one(of: [
            .zipWith(Fake.PersonNames.first, Gen<String>.of(data.generalEndings)) { "\($0)'s \($1)" },
            .zipWith(Fake.PersonNames.first, Gen<String>.of(data.abreviations)) {  "\($0) \($1)" }
        ])
        public static let any: Gen<String> = .one(of: [ restaurant, general ])
    }
}


