//
//  ZRAPPListDataMgr.swift
//  ZRAPPList
//
//  Created by 锐 张 on 2022/3/11.
//

import Foundation
import Combine
import CleanJSON
import SwiftUI

enum FetchListError: Error, CustomStringConvertible {
    case fileNotExist
    case fileReadError(error: Error)
    case decodeError(error: Error)
    case unknown

    var description: String {
        switch self {
        case .fileNotExist:
            return "File not Exist!"
        case .fileReadError(let error):
            return "File read error: \(error.localizedDescription)"
        case .decodeError(let error):
            return "File decode error: \(error.localizedDescription)"
        case .unknown:
            return "[Error unknown]"
        }
    }
}

class ZRAPPListDataMgr: ObservableObject {
    
    @Published var isLoading: Bool = true
    @Published var errorMessage: String?
    @Published var listData: ZRAPPListData?
    
    var cancellables = Set<AnyCancellable>()

    init(sb:String = "1") {
        fetchData()
            .delay(for: .seconds(1), scheduler: DispatchQueue.global())
            .receive(on: RunLoop.main)
            .handleEvents(
                receiveOutput: { [weak self] _ in
                    self?.isLoading = false
                })
            .sink(
                receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        self?.isLoading = false
                        break
                    case .failure(let error):
                        print("[Error]: \(error)")
                        self?.errorMessage = error.description
                        break
                    }
                }, receiveValue: { [weak self] value in
                    self?.listData = value
                }
            )
            .store(in: &cancellables)
    }
}

extension ZRAPPListDataMgr {
    
    private func fetchData() -> AnyPublisher<ZRAPPListData, FetchListError> {
        return readJSONFile()
    }
    
    private func readJSONFile() -> AnyPublisher<ZRAPPListData, FetchListError> {
        return Future<ZRAPPListData, FetchListError> { promise in
            if let url = Bundle.main.url(forResource: "data", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    do {
                        let listData = try CleanJSONDecoder().decode(ZRAPPListData.self, from: data)
                        promise(.success(listData))
                    } catch {
                        promise(.failure(FetchListError.decodeError(error: error)))
                    }
                } catch {
                    promise(.failure(FetchListError.fileReadError(error: error)))
                }
            } else {
                promise(.failure(FetchListError.fileNotExist))
            }
        }.eraseToAnyPublisher()
    }
    
}
