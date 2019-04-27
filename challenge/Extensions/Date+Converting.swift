//
//  Date+Converting.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

public enum DateFormat: String {
    case shortTime = "HH:mm"
    case localeDate = "dd' 'MMM' 'yyyy"
    case localeDateTime = "dd' 'MMM' в 'HH':'mm"
    
    var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = rawValue
        return formatter
    }
}

extension Date {
    
    func asString(in format: DateFormat) -> String {
        return format.formatter.string(from: self)
    }
    
    static func from(string: String, format: DateFormat) -> Date? {
        return format.formatter.date(from: string)
    }
    
}
