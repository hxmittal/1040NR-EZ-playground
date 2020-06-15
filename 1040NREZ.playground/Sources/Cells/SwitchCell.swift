import Foundation
import UIKit

public class SwitchCell : UITableViewCell {

    public var switchControl = UISwitch()
    public var formValue = FormValue(title: "")
    public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, formValue: FormValue) {
        self.formValue = formValue
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.text = self.formValue.title
        self.accessoryView = self.switchControl
        self.switchControl.isOn = false;
        self.switchControl.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @objc func switchChanged(mySwitch: UISwitch) {
        // Do something
        if mySwitch.isOn {
            self.formValue.value = "Y"
        } else {
            self.formValue.value = "N"
        }
    }
}
