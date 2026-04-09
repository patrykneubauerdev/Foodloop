//
//  OrderService.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import Foundation
import SwiftData

// MARK: - Order Service
class OrderService {
    static let shared = OrderService()

    private let apiURL = "https://httpbin.org/post"

    private init() {}

    func submitOrder(_ order: Order) async throws -> OrderResponse {
        return try await submitOrderInternal(
            orderNumber: order.orderNumber,
            tableNumber: order.tableNumber,
            items: order.items.map { item in
                [
                    "productId": item.productId,
                    "productName": item.productName,
                    "quantity": item.quantity,
                    "price": item.productPrice,
                    "totalPrice": item.totalPrice
                ]
            },
            totalPrice: order.totalPrice,
            timestamp: ISO8601DateFormatter().string(from: order.createdAt)
        )
    }

    private func submitOrderInternal(
        orderNumber: String,
        tableNumber: Int,
        items: [[String: Any]],
        totalPrice: Double,
        timestamp: String
    ) async throws -> OrderResponse {
        guard let url = URL(string: apiURL) else {
            throw URLError(.badURL)
        }

        let jsonObject: [String: Any] = [
            "orderNumber": orderNumber,
            "tableNumber": tableNumber,
            "items": items,
            "totalPrice": totalPrice,
            "timestamp": timestamp
        ]

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
        request.httpBody = jsonData

        print("Sending order to httpbin.org:")
        print(String(data: jsonData, encoding: .utf8) ?? "JSON encoding error")
        print("URL:", apiURL)

        let startTime = Date()

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime < 2.0 {
                try await Task.sleep(nanoseconds: UInt64((2.0 - elapsedTime) * 1_000_000_000))
            }

            if let httpResponse = response as? HTTPURLResponse {
                print("Status: \(httpResponse.statusCode)")

                if (200...299).contains(httpResponse.statusCode) {
                    print("Order submitted successfully!")

                    if let responseString = String(data: data, encoding: .utf8) {
                        print("Response from httpbin:")
                        print(responseString)
                    }

                    return OrderResponse(
                        success: true,
                        orderNumber: orderNumber,
                        estimatedDeliveryMinutes: 20
                    )
                }
            }

            print("Unexpected response, continuing anyway...")
            return OrderResponse(
                success: true,
                orderNumber: orderNumber,
                estimatedDeliveryMinutes: 20
            )

        } catch {
            print("Network error: \(error)")

            let elapsedTime = Date().timeIntervalSince(startTime)
            if elapsedTime < 2.0 {
                try await Task.sleep(nanoseconds: UInt64((2.0 - elapsedTime) * 1_000_000_000))
            }

            print("Continuing despite error (demo mode)")
            return OrderResponse(
                success: true,
                orderNumber: orderNumber,
                estimatedDeliveryMinutes: 20
            )
        }
    }
}
