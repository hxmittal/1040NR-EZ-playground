import Foundation

public class FormValue: NSObject {
    public var title = String()
    public var value = String()
    
    public init(title:String) {
        self.title = title
        super.init()
    }
    
    public override var description: String {
        return "(\(title), \(value))"
    }
    
}
