import XCTest
@testable import Schwifty

class LatestMoviesViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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

    func testGivenWidgetStrings_whenMappingToWidgets_thenShouldMapCorrectly() throws {
        // given widget string list
        let selectedWidgets = [
            "latest",
            "trending"
        ]
        let vm = DashboardViewModel()
        
        // when mapping to widgets
        let widgets = vm.mapToWidgetList(selectedWidgets)
        
        // then should map correctly
        XCTAssertTrue(widgets.count == 2)
    }
    
    func testGivenEmptyArray_whenMappingToWidgets_thenShouldBeEmpty() throws {
        // given widget string list
        let selectedWidgets: [String] = []
        let vm = DashboardViewModel()
        
        // when mapping to widgets
        let widgets = vm.mapToWidgetList(selectedWidgets)
        
        // then should be empty
        XCTAssertTrue(widgets.isEmpty)
    }
    
    func testGivenIncorrectWidgetStrings_whenMappingToWidgets_thenShouldBeEmpty() throws {
        // given incorrect widget string list
        let selectedWidgets = [
            "hottest",
            "spiciest"
        ]
        let vm = DashboardViewModel()
        
        // when mapping to widgets
        let widgets = vm.mapToWidgetList(selectedWidgets)
        
        // then should be empty
        XCTAssertTrue(widgets.isEmpty)
    }
    
    func testGivenMixedWidgetStrings_whenMappingToWidgets_thenShouldContainOne() throws {
        // given widget string list
        let selectedWidgets = [
            "latest",
            "spiciest"
        ]
        let vm = DashboardViewModel()
        
        // when mapping to widgets
        let widgets = vm.mapToWidgetList(selectedWidgets)
        
        // then should be empty
        XCTAssertTrue(widgets.count == 1)
    }
}
