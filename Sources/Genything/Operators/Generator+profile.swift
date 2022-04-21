import Foundation

struct CountingRandomNumberGenerator: RandomNumberGenerator {
    var count: Int = 0
    var rng = SystemRandomNumberGenerator()

    mutating func next() -> UInt64 {
        defer { count += 1 }
        return rng.next()
    }
}

class Profiler<Source: Generator> {
    private let source: Source
    
    private let randomSource: RandomSource = RandomSource(using: CountingRandomNumberGenerator(), originalSeed: nil)
    
    init(source: Source) {
        self.source = source
    }
    
    private var randomizationCount: Int {
        (randomSource.rng.wrapped as! CountingRandomNumberGenerator).count
    }
    private(set) var generatedValuesCount: Int = 0
    
    private(set) var bestRandomizationCount: Int = Int.max
    private(set) var worstRandomizationCount: Int = 0
    var averageRandomizations: Double {
        Double(randomizationCount) / Double(generatedValuesCount)
    }
    
    private(set) var totalGenerationTime: TimeInterval = 0
    private(set) var worstGenerationTime: TimeInterval = 0
    private(set) var bestGenerationTime: TimeInterval = TimeInterval.greatestFiniteMagnitude
    var averageGenerationTime: TimeInterval {
        totalGenerationTime / Double(generatedValuesCount)
    }
    
    func run(iterations: Int) {
        for _ in 0..<iterations {
            iterate()
        }
    }
    
    private func iterate() {
        let randomizationCountBeforeGeneration = randomizationCount
        let timeBeforeGeneration = Date()
        let _ = source.next(randomSource)
        let timeAfterGeneration = Date()
        
        let iterationTime: TimeInterval = timeAfterGeneration.timeIntervalSince(timeBeforeGeneration)
        let iterationRandomizationCount = randomizationCount - randomizationCountBeforeGeneration
        
        if iterationRandomizationCount < bestRandomizationCount {
            bestRandomizationCount = iterationRandomizationCount
        }
        
        if iterationRandomizationCount > worstRandomizationCount {
            worstRandomizationCount = iterationRandomizationCount
        }
        
        if iterationTime < bestGenerationTime {
            bestGenerationTime = iterationTime
        }
        
        if iterationTime > worstGenerationTime {
            worstGenerationTime = iterationTime
        }
        
        generatedValuesCount += 1
        totalGenerationTime += iterationTime
    }
}
