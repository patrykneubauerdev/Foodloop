//
//  TablePickerView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI

struct TablePickerView: View {
    @Binding var selectedTableNumber: Int
    @Environment(\.dismiss) private var dismiss
    @State private var tempSelectedNumber: Int
    
    init(selectedTableNumber: Binding<Int>) {
        self._selectedTableNumber = selectedTableNumber
        self._tempSelectedNumber = State(initialValue: selectedTableNumber.wrappedValue)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                VStack(spacing: 16) {
                   
                    ZStack {
                        Circle()
                            .fill(.purpleLight.opacity(0.1))
                            .frame(width: 60, height: 60)
                        
                        Image(systemName: "table.furniture")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundStyle(.purpleLight)
                    }
                    
                    VStack(spacing: 8) {
                        Text("choose-table-number")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                        
                        Text("select-perfect-spot")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
              
                Picker("table-number", selection: $tempSelectedNumber) {
                    ForEach(1...99, id: \.self) { number in
                        Text("\(number)")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 180)
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                Spacer()
                
              
                VStack(spacing: 0) {
                    Button(action: {
                        selectedTableNumber = tempSelectedNumber
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                            dismiss()
                        }
                    }) {
                        HStack(spacing: 12) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 18, weight: .medium))
                            
                            Text("confirm-selection")
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: [.purpleLight, .purpleLight.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .shadow(color: .purpleLight.opacity(0.3), radius: 8, x: 0, y: 4)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                .background(Color.boneBackground)
            }
            .background(Color.boneBackground)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundStyle(.primary)
                    }
                }
            }
        }
    }
}
