import Foundation
import SwiftData

// MARK: - Definition
@Model
class Definition {
    var flags: Flags?
    var initialState: String?
    var aDescription: String?
    var states: [FlowState]?

    init(flags: Flags?, initialState: String?, description: String?, states: [FlowState]?) {
        self.flags = flags
        self.initialState = initialState
        self.aDescription = description
        self.states = states
    }
}
