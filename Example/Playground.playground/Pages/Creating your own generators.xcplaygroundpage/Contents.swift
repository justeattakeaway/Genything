import Foundation
import Genything

/*:
 We can do a lot just by using the generators and operators which Genything provides
 
 But you may have an idea for a new generic Generator, or wish to conform an existing type.
 
 Anything can be a Generator by conforming to the `Generator` protocol
 */
struct RandomDate: Generator {
    let min = Date.distantPast.timeIntervalSince1970
    let max = Date.distantFuture.timeIntervalSince1970

    func next(_ randomSource: RandomSource) -> Date {
        let randomInterval = TimeInterval.random(in: min...max, using: &randomSource.rng)
        return Date(timeIntervalSince1970: randomInterval)
    }
}

RandomDate().next(.predetermined()) /// Returns: An arbitrary date




/*:
 While abstracting randomness is a large part of what makes Genything great, there is no requirement to do so:
 */
struct CurrentDate: Generator {
    func next(_: RandomSource) -> Date {
        Date()
    }
}

CurrentDate().next(.predetermined()) /// Returns: The current date



/*:
 And a generator may even hold some state.
 */
class Counter: Generator {
    var index = 0

    func next(_: RandomSource) -> Int {
        defer { index += 1 }
        return index
    }
}




//: Genything's operators are themselves just Generators
struct Map<Source, T>: Generator where Source: Generator {
    let source: Source
    let transform: (Source.T) -> T

    public func next(_ randomSource: RandomSource) -> T {
        transform(source.next(randomSource))
    }
}

let unixTimeGenerator = Map(source: CurrentDate()) { date in
    date.timeIntervalSince1970
}

unixTimeGenerator.next(.predetermined()) /// Returns: An arbitrary unix time




//: We can follow the Map example, and create a purpose-built generator:
struct FormatDate<Source>: Generator where Source: Generator, Source.T == Date {
    let source: Source
    let formatter: DateFormatter

    init(source: Source, formatter: DateFormatter = {
        let defaultFormatter = DateFormatter()
        defaultFormatter.dateStyle = .short
        defaultFormatter.timeStyle = .full
        return defaultFormatter
    }()) {
        self.source = source
        self.formatter = formatter
    }

    public func next(_ randomSource: RandomSource) -> String {
        formatter.string(from: source.next(randomSource))
    }
}

FormatDate(source: CurrentDate()).next(.predetermined()) /// Returns: The current date, formatted
FormatDate(source: RandomDate()).next(.predetermined()) /// Returns: An arbitrary date, formatted




//: To add your operator to Genything's DSL we can register an extension function.
extension Generator where T == Date {
    func applyDateFormatting() -> AnyGenerator<String> {
        FormatDate(source: self).eraseToAnyGenerator()
    }
}

RandomDate()
    .applyDateFormatting()
    .next(.predetermined())
