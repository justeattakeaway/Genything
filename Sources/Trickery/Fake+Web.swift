import Foundation
import Genything

extension Fake {
    public enum Web {
        public static var urlScheme: AnyGenerator<String> {
            Generators
                .of(["http", "https"])
                .eraseToAnyGenerator()
        }

        public static var urlDomain: AnyGenerator<String> {
            Characters.alphanumeric
                .expand(toSizeInRange: 1...63)
                .map { (chars: [Character]) -> String in String(chars) }
                .eraseToAnyGenerator()
        }

        public static var urlSubdomain: AnyGenerator<String> {
            Generators
                .one(of: [
                    Generators.Constant("www").eraseToAnyGenerator(),
                    urlDomain,
                ])
                .eraseToAnyGenerator()
        }

        public static var urlTld: AnyGenerator<String> {
            Generators
                .of([
                    "ca", "pt", "fr", "cu", "in", "us",
                    "gov", "gov.mb.ca", "gouv.qc.ca", "gov.cn", "gov",
                    "com", "net", "org", "info", "xyz", "co", "me", "online", "biz",
                ])
                .eraseToAnyGenerator()
        }

        public static var urlString: AnyGenerator<String> {
            Generators
                .join([urlScheme, Generators.Constant("://").eraseToAnyGenerator(),
                       urlSubdomain, Generators.Constant(".").eraseToAnyGenerator(),
                       urlDomain, Generators.Constant(".").eraseToAnyGenerator(),
                       urlTld])
                .eraseToAnyGenerator()
        }
    }
}
