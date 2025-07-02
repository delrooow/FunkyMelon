//
//  EffectsView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct EffectsView: View {
    
    var body: some View {
        PluginsMainView(category: .effects)
    }
}

#Preview {
    EffectsView()
        .environmentObject(PluginStore())
        .frame(width: 800, height: 600)
}
