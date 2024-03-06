//
//  ContentView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 2/19/24.
//

import SwiftUI
import Combine

struct CollectView: View {
    @StateObject private var vm = ViewModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Collect",
                           subtitle: "Introduction",
                           desc: "Collect")
                
                Toggle(isOn: $vm.circles, label: {
                    Text("Circles")
                })
                .padding()
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))]){
                    ForEach(vm.dataToView, id: \.self) { item in
                        Image(systemName: item)
                    }
                }
            }
            .font(.title)
        }
//        .alert(item: $vm.error, content: { error in
//            Alert(title: Text("Error"), message: Text(error.description))
//        })
        .onAppear() {
            vm.fetch()
        }
    }
}



#Preview {
    NavigationStack {
        CollectView()
    }
}
