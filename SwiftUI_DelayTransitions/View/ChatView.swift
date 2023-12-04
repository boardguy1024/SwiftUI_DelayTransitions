//
//  ChatView.swift
//  SwiftUI_DelayTransitions
//
//  Created by paku on 2023/12/04.
//

import SwiftUI

struct ChatView: View {
    
    var message: Message
    var showEmojis: Bool = false
    @Binding var highlighted: Bool
    
    var body: some View {
        
        ZStack(alignment: .bottomLeading) {
            Text(message.message)
                .padding(15)
                .background(message.isReply ? .gray.opacity(0.2) : .blue)
                .foregroundStyle(message.isReply ? .black : .white)
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
            
            if showEmojis {
                EmojiView(message: message, onTap: { _ in }, highlighted: $highlighted)
                    .offset(y: 55)
            }
        }
    }
}

#Preview {
    ChatView(message: .init(message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s."), showEmojis: true, highlighted: .constant(true))
        .padding()
        .shadow(radius: 10)
}
