import Foundation
import SwiftData

// MARK: - Links
@Model
class Links {
    var revisions: String?

    init(revisions: String?) {
        self.revisions = revisions
    }
}
