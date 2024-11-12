//
//  PassthroughSubjectView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 11.11.2024.
//

import Foundation
import Combine

enum CreditCardStatus {
    case ok
    case invalid
    case notEvaluted
}

class PassthroughSubjectVM: ObservableObject {
    @Published var creditCard = ""
    @Published var status: CreditCardStatus = .notEvaluted
    let verifyCreditCart = PassthroughSubject<String, Never>()
    
    init() {
        verifyCreditCart
            .map({ creditCard -> CreditCardStatus in
                if creditCard.count == 16 {
                    return CreditCardStatus.ok
                } else {
                    return CreditCardStatus.invalid
                }
            })
            .assign(to: &$status)
    }
}
