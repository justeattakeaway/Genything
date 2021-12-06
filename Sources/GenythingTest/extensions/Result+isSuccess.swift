import Foundation

internal extension Result {
    var isSuccess: Bool {
        switch self {
            case .success: return true
            case .failure: return false
        }
    }
}
