# CoreTableView

CoreTableView module for Data-Driven-UI Architecture

## Integration

### if as local package
```swift
    dependencies: [
        .package(path: "../CoreTableView")
    ],
```

### if as shared package
```swift
    dependencies: [
        .package(name: "CoreTableView", url: "https://github.com/MosMetro-official/CoreTableView.git", from: "0.0.1")
    ],
```

## Structure

The Package is a wrapper for BEST UITableView perfomance, that is includes DifferenceKit lib inside. Available for iOS 11+.

## Usage

First of all, you need to set BaseTableView - main actor for the lib. You can host it in Xib / Storyboard file or natively by code.

```swift

IBOutlet weak private var tableView : BaseTableView!

======OR======

private lazy var tableView : BaseTableView = {
    var tableView : BaseTableView!
    if #available(iOS 13.0, *) {
        tableView = BaseTableView(frame: .zero, style: .insetGrouped)
    } else {
        tableView = BaseTableView(frame: .zero, style: .grouped)
    }
    tableView.separatorColor = .clear
    tableView.showsVerticalScrollIndicator = false
    tableView.showsHorizontalScrollIndicator = false
    return tableView
}()

```

Anyway, this tableView wrapper created for convenient table management in Data-Driven-UI Architecture. So this Arch is built on States, that you schould strictly type. So. your view will be setted like:

```swift

final class MyView : UIView {
    
    IBOutlet weak private var tableView: BaseTableView!
    
    struct ViewState {
    
        struct Loading : _Loading {
            let title : String
            let descr : scting
        }
    
        struct ErrorData : _ErrorData {
            let title : String
            let descr : String
            let onRetry : (() -> Void)?
        }
    
        struct Header : _TitleHeader {
            let title : String
            let style : TitleHeaderView.Style
            let height : CGFloat
            let isInsetGrouped : Bool
            let backgroundColor : UIColor
        }
    
        struct Row : _StandartImage {
            let icon : UIImage?
            let title : String
            let onSelect : (() -> Void)
        }
        
        struct Footer : _BaseFooter {
            var text : String
            var isInsetGrouped : Bool
        }
    }
    
    public var viewState: ViewState = ViewState(state: []) {
        didSet {
            DispatchQueue.main.async {
                self.tableView.viewStateInput = self.viewState.state
            }
        }
    }
}
```

In this case you should STRICTLY describe all possible screen states with a table, accordingly, if the screen has several states (for example, working, error and loading), then at least 3 cells should be created in the table (actually, working, with error and with loading).
Updating your UI we offer from controller, that is preparing states for us. For example, making loading state:

```swift

    let nestedView = MyView.loadFromNib()
    
    override func loadView() {
        self.view = self.nestedView
    }

    private func makeLoadingRow() -> Element {
        
    }
    
    private func makeState() {
        let stateModel = SectionState()
        let blockModel = State(model: stateModel, elements: [
            self.makeLoadingRow()
        ])
        
        self.nestedView.viewState.state = []
    }
```
