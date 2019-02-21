//
//  JSONDecoder+StandartDecoder.swift
//  liteKasta
//
//  Created by Sergiy.Shevchuk on 2/11/19.
//  Copyright © 2019 Markason LLC. All rights reserved.
//

import Foundation

extension JSONDecoder {

    static let kastaStandardDecoder: JSONDecoder = {
        let iso8601Full: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = LocalConstants.USDateFormat
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: LocalConstants.USLocale)
            return formatter
        }()

        let d = JSONDecoder()
        d.dateDecodingStrategy = .formatted(iso8601Full)
        return d
    }()

    private enum LocalConstants {
        static let USDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        static let USLocale = "en_US_POSIX"
    }
}
