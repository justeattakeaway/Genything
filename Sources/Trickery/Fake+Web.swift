import Foundation
import Genything

extension Fake {
    public enum Web {
        public static let urlScheme: Gen<String> = .of(["http", "https"])

        public static let urlDomain: Gen<String> = Characters.alphanumeric
            .proliferate(in: 1...63)
            .map { (chars: [Character]) -> String in String(chars) }

        public static let urlSubdomain: Gen<String> = .one(of: [
            Gen.constant("www"),
            urlDomain,
        ])

        public static let urlTld: Gen<String> = .of([
            "ca", "pt", "fr", "cu", "in", "us",
            "gov", "gov.mb.ca", "gouv.qc.ca", "gov.cn", "gov",
            "com", "net", "org", "info", "xyz", "co", "me", "online", "biz",
        ])

        public static let urlString: Gen<String> = .join([urlScheme, Gen.constant("://"),
                                                          urlSubdomain, Gen.constant("."),
                                                          urlDomain, Gen.constant("."),
                                                          urlTld])
    }
}
