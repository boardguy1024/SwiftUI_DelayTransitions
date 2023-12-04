//
//  BoundsPreference.swift
//  SwiftUI_DelayTransitions
//
//  Created by paku on 2023/12/03.
//

import SwiftUI

struct BoundsPreference: PreferenceKey {
    
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        
        // 次にViewの階層から追加される値が nextValue()で returnされる
        // keyが重複した場合、currentは上書きされていないcurrentValue
        //                 newValueは、言葉の通り新しい値で上書きされる
        value.merge(nextValue()) { currentValue, newValue in
            return newValue
        }
    }
}
