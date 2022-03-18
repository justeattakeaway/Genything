import Foundation
import Genything

extension Fake {
    public enum Emails {
        public static var topLevelDomains: AnyGenerator<String> {
            Generators
                .of([
                    "com",
                    "ca",
                    "gov",
                    "tv",
                    "org"
                ])
                .eraseToAnyGenerator()
        }
        public static var personalDomains: AnyGenerator<String> {
            Generators
                .of([
                    "gmail",
                    "yahoo",
                    "hotmail",
                    "aol",
                    "msn"
                ])
                .eraseToAnyGenerator()
        }
        public static var contacts: AnyGenerator<String> {
            Generators
                .of([
                    "contact",
                    "info",
                    "help",
                    "about",
                    "general",
                    "sales",
                    "emailus"
                ])
                .eraseToAnyGenerator()
        }
        public static var separator: AnyGenerator<String> {
            Generators
                .of([".", "_", "-", ""])
                .eraseToAnyGenerator()
        }

        public static var personal: AnyGenerator<String> {
            Generators.Composer { gen -> String in
                let transformedName = gen(Fake.PersonNames.full).replacingOccurrences(of: " ", with: gen(separator)).lowercased()
                return "\(transformedName)@\(gen(personalDomains)).\(gen(topLevelDomains))"
            }.eraseToAnyGenerator()
        }

        public static func business(_ name: String? = nil) -> AnyGenerator<String> {
            let nameGen: AnyGenerator<String> = {
                if let name = name {
                    return Generators.Constant(name).eraseToAnyGenerator()
                }
                return Fake.BusinessNames.any
            }()
            return Generators.Composer { gen -> String in
                let transformedName = String(gen(nameGen).filter { $0.isLetter }).lowercased()
                return "\(gen(contacts))@\(transformedName).\(gen(topLevelDomains))"
            }.eraseToAnyGenerator()
        }
    }
}
