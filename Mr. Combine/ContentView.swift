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
            HeaderView("Just",
                       subtitle: "Introduction",
                       desc: "The just publisher.")
            .layoutPriority(1)
            
            Text("This week's winner:")
            Text(vm.data)
                .bold()
            
            Form {
                Section(header: Text("Contest Participants").padding().font(.headline)) {
                    List(vm.dataToView, id: \.self) { item in
                        Text(item)
                        
                    }
                }
            }
        }
        .font(.title)
        .onAppear() {
            vm.fetch()
        }
    }
}

#Preview {
    ContentView()
}
