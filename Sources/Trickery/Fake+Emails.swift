import Foundation
import Genything

extension Fake {
    public enum Emails {
        public static let topLevelDomains: Gen<String> = .of([
            "com",
            "ca",
            "gov",
            "tv",
            "org"
        ])
        public static let personalDomains: Gen<String> = .of([
            "gmail",
            "yahoo",
            "hotmail",
            "aol",
            "msn"
        ])
        public static let contacts: Gen<String> = .of([
            "contact",
            "info",
            "help",
            "about",
            "general",
            "sales",
            "emailus"
        ])
        public static let separator: Gen<String> = .of([".", "_", "-", ""])

        public static let personal = Gen<String>.zip(Fake.PersonNames.full, separator, personalDomains, topLevelDomains) { name, separator, personalDomain, topLevelDomain in
            let transformedName = name.replacingOccurrences(of: " ", with: separator).lowercased()
            return "\(transformedName)@\(personalDomain).\(topLevelDomain)"
        }

        public static func business(_ name: String? = nil) -> Gen<String> {
            let nameGen = name == nil ? Fake.BusinessNames.any : Gen<String>.constant(name!)
            return Gen<String>.zip(nameGen, contacts, topLevelDomains) { name, contacts, topLevelDomains in
                let transformedName = String(name.filter { $0.isLetter }).lowercased()
                return "\(contacts)@\(transformedName).\(topLevelDomains)"
            }
        }
    }
}
