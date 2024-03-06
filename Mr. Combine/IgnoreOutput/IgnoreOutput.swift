//
//  IgnoreOutput.swift
//  Mr. Combine
//
//  Created by Daniil Kulikovskiy on 3/6/24.
//

import SwiftUI

struct IgnoreOutput: View {
    @StateObject private var vm = IgnoreOutputVM()
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                HeaderView("IgnoreOutput",
                           subtitle: "Introduction",
                           desc: "IgnoreOutput")
                
                List(vm.dataToView, id: \.self) { item in
                    Text(item)
                }
                
                Text("Ignore Output:")
                    .bold()
                
                List(vm.dataToView2, id: \.self) { item in
                    Text(item)
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
    IgnoreOutput()
}
