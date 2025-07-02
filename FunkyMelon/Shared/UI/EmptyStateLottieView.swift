//
//  EmptyStateLottieView.swift
//  FunkyMelon
//
//  Created by Stephen James Del Rosario on 7/2/25.
//

import SwiftUI
import Lottie

struct EmptyStateLottieView: View {

    var body: some View {
        VStack(spacing: 28) {
            LottieView(animation: .named("lottie"))
                .playing(loopMode: .loop)
                .frame(width: 240, height: 240)

            Text("No Plugins Yet")
                .font(.title.weight(.bold))
                .foregroundColor(.white)
        }
        .padding(48)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.color1C1B1B).ignoresSafeArea())
    }
}

#Preview {
    EmptyStateLottieView()
}
