//
//  Model.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 7/1/22.
//

import Foundation

struct SearchedGames: Codable {
    var results: [Game]
}

struct Game: Codable, Hashable {
    var title: String
    var studio: String
    var contentRaiting: String
    var publicationYear: String
    var description: String
    var platforms: [String]
    var tags: [String]
    var videosUrls: VideoUrl
    var galleryImages: [String]
}

struct VideoUrl: Codable, Hashable {
    var mobile: String
    var tablet: String
}
