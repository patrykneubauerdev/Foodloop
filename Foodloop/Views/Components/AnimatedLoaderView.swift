//
//  AnimatedLoaderView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI
 
struct AnimatedLoaderView: View {
    @State private var rotation: Double = 0
    @State private var phase: CGFloat = 0
 
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.purpleLight.opacity(0.12), lineWidth: 10)
                .frame(width: 108, height: 108)
 
            Circle()
                .trim(from: 0, to: 0.65)
                .stroke(
                    AngularGradient(
                        colors: [
                            Color.purpleLight.opacity(0.0),
                            Color.purpleLight.opacity(0.4),
                            Color.purpleLight.opacity(0.85),
                            Color.purpleLight
                        ],
                        center: .center
                    ),
                    style: StrokeStyle(lineWidth: 10, lineCap: .round)
                )
                .frame(width: 108, height: 108)
                .rotationEffect(.degrees(rotation))
                .animation(
                    .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                    value: rotation
                )
 
            Circle()
                .trim(from: 0.0, to: 1.0)
                .stroke(
                    Color.purpleLight.opacity(0.1),
                    style: StrokeStyle(lineWidth: 3, lineCap: .round, dash: [4, 9])
                )
                .frame(width: 82, height: 82)
                .rotationEffect(.degrees(-rotation * 0.4))
                .animation(
                    .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                    value: rotation
                )
 
            Image(systemName: "fork.knife")
                .font(.system(size: 28, weight: .medium))
                .foregroundStyle(.purpleLight)
                .scaleEffect(1.0 + 0.03 * sin(phase * .pi * 2))
                .animation(
                    .easeInOut(duration: 1.8).repeatForever(autoreverses: true),
                    value: phase
                )
        }
        .onAppear {
            rotation = 360
            phase = 1
        }
    }
}
 
#Preview {
    AnimatedLoaderView()
        .padding()
}
