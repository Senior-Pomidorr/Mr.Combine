//
//  Model.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

enum CreditCardStatus {
    case ok
    case invalid
    case notEvaluated
}

final class JustIntroViewModel: ObservableObject {
    @Published var creditCard = ""
    @Published var status = CreditCardStatus.notEvaluated
    var verifyCreditCard = PassthroughSubject<String, Never>()
    
    init() {
        verifyCreditCard
            .map { creditCard -> CreditCardStatus in
                if creditCard.count > 16 {
                    return CreditCardStatus.ok
                } else {
                    return CreditCardStatus.invalid
                }
            }
            .assign(to: &$status)
    }
}
