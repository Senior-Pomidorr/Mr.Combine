//
//  TryFirstWhereView.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 21.11.2024.
//

import SwiftUI

struct TryFirstWhereView: View {
    @StateObject private var vm = TryFirstWhereVM()
    var body: some View {
        VStack(spacing: 20) {
            HeaderView("TryFirst",
                       subtitle: "Where",
                       desc: "Use tryFind(where: ) when you need to be able to throw an error in the pipeline.")
            .layoutPriority(1)
            
            TextField("search criteria", text: $vm.criteria)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Text("First Found: ") + Text(vm.firstFound).bold()
            Form {
                List(vm.deviceList, id: \.self) { device in
                    Text(device)
                }
            }
        }
        .font(.title)
        .alert(item: $vm.error) { error in
            Alert(title: Text("Error"), message: Text(error.description))
        }
    }
}

#Preview {
    TryFirstWhereView()
}
