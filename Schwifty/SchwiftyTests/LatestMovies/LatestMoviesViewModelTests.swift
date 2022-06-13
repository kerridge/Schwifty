import XCTest
@testable import Schwifty

class LatestMoviesViewModelTests: XCTestCase {
    private func userDefaults(_ forSuiteName: String) -> UserDefaults {
        let userDefaults = UserDefaults(suiteName: #function)!
        userDefaults.removePersistentDomain(forName: #function)
        return userDefaults
    }
    
    private func getWidgetsForKeys(_ keys: [String]) -> [Widget] {
        keys.compactMap { widgetKey in
            Widget.testInstances.first(where: { widget in
                widget.rawValue == widgetKey
            })
        }
    }
    
    override func setUp() {
        super.setUp()
    }
    
    func XCTAssertWidgetCase(_ testValue: Widget, _ expectedValue: Widget) -> Bool {
        switch (testValue, expectedValue) {
        case (.trendingMovies, .trendingMovies):
            return true
        case (.latestMovies(_), .latestMovies(_)):
            return true
        default:
            return false
        }
    }

//    func testGivenWidgetStrings_whenMappingToWidgets_thenShouldMapCorrectly() throws {
//        // given widget string list
//        let selectedWidgets = [
//            "latest",
//            "trending"
//        ]
//        let vm = DashboardViewModel(widgetStore: .init(userDefaults: userDefaults(#function)))
//
//        // when mapping to widgets
//        let widgets = vm.widgets
//
//        // then should map correctly
//        XCTAssertTrue(widgets.count == 2)
//    }
//
//    func testGivenEmptyArray_whenMappingToWidgets_thenShouldBeEmpty() throws {
//        // given widget string list
//        let selectedWidgets: [String] = []
//        let vm = DashboardViewModel(widgetStore: .init(userDefaults: userDefaults(#function)))
//
//        // when mapping to widgets
//        let widgets = vm.widgets
//
//        // then should be empty
//        XCTAssertTrue(widgets.isEmpty)
//    }
//
//    func testGivenIncorrectWidgetStrings_whenMappingToWidgets_thenShouldBeEmpty() throws {
//        // given incorrect widget string list
//        let selectedWidgets = [
//            "hottest",
//            "spiciest"
//        ]
//        let vm = DashboardViewModel(widgetStore: .init(userDefaults: userDefaults(#function)))
//
//        // when mapping to widgets
//        let widgets = vm.widgets
//
//        // then should be empty
//        XCTAssertTrue(widgets.isEmpty)
//    }
//
//    func testGivenMixedWidgetStrings_whenMappingToWidgets_thenShouldContainOne() throws {
//        // given mixed widget string list
//        let selectedWidgets = [
//            "latest",
//            "spiciest"
//        ]
//        let vm = DashboardViewModel(widgetStore: .init(userDefaults: userDefaults(#function)))
//
//        // when mapping to widgets
//        let widgets = vm.widgets
//
//        // then should contain latest only
//        XCTAssertTrue(widgets.count == 1)
//        XCTAssertTrue(widgets.first?.rawValue == "latest")
//
//        guard case .latestMovies(_) = widgets.first else {
//            return XCTFail("Should have succeded here")
//        }
//    }
    
    func testGivenLatestMoviesWidget_whenReadingFromStore_thenShouldHaveDependencies() throws {
        // given latest movies widget in cache
        let selectedWidgets = getWidgetsForKeys([
            "latest"
        ])
        
        let store = OnDiskWidgetStore(userDefaults: userDefaults(#function))
        
        store.updateAvailable(Widget.testInstances)
        store.updateSelected(selectedWidgets)
        
        // when reading from store
        let vm = DashboardViewModel(widgetStore: store)
        
        // then dashboard should contain widget
        guard case let .latestMovies(latestVM) = vm.widgets.first else {
            return XCTFail("Should have succeded here")
        }
        
        XCTAssertEqual(latestVM.title, "Latest Movies")
    }
    
    func testGivenNoSelectedWidgets_whenReadingFromStore_thenDashboardShouldContainAllWidgets() throws {
        // given no selected widgets
        let store = OnDiskWidgetStore(userDefaults: userDefaults(#function))
        store.updateAvailable(Widget.testInstances)
        store.updateSelected([])
        
        // when reading from store
        let vm = DashboardViewModel(widgetStore: store)
        
        // then dashboard should contain all widgets
        XCTAssertEqual(vm.widgets.count, 2)
    }
}

private extension LatestMoviesViewModel {
    static let testInstance: LatestMoviesViewModel =
        .init(dependencies: .init(title: "Latest Movies"))
}

private extension Widget {
    // exhaustive list of available widgets
    static let testInstances: [Widget] = [
        .latestMovies(.testInstance),
        .trendingMovies
    ]
}
