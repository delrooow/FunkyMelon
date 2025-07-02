//
//  PillButtonView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI

struct PillButtonView: View {

    enum ButtonType {
        case primary, installed, destructive
    }

    let title: String
    let buttonType: ButtonType
    let action: (() -> Void?)

    private var backgroundColor: Color {
        switch buttonType {
        case .primary:
            .appPrimary
        case .installed:
            .green.opacity(0.85)
        case .destructive:
            .red.opacity(0.85)
        }
    }

    private var textColor: Color {
        switch buttonType {
        default:
            .white
        }
    }

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.subheadline.weight(.semibold))
                .padding(.horizontal, 18)
                .padding(.vertical, 6)
                .background(
                    Capsule().fill(backgroundColor)
                )
                .foregroundStyle(textColor)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    VStack(spacing: 12) {
        PillButtonView(
            title: "Get",
            buttonType: .primary
        ) { }
        PillButtonView(
            title: "Installed",
            buttonType: .installed
        ) { }
        PillButtonView(
            title: "Uninstall",
            buttonType: .destructive
        ) { }
    }
    .padding()
    .frame(width: 300)
}
