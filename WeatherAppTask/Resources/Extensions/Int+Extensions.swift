//
//  Int+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

extension Int {
    func toDate() -> String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .medium
        utcDateFormatter.timeStyle = .none
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let date = Date()

        return utcDateFormatter.string(from: date)
    }
}
