//
//  ProfileImageRetriever.swift
//  GameStream
//
//  Created by Emmanuel Guerra on 25/1/22.
//

import UIKit

class ProfileImageRetriever {
    func retrieveUiImage(named: String) -> UIImage? {
        if let dir = try? FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ) {
            let url = URL(fileURLWithPath: dir.absoluteString)
                .appendingPathComponent(named).path
            return UIImage(contentsOfFile: url)
        }
        
        return nil
    }
}
