import Foundation
import SwiftData

// MARK: - Properties
@Model
class Properties {
    var offset: Offset?

    init(offset: Offset?) {
        self.offset = offset
    }
}
