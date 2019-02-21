//
//  UIFont+Sizes.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/14/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import UIKit

extension UIFont {

    //MARK: Regular weight systen sizes
    static var regularWeight13: UIFont {
        return systemCustomizedFont(13, weight: UIFont.Weight.regular)
    }

    static var regularWeight14: UIFont {
        return systemCustomizedFont(14, weight: UIFont.Weight.regular)
    }

    static var regularWeight15: UIFont {
        return systemCustomizedFont(15, weight: UIFont.Weight.regular)
    }
}

extension UIFont {

    //MARK: Medium weight systen sizes
    static var mediumWeight13: UIFont {
        return systemCustomizedFont(13, weight: UIFont.Weight.medium)
    }

    static var mediumWeight17: UIFont {
        return systemCustomizedFont(17, weight: UIFont.Weight.medium)
    }
}

extension UIFont {

    private class func systemCustomizedFont(_ fontSize: CGFloat = 15,
                                            weight: UIFont.Weight) -> UIFont {
        return UIFont.systemFont(ofSize: fontSize, weight: weight)
    }
}
