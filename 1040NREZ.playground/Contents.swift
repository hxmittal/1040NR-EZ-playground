//: A UIKit based Playground for presenting user interface
import UIKit
import PlaygroundSupport

let myVC = InputViewController(style: .insetGrouped)
let navigationController = UINavigationController(rootViewController: myVC)
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = navigationController
