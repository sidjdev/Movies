//
//  StringExtensions.swift
//  Movies
//
//  Created by Sidharth J Dev on 19/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation

extension String {
    func replace_fromStart(endIndex:Int , With:String) -> String {
        var strReplaced = self
        let start = self.startIndex
        let end = self.index(self.startIndex, offsetBy: endIndex)
        strReplaced = self.replacingCharacters(in: start..<end, with: With)
        return strReplaced
    }
}
