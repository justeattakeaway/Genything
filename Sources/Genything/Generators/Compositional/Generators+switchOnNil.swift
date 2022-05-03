extension Generators {
    final class SwitchOnNil<StartSource, EndSource>: Generator where StartSource: Generator, EndSource: Generator,
        StartSource.T == EndSource.T? {

        init(start: StartSource, end: EndSource) {
            self.start = start
            self.end = end
        }

        func next(_ randomSource: RandomSource) -> EndSource.T {
            if switched {
                return end.next(randomSource)
            }

            if let candidate = start.next(randomSource) {
                return candidate
            } else {
                switched = true
                return next(randomSource)
            }
        }

        private(set) var switched = false

        private let start: StartSource
        private let end: EndSource
    }
}
