//
//  Extensions.swift
//  projetoCovidMVVM
//
//  Created by Roberto Edgar Geiss on 18/02/23.
//

import Foundation
import UIKit

extension String
{
    func toCurrencyFormat() -> String
    {
        if let doubleValue = Double(self)
        {
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "pt_BR")
            numberFormatter.numberStyle = NumberFormatter.Style.currency
            return numberFormatter.string(from: NSNumber(value: doubleValue)) ?? ""
        }
        return ""
    }
    
    func toNumberFormat() -> String
    {
        if let int32Value = Int32(self)
        {
            let numberFormatter = NumberFormatter()
            numberFormatter.locale = Locale(identifier: "pt_BR")
            numberFormatter.numberStyle = NumberFormatter.Style.decimal
            numberFormatter.currencyGroupingSeparator = "."
            numberFormatter.groupingSize = 3
            return numberFormatter.string(from: NSNumber(value: int32Value)) ?? ""
        }
        return ""
    }
    
    func toShortDateFormat(style: DateFormatter.Style) -> String?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: self)
        else {return nil}
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: date)
    }

    func toDate(withFormat format: String = "yyyy-MM-dd")-> Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)

        return date
    }
}

extension UIImage
{
    var toData: Data?
    {
        return pngData()
    }
}

extension Date
{
    var startOfDay: Date
    {
        return Calendar.current.startOfDay(for: self)
    }

    var startOfMonth: Date
    {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.year, .month], from: self)

        return  calendar.date(from: components)!
    }

    var endOfDay: Date
    {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }

    var endOfMonth: Date
    {
        var components = DateComponents()
        components.month = 1
        components.second = -1
        return Calendar(identifier: .gregorian).date(byAdding: components, to: startOfMonth)!
    }

    func isMonday() -> Bool
    {
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.weekday], from: self)
        return components.weekday == 2
    }
}

extension Int
{
    func numberFormat() -> String
    {
        let formatter = NumberFormatter()
        
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.groupingSeparator = "."
        
        return formatter.string(from: NSNumber(value: self))!
    }
}

extension String
{
    func replaceSpace(with: String) -> String
    {
        let stringWithoutSpace = self.replacingOccurrences(of: " ", with: "\(with)")
        
        return stringWithoutSpace
    }
}

extension Date
{
    func convertToMonthYearFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        
        return dateFormatter.string(from: self)
    }
}

extension Double
{
    func rounded(by places: Int) -> Double
    {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func getDateFromTimeStamp() -> String
    {
        let dateFromServer = NSDate(timeIntervalSince1970: self / 1000)
        let dateFormatter = DateFormatter()

        dateFormatter.timeStyle = .short
        dateFormatter.dateStyle = .full
        
        let string = dateFormatter.string(from: dateFromServer as Date)
        
        return string
    }
}

extension Optional where Wrapped == String
{
    
    public var defaulted: String
    {
        if let uSelf = self
        {
            return uSelf
        }
        return "---"
    }
}

public extension Bundle
{
    static var version: String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String? ?? "1.0"
    }
    
    static var build: String
    {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String? ?? "1"
    }
    
    static var versionBuild: String
    {
        return "\(version) (\(build))"
    }
}

extension Dictionary
{
    subscript(i: Int) -> (key: Key, value: Value)
    {
        return self[index(startIndex, offsetBy: i)]
    }
}
