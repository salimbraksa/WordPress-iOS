import XCTest

extension XCUIElement {
    /**
     Removes any current text in the field
     */
    func clearTextIfNeeded() -> Void {
        let app = XCUIApplication()
        let content = self.value as! String

        if content.count > 0 && content != self.placeholderValue {
            self.press(forDuration: 1.2)
            app.menuItems["Select All"].tap()
            app.menuItems["Cut"].tap()
        }
    }

    /**
     Removes any current text in the field before typing in the new value
     - Parameter text: the text to enter into the field
     */
    func clearAndEnterText(text: String) -> Void {
        clearTextIfNeeded()
        self.tap()
        self.typeText(text)
    }
}

extension XCTest {

    func isIPhone() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
}

func isIpad() -> Bool {
    return UIDevice.current.userInterfaceIdiom == .pad
}
