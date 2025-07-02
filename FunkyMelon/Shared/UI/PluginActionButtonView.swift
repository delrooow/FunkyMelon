//
//  PluginActionButtonView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginActionButtonView: View {
    @EnvironmentObject private var store: PluginStore

    let plugin: Plugin
    var showUninstall: Bool = false

    private enum Action {
        case progress
        case get
        case update
        case uninstall
        case price(String)
        case installed
    }
    
    private var livePlugin: Plugin {
        if case .success(let list) = store.state,
           let updated = list.first(where: { $0.id == plugin.id }) {
            
            return updated
        }
        
        return plugin
    }

    private var current: Action {
        let plugin = livePlugin
        let id = plugin.id

        if store.installing.contains(id) ||
           store.updating.contains(id)   ||
           store.uninstalling.contains(id) {
            return .progress
        }

        if plugin.free && !plugin.installed {
            return .get
        }

        if plugin.installed && plugin.requiresUpdate {
            return .update
        }

        if showUninstall && plugin.installed {
            return .uninstall
        }

        if !plugin.free {
            return .price(String(format: "$%.2f", plugin.price.amount))
        }

        return .installed
    }

    var body: some View {
        switch current {
        case .progress:
            ProgressView(value: store.progress[plugin.id] ?? 0)
                .progressViewStyle(.linear)
                .frame(width: 120)

        case .get:
            PillButtonView(
                title: "Get",
                buttonType: .primary
            ) {
                store.install(pluginID: plugin.id)
            }

        case .update:
            PillButtonView(
                title: "Update",
                buttonType: .primary
            ) {
                store.update(pluginID: plugin.id)
            }

        case .uninstall:
            PillButtonView(
                title: "Uninstall",
                buttonType: .destructive
            ) {
                store.uninstall(pluginID: plugin.id)
            }

        case .price(let label):
            PillButtonView(
                title: label,
                buttonType: .primary
            ) { }

        case .installed:
            PillButtonView(
                title: "Installed",
                buttonType: .installed
            ) { }
        }
    }
}

#Preview {
    PluginActionButtonView(plugin: .sample)
}
