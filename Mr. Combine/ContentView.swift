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
                HeaderView("removeDuplicates",
                           subtitle: "Introduction",
                           desc: "removeDuplicates")
                
                ScrollView {
                    ForEach(vm.filtredData, id: \.self) { data in
                        Text(data)
                        Divider()
                    }
                }
                DescView("Notice that only duplicates that are one-after-another are removed")
                    
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
