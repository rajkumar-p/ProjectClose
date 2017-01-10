//
//  Utilities.swift
//  ProjectClose
//
//  Created by raj on 03/01/17.
//  Copyright © 2017 diskodev. All rights reserved.
//

import UIKit

class ProjectCloseUtilities {
    static func resizeImage(img: UIImage, to: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(to)
        img.draw(in: CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: to))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    static func styleTabBarItem(tabBarItem: UITabBarItem, imageName: String) {
        let image = UIImage(named: imageName)

        tabBarItem.image = ProjectCloseUtilities.resizeImage(img: image!, to: CGSize(width: 30.0, height: 30.0)).withRenderingMode(.alwaysOriginal)
        tabBarItem.selectedImage = ProjectCloseUtilities.resizeImage(img: image!, to: CGSize(width: 30.0, height: 30.0))
    }

    static func styleNavigationBar(navigationBar: UINavigationBar, colorHexString: String) {
        navigationBar.setBackgroundImage(UIImage(color: UIColor(hexString: colorHexString)!), for: .default)
        navigationBar.shadowImage = UIImage(color: UIColor(hexString: colorHexString)!)

        navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: UIColor(hexString: ProjectCloseColors.allViewControllersNavigationBarTitleColor)!,
                NSFontAttributeName: UIFont(name: ProjectCloseFonts.allViewControllersNavigationBarTitleFont, size: 22.0)!
        ]
    }
}
