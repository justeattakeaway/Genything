import Genything

let gen = (0...10).arbitrary.randomize(with: RandomSource()).sequence()
