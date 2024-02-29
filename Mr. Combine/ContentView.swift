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
                
                Button("Fetch Data") {
                    vm.fetch()
                }
                
                if vm.isFetching {
                    ProgressView("Fetching....")
                }
                
                Spacer(minLength: 0)
            }
            .font(.title)
            .alert(item: $vm.timeOutError) { timeOutError in
                Alert(title: Text(timeOutError.title), message: Text(timeOutError.message))
            }
        }
    }
}


#Preview {
    NavigationStack {
        ContentView()
    }
}
