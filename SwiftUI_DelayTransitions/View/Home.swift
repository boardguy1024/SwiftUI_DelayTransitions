//
//  Home.swift
//  SwiftUI_DelayTransitions
//
//  Created by paku on 2023/12/03.
//

import SwiftUI

struct Home: View {
    
    @State var messages: [Message] = [
        Message(message: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s. "),
        Message(message: "Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.", isReply: true)
    ]
    
    @State var highlightMessage: Message?
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    ForEach(messages) { message in
                        ChatView(message: message)
                            .anchorPreference(key: BoundsPreference.self, value: .bounds, transform: { anchor in
                                
                                return [message.id: anchor]
                            })
                            .padding(message.isReply ? .leading : .trailing, 60)
                            .onLongPressGesture {
                                withAnimation(.easeInOut) {
                                    self.highlightMessage = message
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Transitions")
        }
        .overlay(content: {
            // highlightMessageがセットされたら、全画面にBlurViewをかける
            if highlightMessage != nil {
                Rectangle()
                    .fill(.ultraThinMaterial)
                    .ignoresSafeArea()
            }
        })
        // PreferenceValueが更新された場合、そのvalueを取得しViewをoverlayさせるためのもの
        .overlayPreferenceValue(BoundsPreference.self, { value in
            
            if let highlightMessage, let preference = value.first(where: { $0.key == highlightMessage.id}) {
                
                GeometryReader { proxy in
                    
                    // タップされた子View(CardView)のboundsをこの(親)階層で取得
                    let rect = proxy[preference.value]
                    
                    //同じポジション上にoverlayで同じmessageを表示する
                    ChatView(message: highlightMessage)
                        .frame(width: rect.width, height: rect.height)
                        .offset(x: rect.minX, y: rect.minY)
                        .id(highlightMessage.id)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                self.highlightMessage = nil
                            }
                        }
                }
                // transition処理には targetViewに idを付与させる必要がある
                // idを付与しないと余分なAnimationが発生して、チラつきのように見えるため
                .transition(.asymmetric(insertion: .identity, removal: .offset(x: 1)))
            }
            
            
        })
    }
    
    @ViewBuilder
    func ChatView(message: Message) -> some View {
        Text(message.message)
            .padding(15)
            .background(message.isReply ? .gray.opacity(0.2) : .blue)
            .foregroundStyle(message.isReply ? .black : .white)
            .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

#Preview {
    Home()
}
