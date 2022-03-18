import Foundation
import Genything

extension Fake {
    public enum Characters {
        public static var lowercase: AnyGenerator<Character> {
            Generators
                .from("a"..."z")
                .eraseToAnyGenerator()
        }
        public static var uppercase: AnyGenerator<Character> {
            Generators
                .from("A"..."Z")
                .eraseToAnyGenerator()
        }
        public static var digits: AnyGenerator<Character> {
            Numerics.digits
                .map { Character("\($0)") }
                .eraseToAnyGenerator()
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
                .eraseToAnyGenerator()
        }
        public static var latinExtended: AnyGenerator<Character> {
            Generators
                .from("Ā"..."ỳ")
                .eraseToAnyGenerator()
        }
        public static var ipaExtensions: AnyGenerator<Character> {
            Generators
                .from("ə"..."ʒ")
                .eraseToAnyGenerator()
        }
        public static var spacingModifier: AnyGenerator<Character> {
            Generators
                .from("ʰ"..."˿")
                .eraseToAnyGenerator()
        }
        public static var greekAndCoptic: AnyGenerator<Character> {
            Generators
                .from("Ͱ"..."Ͽ")
                .eraseToAnyGenerator()
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
                .eraseToAnyGenerator()
        }
    }
}
