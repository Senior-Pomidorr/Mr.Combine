//
//  FirstWhereView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct FirstWhereView: View {
    @StateObject private var vm = FirstWhereModel()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("First(Where: )",
                           subtitle: "Introduction",
                           desc: "First(Where: )")
                
                TextField("search criteria", text: $vm.criteria)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                 
                Text("First Found: ") + Text(vm.firstFound).bold()
                
                Form {
                    List(vm.deviceList, id: \.self) { item in
                        Text(item)
                    }
                }
            }
            .font(.title)
        }
        .onAppear() {
            vm.fetch()
        }
    }
}


#Preview {
    FirstWhereView()
}
