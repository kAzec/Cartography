import Cartography

import Nimble
import Quick

class AlignSpec: QuickSpec {
    override func spec() {
        var window: TestWindow!
        var viewA: TestView!
        var viewB: TestView!
        var viewC: TestView!

        beforeEach {
            window = TestWindow(frame: CGRectMake(0, 0, 400, 400))

            viewA = TestView(frame: CGRectZero)
            window.addSubview(viewA)

            viewB = TestView(frame: CGRectZero)
            window.addSubview(viewB)

            viewC = TestView(frame: CGRectZero)
            window.addSubview(viewC)

            constrain(viewA) { view in
                view.height == 200
                view.width == 200

                view.top  == view.superview!.top  + 10
                view.left == view.superview!.left + 10
            }
        }

        describe("for edges(using proxies)") {
            beforeEach {
                constrain(viewA, viewB, viewC) { viewA, viewB, viewC in
                    align(.Top, of: viewA, viewB, viewC)
                    align(.Right, of: viewA, viewB, viewC)
                    align(.Bottom, of: viewA, viewB, viewC)
                    align(.Left, of: viewA, viewB, viewC)
                }
            }

            it("should align edges") {
                expect(viewA.frame).to(equal(viewB.frame))
                expect(viewA.frame).to(equal(viewB.frame))
            }

            it("should disable translating autoresizing masks into constraints") {
                expect(viewA).notTo(translateAutoresizingMasksToConstraints())
                expect(viewB).notTo(translateAutoresizingMasksToConstraints())
                expect(viewC).notTo(translateAutoresizingMasksToConstraints())
            }
        }
        
        describe("for edges(using proxies, attributes as array)") {
            beforeEach {
                constrain(viewA, viewB, viewC) { viewA, viewB, viewC in
                    align([.Top, .Right, .Bottom, .Left], of: viewA, viewB, viewC)
                }
            }
            
            it("should align edges") {
                expect(viewA.frame).to(equal(viewB.frame))
                expect(viewA.frame).to(equal(viewB.frame))
            }
            
            it("should disable translating autoresizing masks into constraints") {
                expect(viewA).notTo(translateAutoresizingMasksToConstraints())
                expect(viewB).notTo(translateAutoresizingMasksToConstraints())
                expect(viewC).notTo(translateAutoresizingMasksToConstraints())
            }
        }
        
        describe("for edges(using views)") {
            beforeEach {
                align(.Top, of: viewA, viewB, viewC)
                align(.Right, of: viewA, viewB, viewC)
                align(.Bottom, of: viewA, viewB, viewC)
                align(.Left, of: viewA, viewB, viewC)
            }
            
            it("should align edges") {
                expect(viewA.frame).to(equal(viewB.frame))
                expect(viewA.frame).to(equal(viewB.frame))
            }
            
            it("should disable translating autoresizing masks into constraints") {
                expect(viewA).notTo(translateAutoresizingMasksToConstraints())
                expect(viewB).notTo(translateAutoresizingMasksToConstraints())
                expect(viewC).notTo(translateAutoresizingMasksToConstraints())
            }
        }
        
        describe("for edges(using views, attributes as array)") {
            beforeEach {
                align([.Top, .Right, .Bottom, .Left], of: viewA, viewB, viewC)
            }
            
            it("should align edges") {
                expect(viewA.frame).to(equal(viewB.frame))
                expect(viewA.frame).to(equal(viewB.frame))
            }
            
            it("should disable translating autoresizing masks into constraints") {
                expect(viewA).notTo(translateAutoresizingMasksToConstraints())
                expect(viewB).notTo(translateAutoresizingMasksToConstraints())
                expect(viewC).notTo(translateAutoresizingMasksToConstraints())
            }
        }

        describe("for horizontal and vertical centers") {
            beforeEach {
                constrain(viewA, viewB, viewC) { viewA, viewB, viewC in
                    viewA.size == viewB.size
                    viewB.size == viewC.size

                    align(.CenterX, of: viewA, viewB, viewC)
                    align(.CenterY, of: viewA, viewB, viewC)
                }
            }

            it("should align center points") {
                expect(viewA.frame).to(equal(viewB.frame))
                expect(viewA.frame).to(equal(viewB.frame))
            }

            it("should disable translating autoresizing masks into constraints") {
                expect(viewA).notTo(translateAutoresizingMasksToConstraints())
                expect(viewB).notTo(translateAutoresizingMasksToConstraints())
                expect(viewC).notTo(translateAutoresizingMasksToConstraints())
            }
        }
    }
}
