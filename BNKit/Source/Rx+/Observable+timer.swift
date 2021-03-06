//
//  Observable+timer.swift
//  BNKit
//
//  Created by luojie on 2016/11/22.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import RxSwift
import RxCocoa

extension Observable where Element: FloatingPoint {
    
    public static func timer(duration: RxTimeInterval = RxTimeInterval.infinity, interval: RxTimeInterval = 1, ascending: Bool = false, scheduler: SchedulerType = MainScheduler.instance)
        -> Observable<TimeInterval> {
            let count = duration.isInfinite ? .max : Int(duration / interval) + 1
            return Observable<Int>.timer(0, period: interval, scheduler: scheduler)
                .map { TimeInterval($0) * interval }
                .map { ascending ? $0 : (duration - $0) }
                .take(count)
    }
}
