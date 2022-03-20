import Foundation
import Genything

extension Fake {
    public enum Emails {
        public static var topLevelDomains: AnyGenerator<String> {
            [
                "com",
                "ca",
                "gov",
                "tv",
                "org"
            ].arbitrary
        }
        public static var personalDomains: AnyGenerator<String> {
            [
                "gmail",
                "yahoo",
                "hotmail",
                "aol",
                "msn"
            ].arbitrary
        }
        public static var contacts: AnyGenerator<String> {
            [
                "contact",
                "info",
                "help",
                "about",
                "general",
                "sales",
                "emailus"
            ].arbitrary
        }
        public static var separator: AnyGenerator<String> {
            [".", "_", "-", ""].arbitrary
        }

        public static var personal: AnyGenerator<String> {
            Generators.compose { gen -> String in
                let transformedName = gen(Fake.PersonNames.full()).replacingOccurrences(of: " ", with: gen(separator)).lowercased()
                return "\(transformedName)@\(gen(personalDomains)).\(gen(topLevelDomains))"
            }
        }

        public static func business(_ name: String? = nil) -> AnyGenerator<String> {
            let nameGen: AnyGenerator<String> = {
                if let name = name {
                    return Generators.Constant(name).eraseToAnyGenerator()
                }
                return Fake.BusinessNames.any
            }()
            return Generators.compose { gen -> String in
                let transformedName = String(gen(nameGen).filter { $0.isLetter }).lowercased()
                return "\(gen(contacts))@\(transformedName).\(gen(topLevelDomains))"
            }
        }
    }
}
