//
//  PluginDetailHeaderView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailHeaderView: View {
    @EnvironmentObject private var store: PluginStore
    let plugin: Plugin

    var body: some View {
        HStack(alignment: .center, spacing: 24) {

            plugin.iconImage
                .resizable()
                .frame(width: 96, height: 96)
                .clipShape(RoundedRectangle(cornerRadius: 20))

            VStack(alignment: .leading, spacing: 8) {
                Text(plugin.title)
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)

                Text(plugin.subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))

                PluginDetailVersionCategoryRowView(plugin: plugin)
            }

            Spacer()

            PluginActionButtonView(
                plugin: plugin,
                showUninstall: true
            )
        }
    }
}

#Preview {
    PluginDetailHeaderView(plugin: .sample)
}
