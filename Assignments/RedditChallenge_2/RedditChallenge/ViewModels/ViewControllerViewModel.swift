//
//  ViewControllerViewModel.swift
//  RedditChallenge
//
//  Created by Christian Quicano on 3/31/22.
//

import Foundation
import Combine
import UIKit

protocol ViewControllerViewModelProtocol {
    var totalRows: Int { get }
    var publisherStories: Published<[Story]>.Publisher { get }
    var publisherCache: Published<[Int: Data]>.Publisher { get }
    func getStories()
    func getTitle(by row: Int) -> String?
    func loadMoreStories()
    func forceUpdate()
    func getImageData(by row: Int) -> Data?
    func deleteCell(by row: Int)
    func refreshTable()
    
}

class ViewControllerViewModel: ViewControllerViewModelProtocol, MyViewControllerDelegate {
    func refreshTableView() {
        
    }
    
    let viewController = ViewController()
    
    func refreshTable() {
        DispatchQueue.main.async {
            self.viewController.tableView.reloadData()
        }
    }
    
    func deleteCell(by row: Int) {
        
        let cache2 = cache
        
        viewController.delegate = self
        var imgArrayNum = [Int]()
        for (key, _) in cache2 {
            imgArrayNum.append(key)
        }
        
        if imgArrayNum.contains(row) {
            cache.removeValue(forKey: row)
            stories.remove(at: row)
            
            for (key, value) in cache {
                if key >= row {
                    
                    let num = key - 1
                    cache[num] = value
                }
            }
            
            print("cache_after removal: \(cache)")
            
            DispatchQueue.main.async {
                self.viewController.delegate?.refreshTableView()
                print("delegate...")
            }
            
        } else if !imgArrayNum.contains(row) {
            //   cache = [:]
            print("NOT...")
            for (key, value) in cache {
                if key >= row {
                    
                    let num = key - 1
                    cache[num] = value
                }
            }
            stories.remove(at: row)
        }
        
        print("Image Num Array: \(imgArrayNum)")
        
        print("cache: \(cache)")
        
    }
 
    
    var totalRows: Int { stories.count }
    var publisherStories: Published<[Story]>.Publisher { $stories }
    var publisherCache: Published<[Int: Data]>.Publisher { $cache }
    
    private let networkManager: NetworkManager
    private var subscribers = Set<AnyCancellable>()
    @Published private(set) var stories = [Story]()
    private var afterKey = ""
    private var isLoading = false
    @Published private var cache: [Int: Data] = [:]
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getStories() {
        getStories(from: NetworkURLs.urlBase)
    }
    
    func loadMoreStories() {
        let newURL = "\(NetworkURLs.urlBase)?after=\(afterKey)"
        getStories(from: newURL)
    }
    
    func forceUpdate() {
        stories = []
        cache = [:]
        getStories(from: NetworkURLs.urlBase, forceUpdate: true)
    }
    
    private func getStories(from url: String, forceUpdate: Bool = false) {
        guard !isLoading else { return }
        isLoading = true
        print("loadMoreStories")
        networkManager
            .getModel(RedditResponse.self, from: url)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] response in
                let temp = response.data.children.map { $0.data }
                if forceUpdate {
                    self?.stories = temp
                } else {
                    self?.stories.append(contentsOf: temp)
                }
                self?.downloadImages()
                self?.afterKey = response.data.after
                self?.isLoading = false
            }
            .store(in: &subscribers)
    }
    
    private func downloadImages() {
        var temp = [Int: Data]()
        let group = DispatchGroup()
        for (index, story) in stories.enumerated() {
            if let thumbnail = story.thumbnail {
                group.enter()
                networkManager.getData(from: thumbnail) { data in
                    if let data = data {
                        temp[index] = data
                    }
                    group.leave()
                }
            }
        }
        group.notify(queue: .main) { [weak self] in
            self?.cache = temp
            print("Cache: \(self!.cache)")
        }
    }
    
    func getImageData(by row: Int) -> Data? {
        return cache[row]
    }
    
    func getTitle(by row: Int) -> String? {
        guard row < stories.count else { return nil }
        let story = stories[row]
        return story.title
    }
    
//    func get
    
}
