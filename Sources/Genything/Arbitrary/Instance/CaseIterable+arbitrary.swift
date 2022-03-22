extension CaseIterable {
    public static var arbitrary: AnyGenerator<AllCases.Element> {
        let cases = allCases
        assert(!cases.isEmpty, "`CaseIterable.arbitrary` called without cases.")
        return cases.arbitrary
    }
}
