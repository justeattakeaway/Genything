extension Generator {
    /// Returns: A generator that transforms the receiver into a generator of type `R`
    ///
    /// - Parameters:
    ///   - transform: A function capable of transforming the receiver to a generator of values of type `R`
    ///
    /// - Returns: A `Gen` generator of values of type `R`
    public func flatMap<G: Generator>(_ transform: @escaping (T) -> G) -> AnyGenerator<G.T> {
        Generators.FlatMap(source: self, transform: transform).eraseToAnyGenerator()
    }





}

extension Generators {
    struct FlatMap<Source, Output>: Generator where Source: Generator, Output: Generator {
        let source: Source
        let transform: (Source.T) -> Output

        public func next(_ randomSource: RandomSource) -> Output.T {
            transform(source.next(randomSource)).next(randomSource)
        }
    }
}
