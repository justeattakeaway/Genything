import Foundation
import Genything

extension Fake {
    public enum Lorem {
        private static let data: LoremData = LoremData.loadJson()
        
        public static var word: AnyGenerator<String> {
            data.words.arbitrary
        }

        public static func sentence(wordCountRange: ClosedRange<Int> = 5...20) -> AnyGenerator<String> {
            word
                .expand(toSizeInRange: wordCountRange)
                .map {
                    $0.joined(separator: " ")
                }
                .map {
                    $0.prefix(1).capitalized + $0.dropFirst() + "."
                }
        }
    }
}
