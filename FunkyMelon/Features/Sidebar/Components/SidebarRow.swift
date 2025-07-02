//
//  SidebarRow.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/1/25.
//

import SwiftUI

struct SidebarRow: View {
    let category: MenuItem
    let isActive: Bool
    let action: (() -> Void?)

    var body: some View {
        Button {
            action()
        } label: {
            HStack(spacing: 10) {
                Image(systemName: category.assetName(isActive: isActive))
                    .renderingMode(.template)
                    .frame(
                        width: 18,
                        height: 18
                    )
                
                Text(category.displayName)
                    .font(.callout.weight(.medium))
                
                Spacer()
            }
            .foregroundStyle(isActive ? .white : .secondary)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .frame(width: 180)
            .background(
                Capsule()
                    .fill(
                        isActive
                        ? Color(.appPrimary)
                        : Color.clear
                    )
            )
            .contentShape(.rect)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    SidebarRow(
        category: .titles,
        isActive: true
    ) { }
}
