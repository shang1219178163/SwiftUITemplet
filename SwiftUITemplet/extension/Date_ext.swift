//
//  Date_ext.swift
//  SwiftUITemplet
//
//  Created by Bin Shang on 2025/2/27.
//


import Foundation
/*
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */


/// 60s
public let kDateMinute: Double = 60
/// 3600s
public let kDateHour: Double   = 3600
/// 86400
public let kDateDay: Double    = 86400
/// 604800
public let kDateWeek: Double   = 604800
/// 31556926
public let kDateYear: Double   = 31556926


/// yyyy-MM-dd HH:mm:ss(默认)
public let kDateFormat            = "yyyy-MM-dd HH:mm:ss"
/// yyyy-MM
public let kDateFormatMonth       = "yyyy-MM"
/// yyyy-MM-dd
public let kDateFormatDay         = "yyyy-MM-dd"
/// yyyy-MM-dd HH
public let kDateFormatHour        = "yyyy-MM-dd HH"
/// yyyy-MM-dd HH:mm
public let kDateFormatMinute      = "yyyy-MM-dd HH:mm"
/// yyyy-MM-dd HH:mm:ss eee
public let kDateFormatMillisecond = "yyyy-MM-dd HH:mm:ss eee"
/// yyyy-MM-dd 00:00:00
public let kDateFormatBegin       = "yyyy-MM-dd 00:00:00"
/// yyyy-MM-dd 23:59:59
public let kDateFormatEnd         = "yyyy-MM-dd 23:59:59"

/// yyyy-MM-dd HH:mm:00
public let kTimeFormatBegin       = "yyyy-MM-dd HH:mm:00"
/// yyyy-MM-dd HH:mm:59
public let kTimeFormatEnd         = "yyyy-MM-dd HH:mm:59"

/// yyyy年M月
public let kDateFormatMonth_CH    = "yyyy年MM月"
/// yyyy年MM月dd日
public let kDateFormatDay_CH      = "yyyy年MM月dd日"
/// yyyyMMdd
public let kDateFormatTwo         = "yyyyMMdd"


@objc public extension DateFormatter{
    
    ///日期格式
    enum FormatStyle: String {
        /// yyyy-MM-dd HH:mm:ss(默认)
        case Default      = "yyyy-MM-dd HH:mm:ss"
        /// yyyy-MM
        case Month        = "yyyy-MM"
        /// yyyy-MM-dd
        case Day          = "yyyy-MM-dd"
        /// yyyy-MM-dd HH
        case Hour         = "yyyy-MM-dd HH"
        /// yyyy-MM-dd HH:mm
        case Minute       = "yyyy-MM-dd HH:mm"
        /// yyyy-MM-dd HH:mm:ss eee
        case Millisecond  = "yyyy-MM-dd HH:mm:ss eee"
        /// yyyy-MM-dd 00:00:00
        case BeginDay     = "yyyy-MM-dd 00:00:00"
        /// yyyy-MM-dd 23:59:59
        case EndDay       = "yyyy-MM-dd 23:59:59"
        /// yyyy-MM-dd HH:mm:00
        case BeginSecond  = "yyyy-MM-dd HH:mm:00"
        /// yyyy-MM-dd HH:mm:59
        case EndSecond    = "yyyy-MM-dd HH:mm:59"
        /// yyyy年M月
        case Month_CH     = "yyyy年MM月"
        /// yyyy年MM月dd日
        case Day_CH       = "yyyy年MM月dd日"
    }
    
    /// 获取DateFormatter(默认格式)
    static func format(_ formatStr: String = kDateFormat) -> DateFormatter {
        let dic = Thread.current.threadDictionary
        if let formatter = dic.object(forKey: formatStr) as? DateFormatter {
            return formatter
        }
        
        let fmt = DateFormatter()
        fmt.dateFormat = formatStr
        fmt.locale = .current
        fmt.locale = Locale(identifier: "zh_CN")
        fmt.timeZone = formatStr.contains("GMT") ? TimeZone(identifier: "GMT") : TimeZone.current
        dic.setObject(fmt, forKey: (formatStr as NSString))
        return fmt
    }
    
    /// Date -> String
    static func stringFromDate(_ date: Date, fmt: String = kDateFormat) -> String {
        let formatter = DateFormatter.format(fmt)
        return formatter.string(from: date)
    }
    
    /// String -> Date
    static func dateFromString(_ dateStr: String, fmt: String = kDateFormat) -> Date? {
        let formatter = DateFormatter.format(fmt)
        let tmp = dateStr.count <= fmt.count ? dateStr : (dateStr as NSString).substring(to: fmt.count)
        let result = formatter.date(from: tmp)
        return result
    }
    
    /// 时间戳字符串 -> 日期字符串
    static func stringFromTimestamp(_ timestamp: String, fmt: String = kDateFormat) -> String {
        guard let timeInterval = Double(timestamp) else { return "" }
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.stringFromDate(date, fmt: fmt)
    }

    /// 日期字符串 -> 时间戳字符串
    static func timestampFromDateStr(_ dateStr: String, fmt: String = kDateFormat) -> String {
        guard let date = DateFormatter.dateFromString(dateStr, fmt: fmt) else {
            return "0" }
        return "\(date.timeIntervalSince1970)"
    }
}

public extension Date{

    /// 年
    var year: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).year ?? 0
    }
    /// 月
    var month: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).month ?? 0
    }

    /// 日
    var day: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).day ?? 0
    }
    /// 时
    var hour: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).hour ?? 0
    }
    /// 分
    var minute: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).minute ?? 0
    }
    /// 秒
    var second: Int {
        return Calendar.shared.dateComponents(Calendar.unitFlags, from: self).second ?? 0
    }
    
    /// 时间戳
    var timeStamp: Int {
        return Int(self.timeIntervalSince1970)
    }
    
    /// 时间戳
    var timeStamp13: Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
    
    /// 当月天数
    var countOfDaysInMonth: Int {
        let calendar = Calendar.shared
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: self)
        return range.length
    }
    /// 当月第一天是星期几
    var firstWeekDay: Int {
        return Calendar.shared.firstWeekday
    }
    
    var minimumDaysInFirstWeek: Int {
        return Calendar.shared.minimumDaysInFirstWeek
    }
    
    ///是否是今年
    var isThisYear: Bool {
        let comp = Calendar.shared.dateComponents(Calendar.unitFlags, from: self)
        let comp1 = Calendar.shared.dateComponents(Calendar.unitFlags, from: Date())
        
        let isSame = (comp1.year == comp.year)
        return isSame
    }
    
    ///是否是这个月
    var isThisMonth: Bool {
        let comp = Calendar.shared.dateComponents(Calendar.unitFlags, from: self)
        let comp1 = Calendar.shared.dateComponents(Calendar.unitFlags, from: Date())
        
        let isSame = (comp1.year == comp.year && comp1.month == comp.month)
        return isSame
    }
    ///是否是今天
    var isToday: Bool {
        return Calendar.shared.isDateInToday(self)
    }

    ///****-**-** 00:00:00
    var dayBegin: String{
        let result = DateFormatter.stringFromDate(self, fmt: kDateFormatBegin)
        return result
    }
    
    ///****-**-** 23:59:59
    var dayEnd: String{
        let result = DateFormatter.stringFromDate(self, fmt: kDateFormatEnd)
        return result
    }
    
    func fmt(_ fmt: String = "yyyy-MM-dd HH:mm:ss") -> String {
        return DateFormatter.stringFromDate(self, fmt: fmt)
    }
        
    /// 现在时间上添加天:小时:分:秒(负数:之前时间, 正数: 将来时间) -> NSDate
    func adding(_ days: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date{
        let date = addingTimeInterval(TimeInterval(days*24*3600 + hour*3600 + minute*60 + second))
        return date
    }
    
    /// 现在时间上添加天:小时:分:秒(负数:之前时间, 正数: 将来时间) -> String
    func addingDaysDes(_ days: Int, fmt: String = kDateFormat) -> String{
        let newDate = adding(days)
        return DateFormatter.stringFromDate(newDate, fmt: fmt)
    }
    
    //MARK: - 获取日期各种值
            
    /// 一周的第几天
    static func weekDay(_ comp: DateComponents) ->Int{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        guard let newDate = Calendar.shared.date(from: comp) else { return 0 }
        let weekDay = Calendar.shared.component(.weekday, from: newDate)
        return weekDay
    }
    
    //MARK: 一周的第几天
    func weekDay(_ addDays: Int = 0) ->Int{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        var comp: DateComponents = Calendar.shared.dateComponents(Calendar.unitFlags, from: self)
        comp.day! += addDays

        let newDate = Calendar.shared.date(from: comp)
        let weekDay = Calendar.shared.component(.weekday, from: newDate!)
        return weekDay
    }
    
    //MARK: 周几
    func weekDayDes(_ addDays: Int = 0) ->String{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let dic: [String: String] = ["1": "周日",
                                     "2": "星期一",
                                     "3": "星期二",
                                     "4": "星期三",
                                     "5": "星期四",
                                     "6": "星期五",
                                     "7": "星期六"]
        
        let weekDay = "\(self.weekDay(addDays))"
        let result = dic.keys.contains(weekDay) ? dic[weekDay] : "-"
        return result!
    }
}


public extension Calendar{
    
    static let shared = Calendar(identifier: .gregorian)
    static let unitFlags: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second, .weekdayOrdinal, .weekday]
    
    /// eturn the number of days in the month for a specified 'Date'.
    ///
    ///        let date = Date() // "Jan 12, 2017, 7:07 PM"
    ///        Calendar.current.numberOfDaysInMonth(for: date) -> 31
    ///
    /// - Parameter date: the date form which the number of days in month is calculated.
    /// - Returns: The number of days in the month of 'Date'.
    func numberOfDaysInMonth(for date: Date) -> Int {
        return range(of: .day, in: .month, for: date)!.count
    }
}


public extension Locale{

    /// zh_CN
    static let zh_CN = Locale(identifier: "zh_CN")
    /// en_US
    static let en_US = Locale(identifier: "en_US")
}
