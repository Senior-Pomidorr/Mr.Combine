//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

final class ViewModel: ObservableObject {
    @Published var name = ""
    @Published var nameEntered = ""
    
    init() {
        $name
            .debounce(for: 0.5, scheduler: RunLoop.main)
            .assign(to: &$nameEntered)
    }
}
