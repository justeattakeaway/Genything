import Foundation
import Genything

// MARK: - GenLibData

private struct GenLibData: Codable {
    /// A template which supports the following substitutions:
    /// `verb`: A past tense verb
    /// `verb-past`: A past tense verb
    /// `noun`: Noun
    /// `nouns`: Plural Noun
    /// `adjective`: Adjective
    let scripts: [String]
    let words: Words

    struct Words: Codable {
        let nouns: [String]
        let verbs: Verbs
        let adjectives: [String]

        struct Verbs: Codable {
            let regular: [String]
            let past: [String]
        }
    }
}

// MARK: - GenLibsScriptGenerator

struct GenLibsScriptGenerator {
    private static let data = Bundle.main.url(forResource: "genlib", withExtension: "json")
        .flatMap {
            try? Data(contentsOf: $0)
        }
        .flatMap {
            try? JSONDecoder().decode(GenLibData.self, from: $0)
        }!

    let generator = Gen.of(data.scripts).flatMap {
        .replacing($0, with: [
            (replace: "${verb}", by: Gen.of(data.words.verbs.regular)),
            (replace: "${verb-past}", by: Gen.of(data.words.verbs.past)),
            (replace: "${noun}", by: Gen.of(data.words.nouns)),
            (replace: "${nouns}", by: Gen.of(data.words.nouns).map { $0 + "s" }),
            (replace: "${adjective}", by: Gen.of(data.words.adjectives)),
        ])
    }
}
