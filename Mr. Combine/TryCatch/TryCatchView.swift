//
//  TryCatchVM.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/20/24.
//

import SwiftUI

struct TryCatchView: View {
    @StateObject private var vm = TryCatch()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("Try Catch",
                           subtitle: "Introduction",
                           desc: "The tryCatch operator will work just like catch but also allow you to throw an error within the closure.")
                List(vm.dataToView, id: \.self) { value in
                    Text(value)
                }
                .listStyle(.plain)
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
            .font(.title)
            .alert(item: $vm.error) { error in
                Alert(title: Text("Error"), message: Text("Failing fetched the data"))
            }
            .onAppear() {
                vm.fetch()
            }
        }
    }
}


#Preview {
    TryCatchView()
}
