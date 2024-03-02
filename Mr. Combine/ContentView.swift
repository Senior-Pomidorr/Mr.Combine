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
                HeaderView("Debounce",
                           subtitle: "Introduction",
                           desc: "debounce")
                
                List(vm.dataToView, id: \.self) { item in
                     Text(item)
                }
                Spacer(minLength: 0)
            }
            .font(.title)
            .alert(item: $vm.invalidValueError) { timeOutError in
                Alert(title: Text("Error"), message: Text(timeOutError.description))
            }
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
