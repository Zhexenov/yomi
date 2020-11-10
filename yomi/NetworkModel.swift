//
//  NetworkModel.swift
//  yomi
//
//  Created by Samat Zhexenov on 11/10/20.
//

import Foundation


struct Place : Decodable {
    let placeId: String
    let name: String
}


struct SearchResponse : Decodable {
    var results: [Place]
}
