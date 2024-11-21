//
//  TryFirstWhereVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
/*  The tryFirst(where:) operator works just like first(where:) except it also has the ability to throw errors from the provided closure. If
 an error is thrown, the pipeline closes and finishes. Any try operator marks the downstream pipeline as being able to fail which means that you will have to handle potential errors in some way. */

import Foundation
import Combine

class TryFirstWhereVM: ObservableObject {
    @Published var firstFound = ""
    @Published var deviceList = ["iPhone 4", "iPhone 15", "Google Pixel", "iPad Pro (14-inch)", "MacBook Pro 20-inch"]
    @Published var criteria = ""
    @Published var error: ErrorForAlert?
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $criteria
            .dropFirst()
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [unowned self] value in
                self.findFirst(criteria: value)
            }
            .store(in: &cancellables)
    }
    
    func findFirst(criteria: String) {
        deviceList.publisher
            .tryFirst { value in
                if value == "Google" {
                    throw ErrorForAlert()
                }
                return value.contains(criteria)
            }
            .replaceEmpty(with: "Value not found")
            .sink { [unowned self] completion in
                if case .failure(let error) = completion {
                    self.error = error as? ErrorForAlert
                }
            } receiveValue: { [unowned self] foundDevice in
                firstFound = foundDevice
            }
            .store(in: &cancellables)
    }
    
}
