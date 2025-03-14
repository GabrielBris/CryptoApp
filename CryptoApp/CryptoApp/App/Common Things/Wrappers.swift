//
//  Wrappers.swift
//  CryptoApp
//
//  Created by Gabriel Alejandro Briseño Alvarez on 14/03/25.
//

import Foundation

@propertyWrapper
struct FormattedDate {
    var dateStr: String

    var wrappedValue: String {
        get {
            let oldFormatter = DateFormatter()
            oldFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSX"

            let newFormat = DateFormatter()
            newFormat.dateFormat = "MMMM d, yyyy HH:mm"

            guard let date = oldFormatter.date(from: dateStr) else { return "Not available" }
            return newFormat.string(from: date)
        }

        set {
            dateStr = newValue
        }
    }

    init(wrappedValue: String) {
        self.dateStr = wrappedValue
    }
}

@propertyWrapper
struct FormattedPrice {
    var value: String
    
    var wrappedValue: String {
        get {
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let number = NSNumber(value: Double(value) ?? 0.0)
            
            return formatter.string(from: number) ?? "Not available"
        }

        set {
            value = newValue
        }
    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue
    }
}
