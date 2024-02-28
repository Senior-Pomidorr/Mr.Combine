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
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Try MAX",
                           subtitle: "Introduction",
                           desc: "MAX")
                .layoutPriority(1)
                List {
                    Section(footer: Text("Max: \(vm.maxValue)").bold()) {
                        ForEach(vm.data, id: \.self) { animal in
                            Text(animal)
                        }
                    }
                }
                
                List {
                    Section(footer: Text("Max: \(vm.maxNumbers)").bold()) {
                        ForEach(vm.numbers, id: \.self) { number in
                            Text(String(number))
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
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
