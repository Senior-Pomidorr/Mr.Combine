//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//  The collect operator won’t let items pass through the pipeline. Instead, it will put all items into an array, and then when the pipeline finishes it will publish the array. */

import SwiftUI
import Combine

struct InvalidValueError: Identifiable, Error {
    let id = UUID()
    var description = "There was a server error while retrieving values."
}

final class ViewModel: ObservableObject {
//    @Published var error: InvalidValueError?
    @Published var dataToView: [String] = []
    @Published var circles = false
    private var cachedData: [Int] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $circles
            .sink { [unowned self] shape in
                formatedData(shape: shape ? "circle": "square")
            }
            .store(in: &cancellables)
    }
    
    func fetch() {
        cachedData = Array(1...25)
        formatedData(shape: circles ? "circle": "square")
    }
    
    func formatedData(shape: String) {
        cachedData.publisher
            .map { "\($0).\(shape)"}
            .collect()
            .assign(to: &$dataToView)
    }
    
   
}
