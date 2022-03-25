import Genything

// As you experiment with Genything you may find yourself in need of some Generator which holds a state.

// For example, you may want a generator which counts and returns values

class Counter: Generator {
    var index: Int = 0
    func next(_: RandomSource) -> Int {
        defer { index += 1 }
        return index
    }
}

// As you can see there is an `index` variable which is tracked on the Generator's reference

// Let's initialize the randomized generator to show it in action

let counter = Counter()

// We need a random source

let rs = RandomSource()

// Now we can see what it produces

counter.next(rs) // 0
counter.next(rs) // 1
counter.next(rs) // 2
counter.next(rs) // 3
