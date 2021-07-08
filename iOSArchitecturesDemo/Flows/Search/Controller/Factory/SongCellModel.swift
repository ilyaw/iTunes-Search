//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 08.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let songTitle: String
    let coverPhoto: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        var songTitle: String = ""
        if let artistName = model.artistName {
            songTitle = "\(artistName) - "
        }
        
        songTitle += model.trackName
        
        return SongCellModel(songTitle: songTitle, coverPhoto: model.artwork)
    }
}
