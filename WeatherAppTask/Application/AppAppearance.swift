//
//  AppAppearance.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

final class AppApperance {
    static func setupDefault() {
        let navBarBackgroundColor: UIColor = UIColor.Custom.darkBlue
        let navBarTitleColor: UIColor = UIColor.Custom.white
        let navBarIconColor: UIColor = UIColor.Custom.white
        
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

