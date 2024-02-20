//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

class YourFirstPipeline: ObservableObject {
    var characterLimit = 30
    @Published var data = ""
    @Published var count = 0
    @Published var color = Color.gray
    private var cancellable: Set<AnyCancellable> = []
    
    init() {
        $data
            .map({ value -> Int in
                return self.data.count
            })
            .assign(to: &$count)
        
        $count
            .map({ [unowned self] count -> Color in
                let eightyPercent = Int(Double(characterLimit) * 0.8)
                if (eightyPercent...self.characterLimit).contains(count) {
                    return Color.yellow
                } else if count > characterLimit {
                    return Color.red
                }
                return Color.gray
            })
            .assign(to: &$color)
    }
    
    func cancelAllValidations() {
        cancellable.removeAll()
    }
}
