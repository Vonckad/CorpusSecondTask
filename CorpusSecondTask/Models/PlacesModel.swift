//
//  PlacesModel.swift
//  CorpusSecondTask
//
//  Created by Vlad Ralovich on 22.07.22.
//

import Foundation

struct PlacesModel: Decodable {
    var id_point: Int
    var name: String
    var text: String?
//    var sound: String?
    var lang: Int
//    var last_edit_time: Int?
    var creation_date: String
//    var lat: Float?
//    var lng: Float?
    var logo: String?
//    var photo: String?
    var city_id: Int
//    var visible: Bool
    var images: [String]?
//    var tags: [Int]?
//    var is_excursion: Bool?
}
/*
 "id": 65,
        "id_point": 65,
        "name": "Крыжаўзвіжанская праваслаўная царква",
        "text": "<p>Царква, якая ніколі не зачынялася.</p>",
        "sound": "https://krokapp.by/media/sound/22fbe7ca-9bf2-4f8c-a0ff-9a71fdcb0f10.ogg",
        "lang": 1,
        "last_edit_time": 1561539805,
        "creation_date": "25-07-2017",
        "lat": 53.298291,
        "lng": 28.638607,
        "logo": "https://krokapp.by/media/place_logo/065cd06a-38af-475e-85c5-ea8ae144a449.png",
        "photo": "https://krokapp.by/media/pi/d504da72-3891-445f-94f5-553a251f3b82.jpg",
        "city_id": 24,
        "visible": true,
        "images": [
            "https://krokapp.by/media/pi/d504da72-3891-445f-94f5-553a251f3b82.jpg"
        ],
        "tags": [
            1
        ],
        "is_excursion": false
 */
