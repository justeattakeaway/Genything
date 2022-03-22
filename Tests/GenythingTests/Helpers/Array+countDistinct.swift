extension Sequence where Element: Hashable {
    func countDistinct() -> [Element:Int] {
        reduce(into: [:]) { $0[$1, default: 0] += 1 }
    }
}
