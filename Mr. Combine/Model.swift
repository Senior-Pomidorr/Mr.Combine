//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

class CurrentValueSubjectViewModel: ObservableObject {
    @Published var selection = "No name selected"
    var selectionSame = CurrentValueSubject<Bool, Never>(false)
    var cancellable: [AnyCancellable] = []
    
    init() {
        $selection
            .map { [unowned self] newValue -> Bool in
                if newValue == selection {
                    return true
                } else {
                    return false
                }
            }
            .sink { [unowned self] value  in
                selectionSame.value = value
                objectWillChange.send()
            }
            .store(in: &cancellable)
    }
}
