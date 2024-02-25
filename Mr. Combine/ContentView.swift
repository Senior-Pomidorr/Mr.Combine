//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var number = ""
    @State private var checkNumbers = false
    @StateObject private var vm = AllSatisfy()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("AllSatisfy",
                       subtitle: "Introduction",
                       desc: "AllSatisfy")
            .layoutPriority(1)
            
            HStack {
                TextField("add a number", text: $number)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numberPad)
                Button {
                    vm.add(number: number)
                    number = ""
                } label: {
                    Image(systemName: "plus")
                }
            }
            .padding()
            
            List(vm.numbers, id: \.self) { number in
                Text("\(number)")
            }
            Spacer(minLength: 0)
            Button("Fibanachi Numbers") {
                vm.allFibanachiCheck()
                checkNumbers = true
            }
            Text(vm.allFibanachiNumbers ? "Yes" : "No")
                .opacity(checkNumbers ? 1 : 0)
        }
        .padding(.bottom)
        .font(.title)
        .alert(item: $vm.invaliderror) { error in
            Alert(title: Text("A number was greather than 144"), primaryButton: .default(Text("Start Over"), action: {
                vm.numbers.removeAll()
            }),
                  secondaryButton: .cancel()
            )
        }
    }
}

#Preview {
    ContentView()
}
