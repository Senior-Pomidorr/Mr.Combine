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
            HeaderView("TryContains",
                       subtitle: "Introduction",
                       desc: "TryContains")
            .layoutPriority(1)
            
            Text("Look for salt water in")
            Picker("Place", selection: $vm.place) {
                Text("Nevada").tag("Nevada")
                Text("Utah").tag("Utah")
                Text("Mars").tag("Mars")
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button("Search") {
                vm.search()
            }
            Text("Result: \(vm.result)")
        }
        .padding(.bottom)
        .font(.title)
        .alert(item: $vm.invalidSelectionError) { error in
            Alert(title: Text("Invalid Selection"))
                  }
    }
}

#Preview {
    ContentView()
}
