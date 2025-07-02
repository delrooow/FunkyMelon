//
//  CategoryPluginsView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct TransitionsView: View {

    var body: some View {
        PluginsMainView(category: .transitions)
    }
}

#Preview {
    TransitionsView()
        .environmentObject(PluginStore())
        .frame(width: 800, height: 600)
}
