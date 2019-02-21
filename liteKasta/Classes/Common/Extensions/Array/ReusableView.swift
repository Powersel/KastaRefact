//
//  ReusableView.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/21/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import UIKit

protocol ReusableView where Self: UIView  {
    func prepareForReuse()
}
