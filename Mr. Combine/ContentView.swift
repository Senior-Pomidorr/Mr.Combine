//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = FutureIntroViewModel()
    @State private var age = ""
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("Future",
                       subtitle: "Introduction",
                       desc: "The future publisher.")
            
            Button("Say Hello") {                
                vm.sayHello()
            }
            
            Text(vm.hello)                
                .padding(.bottom)
            
            Button("Say Goodbye") {                vm.sayGoodbye()
            }
            Text(vm.goodbye)
            Spacer()
        }
        .font(.title)
    }
}

#Preview {
    ContentView()
}
