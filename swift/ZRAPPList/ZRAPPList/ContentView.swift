//
//  ContentView.swift
//  ZRAPPList
//
//  Created by 锐 张 on 2022/3/11.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataMgr = ZRAPPListDataMgr();
    var body: some View {
        NavigationView() {
            Group {
                if let errorMsg = dataMgr.errorMessage {
                    Text(errorMsg)
                } else {
                    if dataMgr.isLoading {
                        ProgressView()
                    } else {
                        ZRListView(vm: dataMgr.listData!);
                    }
                }
            }
            .navigationTitle("App")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
