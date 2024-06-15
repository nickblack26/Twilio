import Foundation
import SwiftData

@Model
final class TaskQueue: Searchable {
    var name: String { friendlyName }
    var accountSid: String
    var assignmentActivityName: String
    var assignmentActivitySid: String
    var dateCreated: Date
    var dateUpdated: Date
    var friendlyName: String
    var maxReservedWorkers: Int
    var reservationActivityName: String
    var reservationActivitySid: String
    var sid: String
    var targetWorkers: String?
    var taskOrder: Order
    var url: String
    var workspaceSid: String
    var operatingUnitSid: String
    
    enum CodingKeys: String, CodingKey {
        case accountSid = "account_sid"
        case assignmentActivityName = "assignment_activity_name"
        case assignmentActivitySid = "assignment_activity_sid"
        case dateCreated = "date_created"
        case dateUpdated = "date_updated"
        case friendlyName = "friendly_name"
        case maxReservedWorkers = "max_reserved_workers"
        case reservationActivityName = "reservation_activity_name"
        case reservationActivitySid = "reservation_activity_sid"
        case sid = "sid"
        case targetWorkers = "target_workers"
        case taskOrder = "task_order"
        case url = "url"
        case workspaceSid = "workspace_sid"
        case operatingUnitSid = "operating_unit_sid"
    }
    
    init(
        accountSid: String,
        assignmentActivityName: String,
        assignmentActivitySid: String,
        dateCreated: Date,
        dateUpdated: Date,
        friendlyName: String,
        maxReservedWorkers: Int,
        reservationActivityName: String,
        reservationActivitySid: String,
        sid: String,
        targetWorkers: String? = nil,
        taskOrder: Order,
        url: String,
        workspaceSid: String,
        operatingUnitSid: String
    ) {
        self.accountSid = accountSid
        self.assignmentActivityName = assignmentActivityName
        self.assignmentActivitySid = assignmentActivitySid
        self.dateCreated = dateCreated
        self.dateUpdated = dateUpdated
        self.friendlyName = friendlyName
        self.maxReservedWorkers = maxReservedWorkers
        self.reservationActivityName = reservationActivityName
        self.reservationActivitySid = reservationActivitySid
        self.sid = sid
        self.targetWorkers = targetWorkers
        self.taskOrder = taskOrder
        self.url = url
        self.workspaceSid = workspaceSid
        self.operatingUnitSid = operatingUnitSid
    }
    
    enum Order: String, Codable {
        case fifo = "FIFO"
        case lifo = "LIFO"
    }
}
