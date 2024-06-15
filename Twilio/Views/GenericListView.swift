import SwiftUI

protocol Searchable {
    var name: String { get }
}

struct GenericListView<Item>: View where Item: Hashable, Item: Identifiable, Item: Searchable {
    @State private var searchText: String = ""
    let items: [Item]
    
    var body: some View {
        var filterdItems: [Item] {
            if searchText.isEmpty { return items }
            return items.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }

        List {
            ForEach(filterdItems) { item in
                Text(item.name)
            }
        }
        .searchable(text: $searchText)
    }
}
