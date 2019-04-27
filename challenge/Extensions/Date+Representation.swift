//
//  Date+Representation.swift
//  challenge
//
//  Created by Oscar on 11/11/18.
//  Copyright © 2018 Oscar. All rights reserved.
//

import Foundation

extension Date {
    
    public var pretty: String {
        let currentDate = Date()
        if currentDate.years(from: self)   > 0 { return "больше года назад"   }
        if currentDate.months(from: self)  > 0 { return asString(in: .localeDateTime)  }
        if currentDate.weeks(from: self)   > 0 { return asString(in: .localeDateTime)   }
        if currentDate.days(from: self)    > 0 {
            let days = currentDate.days(from: self)
            if days == 1 {
                return "вчера в \(asString(in: .shortTime))"
            }
            else if days == 2 {
                return "позавчера в \(asString(in: .shortTime))"
            }
            else {
                return asString(in: .localeDateTime)
            }
        }
        if currentDate.hours(from: self)   > 0 {
            if NSCalendar.current.isDateInToday(self) {
                return "сегодня в \(self.asString(in: .shortTime))"
            } else if NSCalendar.current.isDateInYesterday(self) {
                return "вчера в \(self.asString(in: .shortTime))"
            } else {
                return asString(in: .localeDateTime)
            }
        }
        if currentDate.minutes(from: self) > 0 { return "\(currentDate.minutes(from: self)) мин. назад" }
        return "только что"
    }
    
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
}
