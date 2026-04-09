//
//  SuccessLoaderView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI
 
struct SuccessLoaderView: View {
    @State private var rotation: Double = 0
    @State private var trimEnd: CGFloat = 0.75
 
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.green.opacity(0.12), lineWidth: 4)
                .frame(width: 80, height: 80)
 
            Circle()
                .trim(from: 0, to: trimEnd)
                .stroke(
                    AngularGradient(
                        colors: [
                            Color.green.opacity(0.0),
                            Color.green.opacity(0.5),
                            Color.green
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .frame(width: 80, height: 80)
                .rotationEffect(.degrees(rotation))
                .animation(
                    .linear(duration: 2.0).repeatForever(autoreverses: false),
                    value: rotation
                )
 
            Circle()
                .fill(Color.green.opacity(0.1))
                .frame(width: 68, height: 68)
 
            Image(systemName: "checkmark")
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(.green)
        }
        .onAppear {
            rotation = 360
        }
    }
}
 
#Preview {
    SuccessLoaderView()
        .padding()
}
