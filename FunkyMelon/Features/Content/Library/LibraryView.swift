//
//  LibraryView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct LibraryView: View {
    @EnvironmentObject private var store: PluginStore
    @State private var presented: Plugin?
    
    private static let grid: [GridItem] = [
        GridItem(.adaptive(minimum: 550, maximum: 650), spacing: 24)
    ]
    
    private var grouped: [(PluginCategory, [Plugin])] {
        guard case .success(let list) = store.state else { return [] }
        
        let installed = list.filter(\.installed)
        
        return PluginCategory.allCases.compactMap { cat in
            let items = installed.filter { $0.category == cat }
            return items.isEmpty ? nil : (cat, items)
        }
    }
    
    var body: some View {
        
        if grouped.isEmpty {
            EmptyStateLottieView()
        } else {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 32) {
                    ForEach(grouped, id: \.0) { (category, items) in
                        SectionHeader(LocalizedStringKey(category.rawValue))
                        
                        LazyVGrid(columns: Self.grid, spacing: 24) {
                            ForEach(items) { plugin in
                                PluginCardView(plugin: plugin, showUninstall: true) {
                                    presented = plugin
                                }
                            }
                        }
                    }
                }
                .padding(32)
            }
            .background(Color(.color1C1B1B).ignoresSafeArea())
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
}

#Preview {
    LibraryView()
        .environmentObject(PluginStore())
        .frame(width: 900, height: 600)
}
