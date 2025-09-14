//
//  IconNames.swift
//  ChoreQuest
//
//  Created by Leonardo Soares on 24/08/2025.
//

import Foundation

struct IconNames {
    private init () { }
    
    struct Control {
        private init() { }
        
        static let play = "play.fill"
        static let stop = "stop.fill"
        static let pause = "pause.fill"
        static let plus = "plus.circle"
        static let cancel = "x.circle"
    }
    
    struct Status {
        private init() { }
        static let check = "checkmark.square.fill"
        static let cancelled = "x.circle.fill"
    }
    
    struct Objects {
        private init() { }
        static let pencilSquare = "square.and.pencil"
        static let ellipsis = "ellipsis.circle"
        static let pencilAndListClipboard = "pencil.and.list.clipboard"
        static let heardClipboard = "heart.text.clipboard"
        static let archiveBox = "archivebox"
        static let saveTray = "tray.and.arrow.down"
        static let trash = "trash"
    }
}
