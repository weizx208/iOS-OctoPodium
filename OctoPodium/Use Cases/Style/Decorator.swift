//
//  Decorator.swift
//  OctoPodium
//
//  Created by Nuno Gonçalves on 10/06/16.
//  Copyright © 2016 Nuno Gonçalves. All rights reserved.
//

struct Style {
    struct Decorator {
        
        static func decorateApp() {
            setUpTabsAppearance()
            setUpNavigationAppearance()
        }

        private static func setUpTabsAppearance() {
            let tabBarAppearance = UITabBar.appearance()
            tabBarAppearance.tintColor = .white
            tabBarAppearance.barTintColor = UIColor(hex: kColors.tabBarColor)
        }
        
        private static func setUpNavigationAppearance() {
            let appearance = UINavigationBar.appearance()
            appearance.barStyle = .black
            appearance.barTintColor = UIColor(hex: kColors.navigationBarColor)
            appearance.tintColor = .white
            
            appearance.titleTextAttributes = [
                NSAttributedStringKey.foregroundColor : UIColor.white,
            ]
        }

    }
}
