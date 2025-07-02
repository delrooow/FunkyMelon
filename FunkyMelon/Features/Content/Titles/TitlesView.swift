//
//  TitlesView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct TitlesView: View {
    
    var body: some View {
        PluginsMainView(category: .titles)
    }
}

#Preview {
    TitlesView()
        .environmentObject(PluginStore())
        .frame(width: 800, height: 600)
}
