//
//  TextExtensions.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 23/1/22.
//

import SwiftUI

extension Text {
    func borderBackgroundlessStyle() -> some View {
        self.bold()
            .foregroundColor(Color.white)
            .frame(
                maxWidth: .infinity,
                alignment: .center)
            .padding(EdgeInsets(
                        top: 11,
                        leading: 18,
                        bottom: 11,
                        trailing: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 6.0)
                    .stroke(Color("dark_cyan"), lineWidth: 1.0)
                    .shadow(radius: 6)
            )
    }
}
