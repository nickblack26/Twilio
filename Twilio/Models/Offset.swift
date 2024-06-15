import Foundation
import SwiftData

// MARK: - Offset
@Model
class Offset {
    var y: Int?
    var x: Int?

    init(y: Int?, x: Int?) {
        self.y = y
        self.x = x
    }
}
