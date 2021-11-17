import Foundation
import Genything

extension Fake {
    public enum PersonNames {
        private static let data: PersonNamesData = PersonNamesData.loadJson()
        
        public static let first: Gen<String> = .of(data.names)
        // TODO: expand with bias from distribution
        public static let middle: Gen<String> = .of(data.names).expand(toSizeInRange: 0...1).map {$0.joined(separator: " ")}
        public static let last: Gen<String> = .of(data.names)
        public static let full: Gen<String> = .zip(first, middle, last) {[$0, $1, $2].filter {!$0.isEmpty}.joined(separator: " ")}
    }
}
