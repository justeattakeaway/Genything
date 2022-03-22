import Foundation
import Genything

extension Fake {
    public enum PersonNames {
        private static let data: PersonNamesData = PersonNamesData.loadJson()
        
        public static var name: AnyGenerator<String> {
            data.names.arbitrary
        }

        public static func full(parts: ClosedRange<Int> = 2...4,
                                separator: String = " ") -> AnyGenerator<String> {
            name
                .expand(toSizeInRange: parts)
                .map {
                    $0.joined(separator: separator)
                }
        }
    }
}
