//
//  GrayButton.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 29/12/21.
//

import SwiftUI

struct GrayButton: View {
    
    let text: String
    let width: CGFloat?
    let action: () -> Void
    let heigth: CGFloat?
    
    init(
        _ text: String,
        _ width: CGFloat? = nil,
        _ height: CGFloat? = nil,
        action: @escaping () -> Void
    ) {
        self.text = text
        self.action = action
        self.width = width
        self.heigth = height
    }
    
    var body: some View {
        ZStack {
            Button(action: self.action, label: {
                Text(text)
                    .foregroundColor(.white)
                    .bold()
                    .font(.body)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6.0)
                            .stroke(Color("blue_gray"))
                    )
                    .frame(width: width, height: heigth, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            }).background(Color("blue_gray"))
            .cornerRadius(6.0)
        }
    }
}

struct GrayButton_Previews: PreviewProvider {
    static var previews: some View {
        GrayButton("Facebook"){}
    }
}
