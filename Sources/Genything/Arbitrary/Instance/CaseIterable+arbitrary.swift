extension CaseIterable {
    /// Returns: A generator of arbitrary cases
    ///
    /// - Precondition: The receiver's `allCases` collection must not be empty
    ///
    /// - Returns: A generator of the receiver's arbitrary cases
    public static var arbitrary: AnyGenerator<AllCases.Element> {
        let cases = allCases
        assert(!cases.isEmpty, "`CaseIterable.arbitrary` called without cases.")
        return cases.arbitrary
    }
}
