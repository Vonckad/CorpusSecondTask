//
//  TownModel.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 21.07.22.
//

import Foundation

struct TownModel: Decodable {
    var id_locale: Int
    var id: Int
    var name: String
    var lang: Int
    var logo: String
    var last_edit_time: Int
    var visible: Bool
    var city_is_regional: Bool
    var region: String
}

/*
 "id_locale": 32,
 "id": 3,
 "name": "Brest",
 "lang": 2,
 "logo": "https://krokapp.by/media/cities/218a03dd-7794-42f7-b95b-3de34a70c392.png",
 "last_edit_time": 1652690496,
 "visible": true,
 "city_is_regional": true,
 "region": "Brest region"
 */
