import Foundation
import Genything

extension Fake {
    public enum Characters {
        public static let lowercase: Gen<Character> = .from("a"..."z")
        public static let uppercase: Gen<Character> = .from("A"..."Z")
        public static let digits: Gen<Character> = Numerics.digits.map { Character("\($0)") }
        public static let alphanumeric: Gen<Character> = .one(of: [
            lowercase,
            uppercase,
            digits
        ])

        // Categories Taken from https://en.wikipedia.org/wiki/List_of_Unicode_characters
        public static let punctuationAndSymbols: Gen<Character> = .one(of: [
            .from(" "..."/"),
            .from(":"..."@"),
            .from("["..."`"),
            .from("{"..."~"),
            .from("¡"..."¿")
        ])
        public static let latinAccentsAndDiacritcs: Gen<Character> = .from("À"..."ÿ")
        public static let latinExtended: Gen<Character> = .from("Ā"..."ỳ")
        public static let ipaExtensions: Gen<Character> = .from("ə"..."ʒ")
        public static let spacingModifier: Gen<Character> = .from("ʰ"..."˿")
        public static let greekAndCoptic: Gen<Character> = .from("Ͱ"..."Ͽ")
        public static let allButAlphanumeric: Gen<Character> = .one(of: [
            punctuationAndSymbols,
            latinAccentsAndDiacritcs,
            latinExtended,
            ipaExtensions,
            spacingModifier,
            greekAndCoptic,
        ])
    }
}
