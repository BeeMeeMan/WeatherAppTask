//
//  AppAppearance.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

final class AppApperance {
    static func setupDefault() {
        let navBarBackgroundColor: UIColor = UIColor.CustomColor.darkBlue
        let navBarTitleColor: UIColor = UIColor.CustomColor.white
        let navBarIconColor: UIColor = UIColor.CustomColor.white
        
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.largeTitleTextAttributes = [.foregroundColor: navBarTitleColor]
        appearence.titleTextAttributes = [.foregroundColor: navBarTitleColor]
        appearence.backgroundColor = navBarBackgroundColor

        let barAppearence = UINavigationBar.appearance()
        barAppearence.standardAppearance = appearence
        barAppearence.compactAppearance = appearence
        barAppearence.scrollEdgeAppearance = appearence

        barAppearence.prefersLargeTitles = false
        barAppearence.tintColor = navBarIconColor
        barAppearence.isTranslucent = true
        barAppearence.overrideUserInterfaceStyle = .dark
    }
}

