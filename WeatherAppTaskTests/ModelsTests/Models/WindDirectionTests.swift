//
//  WindDirectionTests.swift
//  WeatherAppTaskTests
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import XCTest

class WindDirectionTests: XCTestCase {
    func test_each_degree_from_0_to_360_wind_direction_not_noWind() {
        
        (0...360).forEach { degree in
            let result = WindDirection.getType(by: degree)
            
            XCTAssertNotEqual(result, .noWind)
        }
    }
    
    func test_each_degree_from_upper_360_wind_direction_is_noWind() {
        (361...380).forEach { degree in
            let result = WindDirection.getType(by: degree)
            
            XCTAssertEqual(result, .noWind)
        }
    }
    
    func test_each_degree_from_test_dictionary_take_whrite_wind_type() {
        let testData: [Int: WindDirection] = [7: .north, 43: .northeast, 47: .northeast, 89: .east,
                                              170: .south, 250: .west, 350: .north]
        testData.forEach { degree, windDirection in
            let result = WindDirection.getType(by: degree)
            
            XCTAssertEqual(result, windDirection)
        }
    }
}
