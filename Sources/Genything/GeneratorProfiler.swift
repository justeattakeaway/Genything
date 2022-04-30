import Foundation

private struct CountingRandomNumberGenerator: RandomNumberGenerator {
    var count = 0
    var rng = SystemRandomNumberGenerator()

    mutating func next() -> UInt64 {
        defer { count += 1 }
        return rng.next()
    }
}

/// A Profile describes the performance of a generator
struct Profile {
    /// The file where the GeneratorProfiler was created
    var file: StaticString
    /// The line where the GeneratorProfiler was created
    var line: UInt

    /// A count of the values that the Generator has generated
    var generations = 0

    /// A sum of the total random number generator events required to generate the current `generations`
    var totalRandomizationCount = 0
    /// The fewest random number generator events required to generate a value
    var bestRandomizationCount = Int.max
    /// The most random number generator events required to generate a value
    var worstRandomizationCount = 0

    /// A sum of the total time required to generate the current `generations`
    var totalGenerationTime: TimeInterval = 0
    /// The smallest amount of time used to generate a value
    var bestGenerationTime = TimeInterval.greatestFiniteMagnitude
    /// The most amount of time used to generate a value
    var worstGenerationTime: TimeInterval = 0

    /// The average random number generator events required to generate a value
    var averageRandomizations: Double {
        Double(totalRandomizationCount) / Double(generations)
    }

    /// The average amount of time used to generate a value
    var averageGenerationTime: TimeInterval {
        totalGenerationTime / Double(generations)
    }


    /// Prints the `Profile` debug description to standard output
    func printReport() {
        print(debugDescription)
    }
}

extension Profile: CustomDebugStringConvertible {
    var debugDescription: String {
        """
        == Profile: \(file)L\(line) ==
        == Generation ==
            total : \(generations)
        == Randomization ==
            total : \(totalRandomizationCount)
            best  : \(bestRandomizationCount)
            worst : \(worstRandomizationCount)
            avg   : \(averageRandomizations)
        == Timing ==
            total : \(totalGenerationTime)
            best  : \(bestGenerationTime)
            worst : \(worstGenerationTime)
            avg   : \(averageGenerationTime)
        """
    }
}

/// The GeneratorProfiler can be used to profile generators in order to measure their performance
class GeneratorProfiler<Source: Generator> {

    /// Initializes a GeneratorProfiler with the Generator it will be profiling
    init(_ source: Source, file: StaticString = #fileID, line: UInt = #line) {
        self.source = source
        profile = Profile(file: file, line: line)
    }


    /// Runs the profiler `iterations` times. For each iteration the profiler is measuring the speed at which the generator was able to produce values, as well as how many randomizations were required.
    func run(iterations: Int) -> Profile {
        for _ in 0..<iterations {
            iteration()
        }
        return profile
    }

    private let source: Source
    private var profile: Profile

    private let randomSource = RandomSource(
        using: CountingRandomNumberGenerator(),
        originalSeed: nil
    )


    /// Pulls the wrapped random number generator which is counting randomizations
    private var randomizationCount: Int {
        (randomSource.rng.wrapped as! CountingRandomNumberGenerator).count
    }


    /// Runs a single iteration of the profiler, measuring statistics for the generation that occurs within
    private func iteration() {
        let randomizationCountBeforeGeneration = randomizationCount
        let timeBeforeGeneration = Date()
        let _ = source.next(randomSource)
        let timeAfterGeneration = Date()

        let iterationTime: TimeInterval = timeAfterGeneration.timeIntervalSince(timeBeforeGeneration)
        let iterationRandomizationCount = randomizationCount - randomizationCountBeforeGeneration

        if iterationRandomizationCount < profile.bestRandomizationCount {
            profile.bestRandomizationCount = iterationRandomizationCount
        }

        if iterationRandomizationCount > profile.worstRandomizationCount {
            profile.worstRandomizationCount = iterationRandomizationCount
        }

        if iterationTime < profile.bestGenerationTime {
            profile.bestGenerationTime = iterationTime
        }

        if iterationTime > profile.worstGenerationTime {
            profile.worstGenerationTime = iterationTime
        }

        profile.generations += 1
        profile.totalGenerationTime += iterationTime
        profile.totalRandomizationCount = randomizationCount
    }
}
