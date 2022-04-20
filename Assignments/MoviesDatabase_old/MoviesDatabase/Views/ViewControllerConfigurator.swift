//
//  ViewControllerConfigurator.swift
//  MoviesDatabase
//
//  Created by Ethan Faggett on 4/9/22.
//

import Foundation

class ViewControllerConfigurator {
    
    static func assemblingMVVM(view: ViewControllerProtocol) {
        let networkManager = MainNetworkManager()
        let remote = RemoteRepository(networkManager: networkManager)
        let coreDataManager = CoreDataManager()
        let local = LocalRepository(coreDataManager: coreDataManager)
        let repository = Repository(remote: remote, local: local)
        let viewModel = ViewModel(repository: repository)
        view.viewModel = viewModel
    }
    
}
