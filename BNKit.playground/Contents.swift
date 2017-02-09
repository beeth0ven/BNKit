/*:
 # BNKit
 Use this playground to try out BNKit
 */
import PlaygroundSupport
import BNKit
import RxSwift
import RxCocoa
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true
//
//let calender = Calendar.current
//
//let todayComponents = calender.dateComponents([.year, .month], from: Date())
////
////let firstOfMonth = calender.date(from: todayComponents)!
////
////var deltaComponents = DateComponents()
////deltaComponents.month = 1
////deltaComponents.day = -1
////
////let lastOfMonth = calender.date(byAdding: deltaComponents, to: firstOfMonth)
//
////let date = calender.date(from: DateComponents(year: 2016, month: 2, day: 0))!
////let day = calender.component(.day, from: date)
//
//struct Year {
//    let id: Int
//    lazy var months: [Month] = []
//    lazy var weeks: [Week] = []
//}
//
//struct Month {
//    let yearId: Int
//    let id: Int
//    
//    lazy var days: [Day] = {
//        let lastDayDate = calender.date(from: DateComponents(year: self.yearId, month: self.id + 1, day: 0))!
//        let lastDay = calender.component(.day, from: lastDayDate)
//        return (1...lastDay).map { Day(yearId: self.yearId, monthId: self.id, id: $0) }
//    }()
//    
//    lazy var weeks: [Week] = {
//        let lastDay = self.days.last!
//        let lastWeekOfMonthId = DateComponents(year: lastDay.yearId, month: lastDay.monthId, day: lastDay.id).normalized().weekOfMonth!
//        return (1...lastWeekOfMonthId).map { Week(yearId: self.yearId, monthId: self.id, weekOfMonthId: $0) }
//    }()
//    
//    lazy var calenderDays: [Day] = {
//        var days = [Day]()
//        for var week in self.weeks {
//            days += week.days
//        }
//        return days
//    }()
//    
//    init(yearId: Int, id: Int) {
//        self.yearId = yearId
//        self.id = id
//    }
//}
//
//struct Week {
//    let yearId: Int
//    let monthId: Int
//    let weekOfMonthId: Int
//    lazy var days: [Day] = (1...7).map {
//        let components = DateComponents(year: self.yearId, month: self.monthId, weekday: $0, weekOfMonth: self.weekOfMonthId).normalized()
//        return Day(yearId: components.year!, monthId: components.month!, id: components.day!)
//    }
//    
//    init(yearId: Int, monthId: Int, weekOfMonthId: Int) {
//        self.yearId = yearId
//        self.monthId = monthId
//        self.weekOfMonthId = weekOfMonthId
//    }
//}
//
//struct Day {
//    let yearId: Int
//    let monthId: Int
//    let id: Int
//}
//
//extension Month {
//    static var current: Month {
//        let currentComponents = calender.dateComponents([.year, .month], from: Date())
//        return Month(yearId: currentComponents.year!, id: currentComponents.month!)
//    }
//    
//    func next() -> Month {
//        let components = DateComponents(year: yearId, month: id + 1).normalized()
//        return Month(yearId: components.year!, id: components.month!)
//    }
//    
//    func previous() -> Month {
//        let components = DateComponents(year: yearId, month: id - 1).normalized()
//        return Month(yearId: components.year!, id: components.month!)
//    }
//}
//
//
//extension DateComponents {
//    
//    func normalized() -> DateComponents {
//        let date = Calendar.current.date(from: self)!
//        let components: Set<Calendar.Component> = [
//            .year,
//            .month,
//            .day,
//            .weekday,
//            .weekOfMonth,
//        ]
//        
//        return Calendar.current.dateComponents(components , from: date)
//    }
//}
//
////var week = Week(yearId: 2017, monthId: 1, weekOfMonthId: 0)
////var month = Month.current.previous().previous()
////
////
////month.calenderDays.forEach {
////    print($0)
////}
//
//extension Date {
//    
//    var year: Int {
//        return Calendar.current.component(.year, from: self)
//    }
//    
//    var month: Int {
//        return Calendar.current.component(.month, from: self)
//    }
//    
//    var weekday: Int {
//        return Calendar.current.component(.weekday, from: self)
//    }
//    
//    var previousMonth: Date {
//        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
//    }
//    
//    var nextMonth: Date {
//        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
//    }
//}
//
//
////var date = Date()
////date.year = 2016
////date
//
//extension Date: Strideable {
//    public typealias Stride = TimeInterval
//    
//
//    public func distance(to other: Date) -> TimeInterval {
//        return other - self
//    }
//    
//
//    public func advanced(by n: TimeInterval) -> Date {
//        return self + n
//    }
//}
//
//let date = Date().nextMonth.nextMonth
//
//let dateInterval = Calendar.current.dateInterval(of: .month, for: date)!
//
//dateInterval.start
//dateInterval.end
//
//dateInterval.start - Double(dateInterval.start.weekday - 1) * 1.0.days
//dateInterval.end + Double((8 - dateInterval.end.weekday) % 7) * 1.0.days
//



