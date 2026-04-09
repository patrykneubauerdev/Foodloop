//
//  Double.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import Foundation
 
extension Double {
    var formattedPrice: String {
        let formatted = String(format: "%.2f", self).replacingOccurrences(of: ".", with: ",")
        return "\(formatted) zł"
    }
}
