//
//  Array+Element.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/11/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation

extension Array where Element: Tagged {
    func filterTagged(with targetTags:Set<Character>) -> [Element] {
        if targetTags.isEmpty {
            return self
        }
        return self.filter() { !Set($0.tags).isDisjoint(with: targetTags) }
    }
}

extension Array where Element: TimeFramed {

    typealias ActiveFilterDate = ([Element], Date)
    typealias ActiveFilterSoonDate =  ([Element], [Element], Date)

    func filterActive(for date: Date) -> ActiveFilterDate {
        var validUntil = Date.distantFuture
        var active = [Element]()
        for aModel in self {
            assert(aModel.startsAt < aModel.finishesAt)
            // Закончилась в прошлом
            if aModel.finishesAt <= date { continue }
                // Начнется и закончится в будущем
            else if aModel.startsAt > date {
                validUntil = Swift.min(validUntil, aModel.startsAt)
            }
                // Уже началась и еще не закончилась
            else {
                validUntil = Swift.min(validUntil, aModel.finishesAt)
                active.append(aModel)
            }
        }
        return (active, validUntil)
    }

    func filterActiveWithSoon(for date: Date) -> ActiveFilterSoonDate {
        var validUntil = Date.distantFuture
        var active = [Element]()
        var soon = [Element]()
        for aModel in self {
            assert(aModel.startsAt < aModel.finishesAt)
            // Закончилась в прошлом
            if aModel.finishesAt <= date { continue }
                // Начнется и закончится в будущем
            else if aModel.startsAt > date {
                validUntil = Swift.min(validUntil, aModel.startsAt)
                soon.append(aModel)
            }
                // Уже началась и еще не закончилась
            else {
                validUntil = Swift.min(validUntil, aModel.finishesAt)
                active.append(aModel)
            }
        }
        return (active, soon, validUntil)
    }
}

extension Array {
    func item(at index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
