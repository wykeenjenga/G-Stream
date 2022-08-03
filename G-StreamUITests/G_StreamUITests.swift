//
//  G_StreamUITests.swift
//  G-StreamUITests
//
//  Created by Wykee Njenga on 7/28/22.
//

import XCTest
import RxSwift
import RxTest

class G_StreamUITests: XCTestCase {

    func testTabBarButtons(){
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
    
        let liveEventsBtn = app.buttons["home"]
        XCTAssertTrue(liveEventsBtn.exists)
        liveEventsBtn.tap()
        
        
        let scheduledEventsBtn = app.buttons["chat"]
        XCTAssertTrue(scheduledEventsBtn.exists)
        scheduledEventsBtn.tap()
        
        
        let liveEventsTableView = app.tables
        liveEventsTableView.staticTexts["MLB Baseball"]
        XCTAssertTrue(liveEventsTableView.element.exists)
        liveEventsTableView.element.swipeUp()
        
        liveEventsBtn.tap()
        
        
        
        let tablesQuery = XCUIApplication().tables
        
        tablesQuery.staticTexts["Suns @ Mavericks"]
        XCTAssertTrue(tablesQuery.element.exists)
        tablesQuery.element.swipeUp()
        
        
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
