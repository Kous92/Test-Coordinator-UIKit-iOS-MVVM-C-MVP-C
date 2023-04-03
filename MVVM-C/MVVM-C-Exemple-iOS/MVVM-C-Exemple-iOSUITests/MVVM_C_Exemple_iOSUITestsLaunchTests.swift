//
//  MVVM_C_Exemple_iOSUITestsLaunchTests.swift
//  MVVM-C-Exemple-iOSUITests
//
//  Created by Koussaïla Ben Mamar on 03/04/2023.
//

import XCTest

final class MVVM_C_Exemple_iOSUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
