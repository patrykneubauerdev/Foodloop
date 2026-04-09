//
//  IconBadge.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct IconBadge: View {
    let icon: String
    let color: Color
    
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 10, weight: .medium))
            .foregroundStyle(color)
            .frame(width: 20, height: 20)
            .background(
                Circle()
                    .fill(color.opacity(0.15))
            )
    }
}
