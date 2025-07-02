//
//  SidebarView.swift
//  FunkyMelon
//
//  Created by Stephen del Rosario on 7/1/25.
//

import SwiftUI

struct SidebarView: View {
    @Binding var selected: MenuItem

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(MenuItem.allCases) { category in
                    SidebarRow(
                        category: category,
                        isActive: category == selected
                    ) {
                        selected = category
                    }
                }
            }
            .padding(.vertical, 8)
        }
        .frame(minWidth: 180)
        .padding(.horizontal, 12)
    }
}

#Preview {
    SidebarView(selected: .constant(.effects))
}
