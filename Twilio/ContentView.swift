import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTab: SidebarSelection = .studio
    @State private var contentSelection: ContentSelection?
    @Query var taskQueues: [TaskQueue]
    
    var body: some View {
        NavigationSplitView(preferredCompactColumn: .constant(.content)) {
            List(selection: $selectedTab) {
                Section("Studio") {
                    NavigationLink("Flows", value: SidebarSelection.studio)
                }
                .headerProminence(.increased)
                
                Section("TaskRouter") {
                    ForEach(TaskRouterTab.allCases, id: \.self) {
                        NavigationLink($0.rawValue.capitalized, value: SidebarSelection.taskRouter($0))
                    }
                }
                .headerProminence(.increased)
            }
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
        } content: {
            List(selection: $contentSelection) {
                switch selectedTab {
                case .studio:
                    FlowsListView()
                case .taskRouter(let taskRouter):
                    switch taskRouter {
                    case .taskQueues:
                        Text("")
                    case .workflows:
                        Text("")
                    case .taskChannels:
                        Text("")
                    case .activites:
                        Text("")
                    case .workers:
                        Text("")
                    case .tasks:
                        Text("")
                    case .settings:
                        Text("")
                    case .limits:
                        Text("")
                    }
                }
            }
            .toolbar {
                RefreshButton()
            }
            .refreshable {
                await StudioFlowCollection.refresh(modelContext: modelContext)
                //            viewModel.update(modelContext: modelContext)
            }
        } detail: {
            NavigationStack {
                switch contentSelection {
                case .flow(let flow):
                    Text(flow.friendlyName ?? "")
                case .taskRouter(let taskRouterTab):
                    switch taskRouterTab {
                    case .taskQueues:
                        GenericListView(items: taskQueues)
                    default:
                        Text("")
                    }
                case nil:
                    ContentUnavailableView("Select A Tab", systemImage: "info.circle")
                }
            }
        }
    }
}

extension ContentView {
    private enum SidebarSelection: Hashable, Codable {
        case studio
        case taskRouter(TaskRouterTab)
    }
    
    enum ContentSelection: Hashable, Codable {
        case flow(Flow)
        case taskRouter(TaskRouterTab)
    }
    
    enum TaskRouterTab: String, CaseIterable, Codable {
        case taskQueues = "Task Queues"
        case workflows
        case taskChannels = "Task Channels"
        case activites
        case workers
        case tasks
        case settings
        case limits
    }
}

#Preview {
    ContentView()
}
