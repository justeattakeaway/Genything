import Foundation
import Genything

extension Fake {
    public enum PersonNames {
        private static let data: PersonNamesData = PersonNamesData.loadJson()
        
        public static var first: AnyGenerator<String> {
            Generators
                .of(data.names)
                .eraseToAnyGenerator()
        }

        public static var middle: AnyGenerator<String> {
            Generators
                .of(data.names)
                .expand(toSizeInRange: 0...1)
                .map { $0.joined(separator: " ") }
                .eraseToAnyGenerator()
        }


        public static var last: AnyGenerator<String> { first }

        public static var full: AnyGenerator<String> {
            first
                .zip(middle, last) {
                    [$0, $1, $2]
                        .filter { !$0.isEmpty }
                        .joined(separator: " ")
                }
                .eraseToAnyGenerator()
        }
    }
}
