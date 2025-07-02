//
//  RootView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var dataStore = PluginStore()
    @State private var selected: MenuItem = .discover

    var body: some View {
        NavigationSplitView {
            SidebarView(selected: $selected)
        } detail: {
            switch selected {
            case .discover:
                DiscoverView()
            case .titles:
                TitlesView()
            case .effects:
                EffectsView()
            case .transitions:
                TransitionsView()
            case .library:
                LibraryView()
            }
        }
        .frame(minWidth: 1200, minHeight: 900)
        .environmentObject(dataStore)
    }
}

#Preview {
    RootView()
}
