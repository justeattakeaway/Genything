extension Generator {
    /// - Returns: A generator which generates values by returning the result of the provided closure
    public func generate(_ generate: @escaping (RandomSource) -> T) -> AnyGenerator<T> {
        AnyGenerator { rs in
            generate(rs)
        }
    }
}
