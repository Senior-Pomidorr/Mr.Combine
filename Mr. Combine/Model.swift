//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct UserId: Identifiable {
    let id = UUID()
    var email: String
    var name: String
}

final class ViewModel: ObservableObject {
    @Published var filtredData: [UserId] = []
    let dataIn = [UserId(email: "joe.m@gmail.com", name: "Joe M."),
                  UserId(email: "joe.m@gmail.com", name: "Joseph M."),
                  UserId(email: "christina@icloud.com", name: "Christina B."),
                  UserId(email: "enzo@enel.it", name: "Lorenzo D."),
                  UserId(email: "enzo@enel.it", name: "Enzo D.")]
    private var cancellable: AnyCancellable?
    
    
    func fetch() {
        cancellable = dataIn.publisher
            .removeDuplicates(by: { previousUserId, currentUserId in
                previousUserId.email == currentUserId.email
            })
            .sink(receiveValue: { [unowned self] data in
                self.filtredData.append(data)
            })
    }
}
