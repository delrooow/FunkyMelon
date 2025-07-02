//
//  PluginsMainView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct PluginsMainView: View {
    let category: PluginCategory
    @EnvironmentObject private var store: PluginStore

    @State private var searchText = ""
    @State private var sort: SortOption = .alphabetically
    @State private var presented: Plugin?

    private let grid: [GridItem] = [
        GridItem(.adaptive(minimum: 550, maximum: 650), spacing: 24)
    ]

    var body: some View {
        Group {
            switch store.state {
            case .idle, .loading:
                ProgressView()
                    .task { store.load() }

            case .failure(let error):
               Text("Error: \(error)")

            case .success(let plugins):
                content(for: plugins)
            }
        }
        .padding(.leading, 32)
        .background(Color(.color1C1B1B).ignoresSafeArea())
        .searchable(text: $searchText)
        .toolbar {
            ToolbarItem {
                Picker("Sort", selection: $sort) {
                    ForEach(SortOption.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
        .toolbarColorScheme(.dark, for: .automatic)
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

    @ViewBuilder
    private func content(for plugins: PluginList) -> some View {
        let filtered = plugins
            .filter { $0.category == category }
            .filter {
                searchText.isEmpty
                ? true
                : $0.title.localizedCaseInsensitiveContains(searchText)
                  || $0.subtitle.localizedCaseInsensitiveContains(searchText)
            }

        let sorted: [Plugin] = {
            switch sort {
            case .alphabetically:
                return filtered.sorted { $0.title < $1.title }
            case .priceHighToLow:
                return filtered.sorted { $0.price.amount > $1.price.amount }
            case .freeOnly:
                return filtered.filter { $0.free }
            case .paidOnly:
                return filtered.filter { !$0.free }
            }
        }()

        ScrollView {
            LazyVStack(alignment: .leading, spacing: 32) {
                SectionHeader(LocalizedStringKey(category.rawValue))

                LazyVGrid(columns: grid, spacing: 24) {
                    ForEach(sorted) { plugin in
                        PluginCardView(plugin: plugin) {
                            presented = plugin
                        }
                    }
                }
            }
            .padding(.vertical, 32)
            .padding(.trailing, 32)
        }
    }
}

#Preview {
    PluginsMainView(category: .effects)
        .frame(width: 800, height: 600)
}
