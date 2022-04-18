import Foundation
import Genything

extension Fake {
    public enum Characters {
        public static var lowercase: AnyGenerator<Character> {
            ("a" ... "z").arbitrary
        }

        public static var uppercase: AnyGenerator<Character> {
            ("A" ... "Z").arbitrary
        }

        public static var digits: AnyGenerator<Character> {
            Numerics.digits
                .map { Character("\($0)") }
        }

        public static var alphanumeric: AnyGenerator<Character> {
            Generators
                .one(of: [
                    lowercase,
                    uppercase,
                    digits,
                ])
        }

        // Categories Taken from https://en.wikipedia.org/wiki/List_of_Unicode_characters
        public static var punctuationAndSymbols: AnyGenerator<Character> {
            Generators
                .one(of: [
                    (" " ... "/").arbitrary,
                    (":" ... "@").arbitrary,
                    ("[" ... "`").arbitrary,
                    ("{" ... "~").arbitrary,
                    ("¡" ... "¿").arbitrary,
                ])
        }

        public static var latinAccentsAndDiacritcs: AnyGenerator<Character> {
            ("À" ... "ÿ").arbitrary
        }

        public static var latinExtended: AnyGenerator<Character> {
            ("Ā" ... "ỳ").arbitrary
        }

        public static var ipaExtensions: AnyGenerator<Character> {
            ("ə" ... "ʒ").arbitrary
        }

        public static var spacingModifier: AnyGenerator<Character> {
            ("ʰ" ... "˿").arbitrary
        }

        public static var greekAndCoptic: AnyGenerator<Character> {
            ("Ͱ" ... "Ͽ").arbitrary
        }

        public static var allButAlphanumeric: AnyGenerator<Character> {
            Generators
                .one(of: [
                    punctuationAndSymbols,
                    latinAccentsAndDiacritcs,
                    latinExtended,
                    ipaExtensions,
                    spacingModifier,
                    greekAndCoptic,
                ])
        }
    }
}
