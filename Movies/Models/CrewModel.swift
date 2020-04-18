//
//  CrewModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

struct CrewModel: Codable {
    var id: Int
    var cast: [Crew]
}

struct Crew: Codable {
  var cast_id: Int
  var character: String
  var credit_id: String
  var gender: Int
  var id: Int
  var name: String
  var order: Int
  var profile_path: String?
}
