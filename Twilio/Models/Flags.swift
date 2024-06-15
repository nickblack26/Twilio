import Foundation
import SwiftData

// MARK: - Flags
@Model
class Flags {
    var allowConcurrentCalls: Bool?

    init(allowConcurrentCalls: Bool?) {
        self.allowConcurrentCalls = allowConcurrentCalls
    }
}
