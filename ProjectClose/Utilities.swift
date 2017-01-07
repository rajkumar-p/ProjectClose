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
        let image = UIImage(named: imageName)?.withRenderingMode(.alwaysOriginal)

        tabBarItem.image = ProjectCloseUtilities.resizeImage(img: image!, to: CGSize(width: 30.0, height: 30.0))
        tabBarItem.setTitleTextAttributes(
                [
                        NSForegroundColorAttributeName: UIColor.red,
                        NSFontAttributeName: UIFont(name: "Lato-Regular", size: 21.0)!
                ], for: .selected)
        tabBarItem.setTitleTextAttributes(
                [
                        NSForegroundColorAttributeName: UIColor.red,
                        NSFontAttributeName: UIFont(name: "Lato-Regular", size: 11.0)!
                ], for: .normal)
    }

    static func styleNavigationBar(navigationBar: UINavigationBar, colorHexString: String) {
        navigationBar.setBackgroundImage(UIImage(color: UIColor(hexString: colorHexString)!), for: .default)
        navigationBar.shadowImage = UIImage(color: UIColor(hexString: colorHexString)!)
    }
}
