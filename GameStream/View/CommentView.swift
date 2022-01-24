//
//  CommentView.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 9/1/22.
//

import SwiftUI
import Kingfisher

struct CommentViewObject: Hashable {
    let userName: String
    let days: UInt
    let description: String
    let avatarUrl: String
    
    init(userName: String,
         days: UInt,
         description: String,
         avatarUrl: String) {
        self.userName = userName
        self.days = days
        self.description = description
        self.avatarUrl = avatarUrl
    }
}

struct CommentView: View {
    
    let commentVO: CommentViewObject
    
    init(_ commentVO: CommentViewObject) {
        self.commentVO = commentVO
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("blue_gray"))
            VStack {
                HStack(alignment: .top){
                    KFImage(URL(string: commentVO.avatarUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 45, height: 45)
                        .clipShape(Circle())
                    VStack(alignment: .leading){
                        Text(commentVO.userName)
                            .foregroundColor(.white)
                            .bold()
                            .font(.subheadline)
                            .padding(.bottom, 1)
                        Text("Hace \(commentVO.days) días")
                            .foregroundColor(.white)
                            .font(.caption)
                    }
                    Spacer()
                }
                Text(commentVO.description)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(.top, 8)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .frame(minHeight: 0, maxHeight: .infinity, alignment: .leading)
                Spacer()
            }.padding(15)
        }
    }
}

struct CommentView_Previews: PreviewProvider {
    static var previews: some View {
        let comment = CommentViewObject(
            userName: "Tony Stark",
            days: 7,
            description: "He visto que como media tiene una gran calificación, y estoy completamente de acuerdo. Es el mejor juego que he jugado sin ninguna duda, combina una buena trama con una buenísima experiencia de juego libre gracias a su inmenso mapa y actividades.",
            avatarUrl: "https://i.pravatar.cc/300"
        )
        CommentView(comment)
    }
}
