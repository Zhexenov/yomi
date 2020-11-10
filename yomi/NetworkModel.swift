//
//  NetworkModel.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Foundation


struct Geometry : Decodable {
    let location: Location
}

struct Location : Decodable {
    let lat: Double
    let lng: Double
}


struct Place : Decodable {
    let name: String
    let geometry: Geometry
}


struct SearchResponse : Decodable {
    var results: [Place]
}
