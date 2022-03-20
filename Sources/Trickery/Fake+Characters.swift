import Foundation
import Genything

extension Fake {
    public enum Characters {
        public static var lowercase: AnyGenerator<Character> {
            Generators
                .from("a"..."z")
        }
        public static var uppercase: AnyGenerator<Character> {
            Generators
                .from("A"..."Z")
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
                    digits
                ])
        }

        // Categories Taken from https://en.wikipedia.org/wiki/List_of_Unicode_characters
        public static var punctuationAndSymbols: AnyGenerator<Character> {
            Generators
                .one(of: [
                    Generators.from(" "..."/"),
                    Generators.from(":"..."@"),
                    Generators.from("["..."`"),
                    Generators.from("{"..."~"),
                    Generators.from("¡"..."¿")
                ])
        }
        public static var latinAccentsAndDiacritcs: AnyGenerator<Character> {
            Generators
                .from("À"..."ÿ")
        }
        public static var latinExtended: AnyGenerator<Character> {
            Generators
                .from("Ā"..."ỳ")
        }
        public static var ipaExtensions: AnyGenerator<Character> {
            Generators
                .from("ə"..."ʒ")
        }
        public static var spacingModifier: AnyGenerator<Character> {
            Generators
                .from("ʰ"..."˿")
        }
        public static var greekAndCoptic: AnyGenerator<Character> {
            Generators
                .from("Ͱ"..."Ͽ")
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
