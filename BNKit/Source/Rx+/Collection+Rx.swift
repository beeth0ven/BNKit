//
//  Collection+Rx.swift
//  WorkMap
//
//  Created by luojie on 16/9/22.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Collection where Iterator.Element: ObservableType {
    
    public func rx_group() -> Observable<[Iterator.Element.E]> {
        
        guard !self.isEmpty else {
            return .just([])
        }
        
        let observables = self.map {
            $0.asObservable()
                .map { $0 as Iterator.Element.E? }
                .catchError {
                    print($0); return .just(nil)
            }
        }
        
        return Observable.zip(observables) { $0 }
            .take(1)
            .map { $0.flatMap { $0 } }
    }
}
