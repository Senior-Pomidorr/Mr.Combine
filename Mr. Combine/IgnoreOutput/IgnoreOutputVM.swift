//
//  IgnoreOutputVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//


import SwiftUI
import Combine


final class IgnoreOutputVM: ObservableObject {
    @Published var dataToView: [String] = []
    @Published var dataToView2: [String] = []
    let dataIn = ["Value 1", "Value 2", "Value 3"]
    
    
    func fetch() {
        _ = dataIn.publisher
            .sink { [unowned self] value in
                dataToView.append(value)
            }
        
        _ = dataIn.publisher
            .ignoreOutput()
            .sink(receiveCompletion: { [unowned self] completion in
                dataToView2.append("Pipeline Finished")
            }, receiveValue: { [unowned self] value in
                dataToView2.append("You should not see this")
            })
    }
    
    deinit {
        print("Unloaded IgnoreOutputVM_ViewModel")
    }
}

