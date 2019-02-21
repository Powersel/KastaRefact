//
//  TimeFramed.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/11/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation

protocol TimeFramed {
    var startsAt: Date { get }
    var finishesAt: Date { get }
}
