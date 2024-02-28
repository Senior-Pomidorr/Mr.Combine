//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine



struct InvalidNumberError: Error, Identifiable {
    var id = UUID()
}

final class AllSatisfy: ObservableObject {
    @Published var title = ""
    @Published var data: [String] = []
    @Published var count = 0
    
    func fetch() {
        title = "Major Rivers"
        let dataIn = ["Mississippi", "Nile", "Yangtze", "Danube", "Ganges", "Amazon", "Volga", "Rhine"]
        
        data = dataIn
        
        dataIn.publisher
            .count()
            .assign(to: &$count)
    }
}
