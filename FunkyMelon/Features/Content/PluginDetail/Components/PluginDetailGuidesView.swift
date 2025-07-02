//
//  PluginDetailGuidesView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PluginDetailGuidesView: View {
    let urls: [URL]
    
    private let grid = Array(
        repeating: GridItem(.flexible(),
        spacing: 16),
        count: 3
    )
    
    var body: some View {
        if !urls.isEmpty {
            SectionHeader("Guides")
            
            LazyVGrid(
                columns: grid,
                alignment: .leading,
                spacing: 16
            ) {
                ForEach(urls, id: \.self) { url in
                    let cleanTitle = (
                        url.deletingPathExtension()
                            .lastPathComponent
                            .replacingOccurrences(of: "-", with: " ")
                            .replacingOccurrences(of: "_", with: " ")
                            .removingPercentEncoding ?? ""
                    )
                    .capitalized
                    
                    generateGuidesItem(title: cleanTitle, url: url)
                }
            }
            .padding(.horizontal)
        }
    }
}

private extension PluginDetailGuidesView {
    
    func generateGuidesItem(title: String, url: URL) -> some View {
        Link(destination: url) {
            VStack(spacing: 8) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.appSecondary.opacity(0.3))
                    .frame(height: 80)
                    .overlay(
                        Image(systemName: "text.document.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    )
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.9))
            }
        }
    }
}

#Preview {
    PluginDetailGuidesView(urls: [])
}
