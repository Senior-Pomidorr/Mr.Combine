//
//  Merge.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/12/24.
//

import Foundation
import Combine

//«Pipelines that send out the same type can be merged together so items that come from them will all come together and be sent down the same pipeline to the subscriber. Using the merge operator you can connect up to eight publishers total. You can merge up to seven additional publishers of the same type to your main publisher.»

final class Merge: ObservableObject {
    @Published var dataToView: [String] = []
    private var authors = ["Picasso", "Michelangelo"]
    private var colors = ["red", "purple", "blue", "orange"]
    private var numbers = ["1", "2", "3"]
    
    func fetch() {
        _ = authors.publisher
            .merge(with: colors.publisher, numbers.publisher)
            .sink(receiveValue: { [unowned self] value in
                dataToView.append(value)
            })
    }
}
