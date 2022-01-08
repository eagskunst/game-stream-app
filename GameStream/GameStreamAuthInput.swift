//
//  GameStreamInput.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 29/12/21.
//

import SwiftUI

struct GameStreamAuthInput<Content: View>: View {
    let input: () -> Content
    let title: String
    let placeholderText: String
    let showPlaceholder: Bool
    let inputTextColor: Color
    
    init(
        title: String,
        placeholderText: String,
        showPlaceholder: Bool,
        aligment: Alignment = .leading,
        inputTextColor: Color = Color.black,
        input: @escaping () -> Content
    ) {
        self.input = input
        self.title = title
        self.placeholderText = placeholderText
        self.showPlaceholder = showPlaceholder
        self.inputTextColor = inputTextColor
    }
    var body: some View {
        Text(title)
            .foregroundColor(Color("dark_cyan"))
        
        ZStack(alignment: .leading){
            input()
                .frame(width: .infinity)
                .foregroundColor(inputTextColor)
                .placeholder(
                when: self.showPlaceholder
            ) {
                Text(self.placeholderText)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        Divider()
            .frame(height: 1)
            .background(Color("dark_cyan"))
            .padding(.bottom)
    }
}

struct GameStreamInput_Previews: PreviewProvider {
    
    
    static var previews: some View {
        VStack {
            GameStreamAuthInput(
                title: "Nombre",
                placeholderText: "Stark",
                showPlaceholder: true
            ) {
                TextField(
                    "",
                    text: .constant("")
                )
            }
            
            GameStreamAuthInput(
                title: "Apellido",
                placeholderText: "Stark",
                showPlaceholder: false
            ) {
                TextField(
                    "",
                    text: .constant("Stark")
                )
            }
        }
    }
}
