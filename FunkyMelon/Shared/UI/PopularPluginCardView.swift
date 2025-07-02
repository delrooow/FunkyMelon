//
//  TagButtonView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct PopularPluginCardView: View {
    @State private var isHovering = false
    let plugin: Plugin
    let action: (() -> Void?)

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 8) {
                plugin.iconImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(plugin.title)
                            .font(.title3.weight(.bold))
                            .foregroundColor(.white)
                        
                        Text(plugin.subtitle)
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.8))
                        
                    }
                    
                    Spacer()
                    
                    PillButtonView(
                        title: plugin.free
                            ? "Get"
                            : String(format: "$%.2f", plugin.price.amount),
                        buttonType: .primary,
                    ) {
                        
                    }
                    .padding(.top, 4)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
            .padding(24)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(
                        LinearGradient(
                            colors: [.appSecondary, .appPrimary],
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

#Preview {
    PopularPluginCardView(plugin: .sample) { }
        .frame(width: 600)
}
