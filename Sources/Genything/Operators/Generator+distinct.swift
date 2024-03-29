extension Generator where T: Equatable {
    /// Returns: A generator that produces distinct values by comparing against it's memory
    ///
    /// - Warning: If it is no longer possible to generate a distinct value this operator will become infinitely complex and run forever
    ///
    /// - Parameters:
    ///   - memorySize: The maximum size of the FIFO memory which will be used to compare against for distinctness
    ///
    /// - Returns: A `Gen` generator.
    public func distinct(memorySize: Int? = nil) -> AnyGenerator<T> {
        Generators.Distinct(source: self, memorySize: memorySize).eraseToAnyGenerator()
    }

    /// Returns: A generator that produces values which do not match the previously generated value
    ///
    /// - Warning: If it is no longer possible to generate a distinct value this operator will become infinitely complex and run forever
    ///
    /// - Returns: A `Gen` generator.
    public func removeDuplicates() -> AnyGenerator<T> {
        Generators.Distinct(source: self, memorySize: 1).eraseToAnyGenerator()
    }

}

extension Generators {
    final class Distinct<Source>: Generator where Source: Generator, Source.T: Equatable {

        init(source: Source, memorySize: Int? = nil) {
            self.source = source
            memory = FIFODistinctMemory(maxSize: memorySize)
        }

        public func next(_ randomSource: RandomSource) -> Source.T {
            while true {
                let candidate = source.next(randomSource)
                if memory.verifyDistinct(candidate) {
                    return candidate
                }
            }
        }

        private let source: Source
        private var memory: FIFODistinctMemory<Source.T>
    }
}

private struct FIFODistinctMemory<T: Equatable> {
    let maxSize: Int?
    var memory = [T]()

    private mutating func append(_ item: T) {
        defer {
            if let maxSize, memory.count > maxSize {
                memory.removeFirst()
            }
        }
        memory.append(item)
    }

    mutating func verifyDistinct(_ item: T) -> Bool {
        if !memory.contains(item) {
            append(item)
            return true
        }
        return false
    }
}
