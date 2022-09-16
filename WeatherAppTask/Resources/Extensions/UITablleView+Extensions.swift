//
//  UITablleView+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 16.09.2022.
//

import Foundation
import UIKit

extension UITableView {
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
