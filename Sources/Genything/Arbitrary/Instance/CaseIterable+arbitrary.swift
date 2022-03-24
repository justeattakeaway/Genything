extension CaseIterable {
    /// Returns: A generator of arbitrary cases
    ///
    /// - Precondition: The receiver's `allCases` collection must not be empty
    ///
    /// - Returns: A generator of the receiver's arbitrary cases
    public static var arbitrary: AnyGenerator<AllCases.Element> {
        RandomCase().eraseToAnyGenerator()
    }
}

private struct RandomCase<T>: Generator where T: CaseIterable {
    private let cases: T.AllCases

    public init() {
        let cases = T.allCases
        assert(!cases.isEmpty, "`CaseIterable.arbitrary` called without cases.")
        self.cases = cases
    }

    public func next(_ randomSource: RandomSource) -> T {
        cases.randomElement(using: &randomSource.rng)!
    }
}
