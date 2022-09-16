//
//  WeatherTypeTests.swift
//  WeatherAppTaskTests
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import XCTest

class WeatherTypeTests: XCTestCase {
    func test_get_correct_type_from_not_formatted_string() {
        let notFormattedText = "clear sky"
        
        XCTAssertEqual(WeatherType.getType(by: notFormattedText), .clearSky)
    }
}
