//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Filter",
                           subtitle: "Introduction",
                           desc: "Filter")
                
                HStack(spacing: 40) {
                    Button("Animals") {
                        vm.filterData(criteria: "Animal")
                    }
                    Button("People") {
                        vm.filterData(criteria: "Person")
                    }
                    Button("All") {
                        vm.filterData(criteria: " ")
                    }
                }
                
                List(vm.filtredData, id: \.self) { item in
                    Text(item)
                }
               
            }
            .font(.title)
        }
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
