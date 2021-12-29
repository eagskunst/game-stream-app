//
//  ViewExtensions.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 29/12/21.
//

import SwiftUI

extension View {
    
    func placeholder<Content: View>(
          when shouldShow: Bool,
          alignment: Alignment = .leading,
          @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
