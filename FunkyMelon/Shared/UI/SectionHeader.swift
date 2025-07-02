//
//  DiscoverSectionHeader.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct SectionHeader: View {
    private let text: LocalizedStringKey
    init(_ t: LocalizedStringKey) { text = t }

    var body: some View {
        Text(text)
            .font(.largeTitle.weight(.bold))
            .foregroundColor(.white)
            .padding(.bottom, 4)
    }
}

#Preview {
    SectionHeader("Sample")
}
