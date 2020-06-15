import Foundation
import UIKit

public class InputViewController : UITableViewController {
    
    var inputs = [FormValue]()
        
    public override func viewDidLoad() {
        self.title = "1040-NR-EZ"
        
        self.inputs = [FormValue(title: "First and Middle Name"),
                       FormValue(title: "Last Name"),
                       FormValue(title: "SSN"),
                       FormValue(title: "Present Address"),
                       FormValue(title: "City/State/Zip Code"),
                       FormValue(title: "Married"),
                       FormValue(title: "Wages(Item number 1 on W2)"),
                       FormValue(title: "Taxable Refunds(If any)"),
                       FormValue(title: "Scholarships(if any)"),
                       FormValue(title: "Federal Income tax Withheld (Item number 2 on W2"),
                       FormValue(title: "Routing Number"),
                       FormValue(title: "Account Number"),
                       FormValue(title: "Nationality"),
                       FormValue(title: "Ever applied for a green card?"),
                       FormValue(title: "Ever been a US citizen?"),
                       FormValue(title: "Green card holder?"),
                       FormValue(title: "Visa Type"),
                       FormValue(title: "Ever changed visa type?"),
                       FormValue(title: "If yes, date and nature of change"),
                       FormValue(title: "Did you file tax last year?"),
                       FormValue(title: "If yes, give year and form number"),
                       FormValue(title: "Subject to tax in foreign country?"),
                       FormValue(title: "Claiming Treaty benefits?")]
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.nextButtonTapped(button:)))
    }
 
    public override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.inputs.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        var cell: UITableViewCell
//        5,13,14,15,17,19,21,22
        if row != 5 && row != 13 && row != 14 && row != 15 && row != 17 && row != 19 && row != 21 && row != 22
        {
            cell = TextFieldCell(style: .default, reuseIdentifier: nil, formValue: self.inputs[indexPath.row])
        } else {
            cell = SwitchCell(style: .default, reuseIdentifier: nil, formValue: self.inputs[indexPath.row])
        }
        return cell
    }
    
    @objc func nextButtonTapped(button: UIButton) -> Void {
        self.view.endEditing(true)
        var input_text : [String?] = []
        for formValue in self.inputs {
            input_text.append(formValue.value)
        }
        
        let pdfViewController = PDFViewController()
        pdfViewController.input_text = input_text
        self.navigationController?.pushViewController(pdfViewController, animated: true)
            
        }
} //Class InputViewController
