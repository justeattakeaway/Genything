import Foundation

public extension Gen {
    func replacingOccurrences(of character: Character, in source: String) -> Gen<String> {
        Gen<String> { ctx in
            var result: String = ""

            for ch in source {
                if ch == character {
                    result += "\(generate(using: ctx))"
                } else {
                    result.append(ch)
                }
            }

            return result
        }
    }
}
