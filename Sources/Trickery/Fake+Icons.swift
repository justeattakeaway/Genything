import Foundation
import Genything
import SFSafeSymbols

extension Fake {
    public enum Icons {
        @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
        public static let sfSymbols: Gen<SFSymbol> = .ofCases()
    }
}
