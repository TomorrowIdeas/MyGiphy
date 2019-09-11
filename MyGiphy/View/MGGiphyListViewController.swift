//
//  MGGiphyListViewController.swift
//  MyGiphy
//
//  Created by Benji Dodgson on 8/16/19.
//  Copyright © 2019 Tomorrow Ideas. All rights reserved.
//

import UIKit
import GiphyUISDK
import GiphyCoreSDK

class MGGiphyListViewController: UIViewController, MGStoryboarded {
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var coordinator: MainCoordinator?
    
    var viewModels: [MGGiphyCollectionViewCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.collectionView.reloadData()
            }
        }
    }
    
    lazy var giphyService: MGGiphySerialization = {
        return MGGiphySerialization()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GiphyCore.configure(apiKey: "GPAA4CpNkEmIakNtPMQAVVUwmEHv7gyT")
        fetchGiphys()
        
        initialize()
    }
    
    private func fetchGiphys() {
        giphyService.searchForGiphy { vms in
            self.viewModels = vms
        }
    }
    
    private func initialize() {
        title = "Weekly Forecast"

        collectionView.register(MGGiphyCollectionViewCell.self, forCellWithReuseIdentifier: MGGiphyCollectionViewCell.reuseIdentifier)

    }
}

extension MGGiphyListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vm = viewModels[indexPath.row]
        coordinator?.showDetailsOfGif(vm: vm)
    }
}

extension MGGiphyListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MGGiphyCollectionViewCell.reuseIdentifier, for: indexPath) as! MGGiphyCollectionViewCell
        
        cell.viewModel = viewModels[indexPath.row]
        return cell
    }
}

extension MGGiphyListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 100, height: 100)
    }
}
