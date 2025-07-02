//
//  PluginDetailDescriptionView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailDescriptionView: View {
    let description: String
    
    var body: some View {
        if !description.isEmpty {
            Text(description)
                .font(.body)
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

#Preview {
    PluginDetailDescriptionView(description: "Sample")
}
