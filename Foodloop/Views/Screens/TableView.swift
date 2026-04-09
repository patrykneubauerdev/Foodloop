//
//  TableView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 16/06/2025.
//


import SwiftUI
import Foundation

struct TableView: View {
    @StateObject private var tableViewModel = TableViewModel.shared
    @State private var showPicker = false
    @State private var showContent = false
    @State private var pulseAnimation = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.boneBackground
                    .ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer()
                    
                    headerSection
                        .scaleEffect(showContent ? 1.0 : 0.8)
                        .opacity(showContent ? 1 : 0)
                        .animation(
                            .spring(response: 0.8, dampingFraction: 0.7)
                            .delay(0.1),
                            value: showContent
                        )
                    
                    tableSelectionCard
                        .scaleEffect(showContent ? 1.0 : 0.9)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 50)
                        .animation(
                            .spring(response: 0.8, dampingFraction: 0.6)
                            .delay(0.3),
                            value: showContent
                        )
                    
                    infoSection
                        .scaleEffect(showContent ? 1.0 : 0.95)
                        .opacity(showContent ? 1 : 0)
                        .offset(y: showContent ? 0 : 30)
                        .animation(
                            .spring(response: 0.8, dampingFraction: 0.7)
                            .delay(0.5),
                            value: showContent
                        )
                    
                    Spacer()
                }
                .padding(.horizontal, 16)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                withAnimation {
                    showContent = true
                }
                startPulseAnimation()
            }
            .sheet(isPresented: $showPicker) {
                TablePickerView(selectedTableNumber: $tableViewModel.selectedTableNumber)
                    .presentationDetents([.medium])
                    .presentationDragIndicator(.visible)
            }
        }
        .environmentObject(tableViewModel)
    }
    
    private var headerSection: some View {
        VStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(.purpleLight.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "table.furniture")
                    .font(.system(size: 44, weight: .light))
                    .foregroundStyle(.purpleLight)
            }
            
            Text("select-table")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.primary)
        }
    }
    
    private var tableSelectionCard: some View {
        VStack(spacing: 24) {
            VStack(spacing: 12) {
                Text("table-number")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Button(action: {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                        showPicker = true
                    }
                }) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.purpleLight, .purpleLight.opacity(0.8)],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 140, height: 140)
                            .shadow(color: .purpleLight.opacity(0.3), radius: 20, x: 0, y: 10)
                            .scaleEffect(pulseAnimation ? 1.05 : 1.0)
                            .animation(
                                .easeInOut(duration: 2.0).repeatForever(autoreverses: true),
                                value: pulseAnimation
                            )
                        
                        Text("\(tableViewModel.selectedTableNumber)")
                            .font(.system(size: 64, weight: .bold, design: .rounded))
                            .foregroundStyle(.white)
                    }
                }
                .buttonStyle(TableNumberButtonStyle())
                
                
                Button(action: {
                    showPicker = true
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "hand.tap")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.purpleLight)
                        
                        Text("tap-to-change")
                            .font(.subheadline)
                            .foregroundStyle(.purpleLight)
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        Capsule()
                            .fill(.purpleLight.opacity(0.1))
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.vertical, 32)
        .padding(.horizontal, 24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.bone)
                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 4)
        )
    }
    
    private var infoSection: some View {
        HStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(.purpleLight.opacity(0.1))
                    .frame(width: 32, height: 32)
                
                Image(systemName: "info")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(.purpleLight)
            }
            
            Text("select-table-number-where-sitting")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.bone.opacity(0.6))
        )
    }
    
    private func startPulseAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            pulseAnimation = true
        }
    }
}

// MARK: - Custom Button Style with Extra Animation
struct TableNumberButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.1 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.5), value: configuration.isPressed)
    }
}



#Preview {
    TableView()
}
