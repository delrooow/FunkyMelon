//
//  DiscoverView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct DiscoverView: View {
    @EnvironmentObject private var store: PluginStore

    var body: some View {
        Group {
            switch store.state {
            case .idle, .loading:
                ProgressView().task {
                    store.load()
                }
            case .failure(let error):
                Text("Error: \(error)")
            case .success(let plugins):
                DiscoverContent(plugins: plugins)
            }
        }
        .padding(.leading, 32)
        .background(Color(.color1C1B1B)
        .ignoresSafeArea())
    }
}

// MARK: - Content View

struct DiscoverContent: View {
    @State private var presented: Plugin?
    @State private var featured: [Plugin] = []
    @State private var popular:  [Plugin] = []
    
    let plugins: PluginList
    
    init(plugins: PluginList) {
        self.plugins = plugins

        let shuffled = plugins.shuffled()
        _featured = State(initialValue: Array(shuffled.prefix(6)))
        _popular  = State(initialValue: Array(shuffled.dropFirst(6).prefix(6)))
    }
    
    private let grid = [
        GridItem(.flexible(), spacing: 24),
        GridItem(.flexible(), spacing: 24)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 32) {

                SectionHeader("Featured")
                generateGridItem(for: featured)

                SectionHeader("Popular")
                generatePopularGridItem(for: popular)
            }
            .padding(.vertical, 32)
            .padding(.trailing, 32)
        }
        .sheet(item: $presented) { plugin in
            NavigationStack {
                PluginDetailView(plugin: plugin)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Done") { presented = nil }
                        }
                    }
            }
            .frame(minWidth: 650, minHeight: 300)
        }
    }
}

// MARK: - Views

private extension DiscoverContent {
    
    func generateGridItem(for items: [Plugin]) -> some View {
        let columns = [
            GridItem(.flexible(), spacing: 24),
            GridItem(.flexible(), spacing: 24)
        ]

        return LazyVGrid(columns: columns, spacing: 24) {
            ForEach(items) { plugin in
                PluginCardView(plugin: plugin) {
                    presented = plugin
                }
            }
        }
    }
    
    func generatePopularGridItem(for items: [Plugin]) -> some View {
        let columns = [
            GridItem(.flexible(), spacing: 24),
            GridItem(.flexible(), spacing: 24)
        ]

        return LazyVGrid(columns: columns, spacing: 24) {
            ForEach(items) { plugin in
                PopularPluginCardView(plugin: plugin) {
                    presented = plugin
                }
            }
        }
    }

}

#Preview {
    DiscoverView()
        .environmentObject(PluginStore())
}
