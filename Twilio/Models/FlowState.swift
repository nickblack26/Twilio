import Foundation
import SwiftData

// MARK: - State
@Model
class FlowState {
    var properties: Properties?
    var transitions: [String]?
    var name: String?
    var type: String?

    init(properties: Properties?, transitions: [String]?, name: String?, type: String?) {
        self.properties = properties
        self.transitions = transitions
        self.name = name
        self.type = type
    }
}
