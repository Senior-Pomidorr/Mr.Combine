//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = JustIntroViewModel()
    @State private var age = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("PassthroughSubject",
                       subtitle: "Introduction",
                       desc: "The just publisher.")
            .layoutPriority(1)
            
            HStack {
                TextField("credit card number", text: $vm.creditCard)
                Group {
                    switch (vm.status) {
                    case .ok:                        Image(systemName: "checkmark.circle.fill")     .foregroundStyle(.green)              
                    case .invalid:                        Image(systemName: "x.circle.fill")          .foregroundStyle(.red)
                    default: EmptyView()
                    }
                }
            }
            .padding()
            Button("Verify CC Number") {                vm.verifyCreditCard.send(vm.creditCard)
            }
            .font(.title)
        }
    }
}

#Preview {
    ContentView()
}
