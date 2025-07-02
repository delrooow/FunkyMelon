//
//  PluginCardView.swift
//  FunkyMelon
//
//  Created by Stephen del Rosario on 6/30/25.
//

import SwiftUI

struct PluginCardView: View {
    @EnvironmentObject private var store: PluginStore
    @State private var isHovering = false
    
    let plugin: Plugin
    var showUninstall: Bool = false
    let action: (() -> Void?)
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 20) {
                plugin.iconImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(plugin.title)
                        .font(.title3.weight(.bold))
                        .foregroundColor(.white)
                    
                    Text(plugin.subtitle)
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Text(plugin.installed ? "Version:" : "Category:")
                            .font(.caption.weight(.bold))
                            .foregroundColor(.white.opacity(0.7))
                        Text(plugin.installed ? plugin.version
                             : plugin.category.rawValue)
                        .font(.caption.weight(.semibold))
                        .foregroundColor(.accentColor)
                    }
                    
                    PluginActionButtonView(
                        plugin: plugin,
                        showUninstall: showUninstall
                    )
                    .padding(.top, 4)
                }
                .frame(
                    maxWidth: .infinity,
                    alignment: .leading
                )
                .frame(height: 110)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 32)
                    .fill(
                        LinearGradient(
                            colors: [.appPrimary, .black],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing)
                    )
            )
            .shadow(
                color: .black.opacity(isHovering ? 0.4 : 0.2),
                radius: isHovering ? 10 : 4, y: 4
            )
            .onHover { isHovering = $0 }
        }
        .buttonStyle(.plain)
    }
}

#Preview("Plugin Card") {
    PluginCardView(plugin: .sample) { }
        .frame(width: 600)
        .padding()
        .environmentObject(PluginStore())
}
