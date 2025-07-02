//
//  PluginDetailView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var store: PluginStore

    let plugin: Plugin

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {

                PluginDetailHeaderView(plugin: plugin)
                
                PluginDetailDescriptionView(description: plugin.description)
                
                PluginDetailIncludedView(items: plugin.includes)

                PluginDetailGuidesView(urls: plugin.guides)

                Spacer(minLength: 32)
            }
            .padding(32)
        }
        .background(Color(.color1C1B1B).ignoresSafeArea())
        .toolbar {
            ToolbarItem(placement: .navigation) {
                Button { dismiss() } label: {
                    Label("Back", systemImage: "chevron.left")
                }
            }
        }
    }
}

#Preview {
    PluginDetailView(plugin: .sample)
        .environmentObject(PluginStore())
        .frame(width: 800, height: 600)
}
