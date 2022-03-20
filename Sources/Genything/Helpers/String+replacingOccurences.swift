/// Replaces instances of `target` in the receiver `String` by the response of the callback `replacement`
///
/// - Parameters:
///   - target: The substring that should be replaced
///   - replacement: A callback which returns the value to use for replacement
///
/// - Returns: A `String` with all instances of `target` replaced by the `replacement`
extension String {
    func replacingOccurences(of target: String, _ replacement: @escaping () -> String) -> String {
        var result = self

        while let rangeToReplace = result.range(of: target) {
            result = result.replacingCharacters(in: rangeToReplace, with: replacement())
        }

        return result
    }
}
