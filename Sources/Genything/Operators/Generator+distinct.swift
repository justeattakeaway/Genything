extension Generator where T: Equatable {
    /// Returns: A generator that produces distinct values by comparing against it's memory of size `memorySize` (where 0 represents an infinite memory)
    ///
    /// - Warning: If it is no longer possible to generate a distinct value this operator will become infinitely complex and run forever
    ///
    /// - Parameters:
    ///   - memorySize: The maximum size of the FIFO memory that will be checked for uniqueness
    ///
    /// - Returns: A `Gen` generator.
    func distinct(memorySize: Int = 0) -> AnyGenerator<T> {
        Distinct(source: self, memorySize: memorySize).eraseToAnyGenerator()
    }

    /// Returns: A generator that produces values which do not match the previously generated value
    ///
    /// - Warning: If it is no longer possible to generate a distinct value this operator will become infinitely complex and run forever
    ///
    /// - Returns: A `Gen` generator.
    func removeDuplicates() -> AnyGenerator<T> {
        Distinct(source: self, memorySize: 1).eraseToAnyGenerator()
    }
}

// MARK: - Filter

private struct FIFODistinctMemory<T: Equatable> {
    let maxSize: Int
    var memory = [T]()

    private mutating func append(_ item: T) {
        defer {
            if memory.count > maxSize {
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

private class Distinct<Source>: Generator where Source: Generator, Source.T: Equatable {

    init(source: Source, memorySize: Int) {
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

    let source: Source
    var memory: FIFODistinctMemory<Source.T>
}

