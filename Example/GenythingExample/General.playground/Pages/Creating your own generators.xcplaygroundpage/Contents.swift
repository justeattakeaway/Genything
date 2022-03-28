import Genything
import Foundation

// - Information about how to create your own Generators
// - Not just using the operators that we offer
// - Examples of how our current operators are created, and how they are types conforming to Generator


// We can do a lot using the generators and composable operators Genything provides

// TODO: Example

// But there may be situations where you'd like to create generators in a more imperative way.

// To do this, one must simply conform to the `Generator` protocol

/// A generator of arbitrary Dates
struct RandomDate: Generator {
    let min = Date.distantPast.timeIntervalSince1970
    let max = Date.distantFuture.timeIntervalSince1970

    func next(_ randomSource: RandomSource) -> Date {
        let randomInterval = TimeInterval.random(in: min...max, using: &randomSource.rng)
        return Date(timeIntervalSince1970: randomInterval)
    }
}

RandomDate().next(RandomSource()) /// Returns: An arbitrary date

// It's also important to mention that while abstracting randomness is a large part of what makes Genything great, there is no requirement:

/// A generator which always provides the systems current Date
struct CurrentDate: Generator {
    func next(_: RandomSource) -> Date {
        Date()
    }
}

CurrentDate().next(RandomSource()) /// Returns: The current date

// Many Genything operators are themselves just Generators:

struct MapOperator<Source, T>: Generator where Source: Generator {
    let source: Source
    let transform: (Source.T) -> T

    public func next(_ randomSource: RandomSource) -> T {
        transform(source.next(randomSource))
    }
}

let unixTimeGenerator = MapOperator(source: CurrentDate()) { date in
    date.timeIntervalSince1970
}

unixTimeGenerator.next(RandomSource()) /// Returns: An arbitrary unix time as `TimeInterval`

// We can use this knowledge to create our own operators:

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

FormatDate(source: CurrentDate()).next(RandomSource()) /// Returns: The current date, formatted
FormatDate(source: RandomDate()).next(RandomSource()) /// Returns: An arbitrary date, formatted
