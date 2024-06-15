import SwiftUI
import SwiftData

struct FlowsListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Flow.dateCreated, order: .reverse) private var flows: [Flow]
    
    var body: some View {
        ForEach(flows) {
            if let friendlyName = $0.friendlyName {
                NavigationLink(friendlyName, value: ContentView.ContentSelection.flow($0))
            }
        }
    }
}

#Preview {
    FlowsListView()
}
