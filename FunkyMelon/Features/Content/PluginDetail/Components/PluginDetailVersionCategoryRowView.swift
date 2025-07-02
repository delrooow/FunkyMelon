//
//  PluginDetailVersionCategoryRowView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailVersionCategoryRowView: View {
    let plugin: Plugin
    
    var body: some View {
        HStack(spacing: 4) {
            Text(plugin.installed ? "Version:" : "Category:")
                .font(.caption.weight(.bold))
                .foregroundColor(.white.opacity(0.7))

            Text(plugin.installed ? plugin.version : plugin.category.rawValue)
                .font(.caption.weight(.semibold))
                .foregroundColor(.accentColor)
        }
    }
}

#Preview {
    PluginDetailVersionCategoryRowView(plugin: .sample)
        .frame(width: 300, height: 30)
}
