//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine



struct Profile: Identifiable {
    var id = UUID()
    var name = ""
    var city = ""
}

final class ViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    @Published var maxValue = ""

    let dataIn = [Profile(name: "Igor", city: "Moscow"),
                  Profile(name: "Rebecca", city: "Atlanta"),
                  Profile(name: "Christina", city: "Stuttgart"),
                  Profile(name: "Lorenzo", city: "Rome"),
                  Profile(name: "Oliver", city: "London")]
    
    func fetch() {
        
        profiles = dataIn
        
        _ = dataIn.publisher
            .max { currentItem, nextItem in
                return currentItem.city < nextItem.city
            }
            .sink(receiveValue: { [unowned self] profile in
                maxValue = profile.city
            })
    }
}
