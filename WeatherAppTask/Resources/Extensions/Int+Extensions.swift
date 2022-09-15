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
        utcDateFormatter.dateFormat = "E, d MMMM"
        
        let date = Date(timeIntervalSince1970: TimeInterval(self))

        return utcDateFormatter.string(from: date)
    }
}
