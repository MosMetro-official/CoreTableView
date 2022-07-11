//
//  File.swift
//  
//
//  Created by guseyn on 11.07.2022.
//

import Foundation
import UIKit


public class BaseCollectionView: UICollectionView {
    
    /// original data source
    private var viewState = [CollectionState]()
    
    public var shouldUseReload = false
    
    /// public data source. Affects original, used only for diff calculattions
    public var viewStateInput: [CollectionState] {
        get {
            return viewState
        }
        set {
            let changeset = StagedChangeset(source: viewState, target: newValue)
            
            self.reload(using: changeset) { [weak self] change in
                guard let self = self else { return false }
                return self.shouldUseReload
            } setData: { newState in
                self.viewState = newState
            }
            
        }
    }
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

extension BaseCollectionView: UICollectionViewDataSource {
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewState.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewState[section].elements.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content else { return .init() }
        return element.cell(for: collectionView, cellForItemAt: indexPath)
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content else { return  }
        element.willDisplay(cell: cell, for: collectionView, indexPath: indexPath)
    }
    
    
    
    
}

extension BaseCollectionView: UICollectionViewDelegate {
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content else { return  }
        element.onItemSelect.perform(with: ())
    }
    
}

extension BaseCollectionView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let element = self.viewState[safe: indexPath.section]?.elements[safe: indexPath.row]?.content else { return .zero }
        return element.size
    }
}
