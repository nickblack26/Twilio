//
//  FlowDetailView.swift
//  Twilio
//
//  Created by Nick Black on 6/14/24.
//

import SwiftUI

struct FlowDetailView: View {
    @State private var selection: FlowDetailView.Tab = .editor
    @Bindable private var flow: Flow
    
    init(_ flow: Flow) {
        self.flow = flow
    }
    var body: some View {
        TabView(selection: $selection) {
            ForEach(Tab.allCases, id: \.self) { tab in
                Text(tab.rawValue)
                    .tabItem { Text(tab.rawValue.capitalized) }
            }
        }
    }
    
    enum Tab: String, CaseIterable {
        case editor, logs
        case revisionHistory = "Revision History"
    }
}

#Preview {
    FlowDetailView(.flow1)
}
