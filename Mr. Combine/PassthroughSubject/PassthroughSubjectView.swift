//
//  PassthroughSubjectView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 11.11.2024.
//

import SwiftUI

struct PassthroughSubjectView: View {
    
    @StateObject private var passthroughSubjectVM = PassthroughSubjectVM()
    
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("PassthroughSubject",
                       subtitle: "Introduction",
                       desc: "The PassthroughSubject publisher will send a value through a pipeline but not retain the value.")
            HStack {
                TextField("credit card number", text: $passthroughSubjectVM.creditCard)
                Group {
                    switch (passthroughSubjectVM.status) {
                    case .ok:
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                    case .invalid:
                        Image(systemName: "x.circle.fill")
                            .foregroundStyle(.red)
                    default:
                        EmptyView()
                    }
                }
            }
            .padding()
            Button("Verify CC Number") {
                passthroughSubjectVM.verifyCreditCart.send(passthroughSubjectVM.creditCard)
            }
            .font(.title)
        }
        Spacer()
    }
}
    
    #Preview {
        PassthroughSubjectView()
    }
