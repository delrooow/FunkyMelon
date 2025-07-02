//
//  PluginDetailIncludedView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailIncludedView: View {
    let items: [String]

    private let grid = Array(
        repeating: GridItem(.flexible(),
        spacing: 16),
        count: 3
    )

    var body: some View {
        if !items.isEmpty {
            SectionHeader("What's Included")
            
            LazyVGrid(
                columns: grid,
                alignment: .leading,
                spacing: 16
            ) {
                ForEach(items, id: \.self) { item in
                    generateIncludedItem(title: item)
                }
            }
            .padding(.horizontal)
        }
    }
}

private extension PluginDetailIncludedView {
    
    func generateIncludedItem(title: String) -> some View {
        VStack(spacing: 8) {
            RoundedRectangle(cornerRadius: 16)
                .fill(.appPrimary.opacity(0.3))
                .frame(height: 80)
                .overlay(
                    Image(systemName: "sparkle")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                )

            Text(title)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.9))
        }
    }
}

#Preview {
    PluginDetailIncludedView(items: [])
}
