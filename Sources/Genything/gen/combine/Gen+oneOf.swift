import Foundation

public extension Gen {
    /**
     * Returns a generator which produces values randomly from any of the provided generator sequence
     */
    static func one(of generators: [Gen<T>]) -> Gen<T> {
        assert(!generators.isEmpty, "List of generators cannot be empty")

        return Gen<Int>
            .from(0..<generators.count)
            .flatMap {
                generators[$0]
            }
    }
}
