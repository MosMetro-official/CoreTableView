//
//  ViewController.swift
//  BaseTableViewKit
//
//  Created by viacheslavplatonov on 02/08/2022.
//  Copyright (c) 2022 viacheslavplatonov. All rights reserved.
//

import UIKit
import CoreTableView

class MainController : UIViewController {

    private let nestedView = MainView(frame: UIScreen.main.bounds)
    
    var counter = 0 {
        didSet {
            makeState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view = nestedView
        makeState()
        navigationItem.rightBarButtonItems  = [UIBarButtonItem(barButtonSystemItem: .redo, target: self, action: #selector(handleRemove)), UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))]
    }
    
    @objc private func handleAdd() {
        let addedRow = MainView.ViewState.Row(
            title: "Here is added rows",
            leftImage: UIImage.init(systemName: "questionmark.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected added row of third section") }
        ).toElement()
        let addedSectionHeader = MainView.ViewState.Header(
            title: "added section",
            style: .small,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )
        let addedSection = SectionState(header: addedSectionHeader, footer: nil)
        let addedBlock = State(model: addedSection, elements:  [addedRow])
        
        self.nestedView.viewState.state.append(addedBlock)
    }
    
    @objc
    private func handleRemove() {
        if !self.nestedView.viewState.state.isEmpty {
            self.nestedView.viewState.state.removeLast()
        }
    }

    private func makeState() {
        
        // declare rows
        let firstRowOfFirstSection = MainView.ViewState.Row(
            title: "First row of first section",
            leftImage: UIImage(systemName: "bag"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected first row of first section") }
        ).toElement()
        
      
        let secondRowOfFirstSection = MainView.ViewState.Row(
            title: "Second row of first section",
            leftImage: UIImage(systemName: "creditcard"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected second row of first section") }
        ).toElement()
        
        let thirdRowOfFirstSection = MainView.ViewState.Row(
            title: "Third row of first section",
            leftImage: UIImage(systemName: "banknote"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected third row of first section") }
        ).toElement()
        
   
        // declare header if needed
        let firstSectionHeader = MainView.ViewState.Header(
            title: "Header",
            style: .large,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )
        
        // declare section data with header and footer
        let firstSection = SectionState(header: firstSectionHeader, footer: nil)
        
        // create block with section data and elements
        let firstBlock = State(model: firstSection, elements: [firstRowOfFirstSection,secondRowOfFirstSection,thirdRowOfFirstSection])

        let firstRowOfSecondSection = MainView.ViewState.Row(
            title: "First row of second section",
            leftImage: UIImage(systemName: "heart.text.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: .disclosureIndicator,
            onSelect: { print("selected row 1 of section 2") }
        ).toElement()
        
        let secondRowOfSecondSection = MainView.ViewState.Row(
            title: "First row of second section",
            leftImage: UIImage(systemName: "bolt.heart"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: .detailDisclosureButton,
            onSelect: { print("selected row 2 of section 2") }
        ).toElement()
        
        let secondSectionHeader = MainView.ViewState.Header(
            title: "Section 2",
            style: .medium,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )
        
        let secondSection = SectionState(header: secondSectionHeader, footer: nil)
        let secondBlock = State(model: secondSection, elements: [firstRowOfSecondSection,secondRowOfSecondSection])
        
        let firstRowOfThirdSection = MainView.ViewState.Row(
            title: "First row of third section",
            leftImage: UIImage.init(systemName: "questionmark.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected first row of third section") }
        ).toElement()
        
                
        let thirdSectionHeader = MainView.ViewState.Header(
            title: "third section",
            style: .small,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )

        let thirdSection = SectionState(header: thirdSectionHeader, footer: nil)
        let thirdBlock = State(model: thirdSection, elements: [firstRowOfThirdSection])
        
        self.nestedView.viewState.state = [firstBlock,secondBlock,thirdBlock]
    }
}
