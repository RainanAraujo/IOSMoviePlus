//
//  TMBDMovie.swift
//  Movie+
//
//  Created by Rainan Araújo on 28/08/23.
//

import Foundation

struct TMDBMovie: Decodable {
    let results: [Movie]
}
