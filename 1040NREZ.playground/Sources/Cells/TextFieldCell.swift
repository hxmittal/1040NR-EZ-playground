import Foundation
import UIKit

public class TextFieldCell : UITableViewCell {
    
    public var textField = UITextField()
    public var formValue = FormValue(title: "")
    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, formValue: FormValue) {
        textField = UITextField(frame: CGRect(x: 20, y: 0, width: 300, height: 44))
        self.formValue = formValue
        textField.placeholder = self.formValue.title
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.delegate = self
        self.contentView .addSubview(textField)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

extension TextFieldCell : UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.formValue.value = textField.text!
    }
}
