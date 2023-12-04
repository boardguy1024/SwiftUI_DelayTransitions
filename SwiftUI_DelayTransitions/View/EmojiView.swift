//
//  EmojiView.swift
//  SwiftUI_DelayTransitions
//
//  Created by paku on 2023/12/04.
//

import SwiftUI

struct EmojiView: View {
    
    var message: Message
    var onTap: (String) -> Void
    
    var emojis: [String] = ["🤣","😘","😇"]
    
    @State var animateEmojis: [Bool] = Array(repeating: false, count: 3) // == false, false, false
    @State var startAnimate: Bool = false
    @Binding var highlighted: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            ForEach(emojis.indices, id: \.self) { index in
                Text(emojis[index])
                    .font(.system(size: 25))
                // scale 0.01 -> 1 で animation
                    .scaleEffect(animateEmojis[index] ? 1 : 0.01)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut.delay(Double(index) * 0.1)) {
                                animateEmojis[index] = true
                            }
                        }
                    }
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 8)
        .background(
            Capsule()
                .fill(.white)
                .mask {
                    if highlighted {
                        Capsule()
                        // CapSuleを leadingから scaleを 0 -> 1 にAnimation
                        // 細長い風船を膨らませるイメージ
                            .scaleEffect(startAnimate ? 1 : 0, anchor: .leading)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        startAnimate = true
                    }
                }
                .onChange(of: highlighted, { _, _ in
                    // emojiViewを非表示Animate
                    for index in emojis.indices {
                        withAnimation(.easeInOut) {
                            animateEmojis[index] = false
                        }
                    }
                })
        )
    }
}

#Preview {
    EmojiView(message: .init(message: "message"), onTap: { _ in }, highlighted: .constant(false))
        .shadow(radius: 10)
}
