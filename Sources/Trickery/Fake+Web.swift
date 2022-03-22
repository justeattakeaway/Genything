import Foundation
import Genything

extension Fake {
    public enum Web {
        public static var urlScheme: AnyGenerator<String> {
            ["http", "https"].arbitrary
        }

        public static var urlDomain: AnyGenerator<String> {
            Characters.alphanumeric
                .expand(toSizeInRange: 1...63)
                .map { (chars: [Character]) -> String in String(chars) }
        }

        public static var urlSubdomain: AnyGenerator<String> {
            Generators
                .one(of: [
                    Generators.constant("www").eraseToAnyGenerator(),
                    urlDomain,
                ])
        }

        public static var urlTld: AnyGenerator<String> {
            [
                "ca", "pt", "fr", "cu", "in", "us",
                "gov", "gov.mb.ca", "gouv.qc.ca", "gov.cn", "gov",
                "com", "net", "org", "info", "xyz", "co", "me", "online", "biz",
            ].arbitrary
        }

        public static var urlString: AnyGenerator<String> {
            Generators
                .join([urlScheme, Generators.constant("://").eraseToAnyGenerator(),
                       urlSubdomain, Generators.constant(".").eraseToAnyGenerator(),
                       urlDomain, Generators.constant(".").eraseToAnyGenerator(),
                       urlTld])
        }
    }
}
