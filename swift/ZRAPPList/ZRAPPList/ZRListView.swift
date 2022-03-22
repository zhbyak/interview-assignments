//
//  ZRListView.swift
//  ZRAPPList
//
//  Created by 锐 张 on 2022/3/11.
//

import SwiftUI

struct ZRListView: View {
    @StateObject var vm: ZRAPPListData
    
    init(vm:ZRAPPListData) {
        _vm = StateObject.init(wrappedValue: vm)
    }
    
    var body: some View {
        Text("count:\(vm.resultCount)")
    }
}

//struct ZRListView_Previews: PreviewProvider {
//    static var previews: some View {
//        ZRListView(vm: nil)
//    }
//}
