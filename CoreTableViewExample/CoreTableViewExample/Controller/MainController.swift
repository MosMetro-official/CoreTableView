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
    
    var textModel: String? = nil {
        didSet {
            makeState()
        }
    }
    
    var textModel2: String? = nil {
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
            id: "added\(Int.random(in: 0...10))",
            title: "Here is added rows",
            leftImage: UIImage.init(systemName: "questionmark.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected added row of third section") }
        ).toElement()
//        let addedSectionHeader = MainView.ViewState.Header(
//            title: "added section",
//            style: .small,
//            backgroundColor: .clear,
//            isInsetGrouped: true,
//            height: 44
//        )
        //let addedSection = SectionState(header: addedSectionHeader, footer: nil)
        //let addedBlock = State(model: addedSection, elements:  [addedRow])
        
        self.nestedView.viewState.state[0].elements.append(addedRow)
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
            id: "1",
            title: "First row of first section",
            leftImage: UIImage(systemName: "bag"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected first row of first section") }
        ).toElement()
        
      
        let secondRowOfFirstSection = MainView.ViewState.Row(
            id: "2",
            title: "Second row of first section",
            leftImage: UIImage(systemName: "creditcard"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected second row of first section") }
        ).toElement()
        
        let thirdRowOfFirstSection = MainView.ViewState.Row(
            id: "3",
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
            id: "1",
            title: "Header",
            style: .large,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )
        
        // declare section data with header and footer
        let firstSection = SectionState(id: "1", header: firstSectionHeader, footer: nil)
        
        // create block with section data and elements
        let firstBlock = State(model: firstSection, elements: [firstRowOfFirstSection,secondRowOfFirstSection,thirdRowOfFirstSection])

        let firstRowOfSecondSection = MainView.ViewState.Row(
            id: "1",
            title: "First row of second section",
            leftImage: UIImage(systemName: "heart.text.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: .disclosureIndicator,
            onSelect: { print("selected row 1 of section 2") }
        ).toElement()
        
        let secondRowOfSecondSection = MainView.ViewState.Row(
            id: "2",
            title: "First row of second section",
            leftImage: UIImage(systemName: "bolt.heart"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: .detailDisclosureButton,
            onSelect: { print("selected row 2 of section 2") }
        ).toElement()
        
        let secondSectionHeader = MainView.ViewState.Header(
            id: "2",
            title: "Section 2",
            style: .medium,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )
        
        let secondSection = SectionState(id: "2", header: secondSectionHeader, footer: nil)
        let secondBlock = State(model: secondSection, elements: [firstRowOfSecondSection,secondRowOfSecondSection])
        
        let firstRowOfThirdSection = MainView.ViewState.Row(
            id: "1",
            title: "First row of third section",
            leftImage: UIImage.init(systemName: "questionmark.square"),
            separator: true,
            backgroundColor: .clear,
            tintColor: .blue,
            accesoryType: nil,
            onSelect: { print("selected first row of third section") }
        ).toElement()
        
                
        let thirdSectionHeader = MainView.ViewState.Header(
            id: "3",
            title: "third section",
            style: .small,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )

        let thirdSection = SectionState(id: "3", header: thirdSectionHeader, footer: nil)
        let thirdBlock = State(model: thirdSection, elements: [firstRowOfThirdSection])
        
        let onTextEnter: Command<String> = Command { text in
            self.textModel = text
        }
        
        let onTextEnter2: Command<String> = Command { text in
            self.textModel2 = text
        }
        
        let text = MainView.ViewState.Text(text: textModel, placeholder: "Enter text here!", onTextEnter: onTextEnter, id: "1").toElement()
        let text2 = MainView.ViewState.Text(text: textModel2, placeholder: "Enter text here!", onTextEnter: onTextEnter2, id: "2").toElement()
        
        let fourthSectionHeader = MainView.ViewState.Header(
            id: "4",
            title: "fourth section",
            style: .small,
            backgroundColor: .clear,
            isInsetGrouped: true,
            height: 44
        )

        let fourthSection = SectionState(id: "4", header: fourthSectionHeader, footer: nil)
        let fourthBlock = State(model: fourthSection, elements: [text,firstRowOfFirstSection,secondRowOfFirstSection,thirdRowOfFirstSection,text2])
        
        
        self.nestedView.viewState.state = [firstBlock,secondBlock,thirdBlock, fourthBlock]
    }
}
