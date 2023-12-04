//
//  Message.swift
//  SwiftUI_DelayTransitions
//
//  Created by paku on 2023/12/03.
//

import SwiftUI

struct Message: Identifiable {
    var id: String = UUID().uuidString
    var message: String
    var isReply: Bool = false
    var emojiValue: String = ""
    var isEmojiAdded: Bool = false
}
