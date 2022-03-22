//
//  ZRAPPListViewModel.swift
//  ZRAPPList
//
//  Created by 锐 张 on 2022/3/11.
//

import Foundation
import Combine
import SwiftUI

class ZRAPPListItem: ObservableObject {
    var trackId: Int = 0
    var artworkUrl60: String = ""
    var trackName: String = ""
    var description: String = ""
    var like: Bool = false
}

class ZRAPPListData: ObservableObject {
    var resultCount: Int = 0
    var results: [ZRAPPListItem] = []
}

class ZRAPPListViewModel: ObservableObject {
    
//    let maxRow: Int = 10
//
//    var loadMoreSubject = CurrentValueSubject<Void, FetchListError>(())
//    var refreshSubject = PassthroughSubject<Void, Never>()
//    var updateLikeSubject = PassthroughSubject<(Int, Bool), Never>()
//    var cancellables = Set<AnyCancellable>()
//
//    var dataService: ApiProtocol
//
//    init() {
//    }
//
//    // MARK: - 是否需要加载更多List内容
//    func isLoadMore(cell: ListCell) {
//        if let last = datas.last {
//            if cell.trackId == last.trackId {
//                loadMoreSubject.send()
//            }
//        }
//    }
    
}
