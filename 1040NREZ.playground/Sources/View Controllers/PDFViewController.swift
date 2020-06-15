import Foundation
import UIKit
import PDFKit

public class PDFViewController: UIViewController {
    public var input_text : [String?] = []
    
    var firstName: String!
    var lastName: String!
    var presentAddress: String!
    var CityTown: String!
    var SSN: String!
    var Married: String! = "N"
    var RoutingNumber: String!
    var AccountNumber: String!
    var Nationality: String!
    var GreenCardApply: String! = "N"
    var USCitizenHistory: String! = "N"
    var GreenCardStatus: String! = "N"
    var VisaTypeChange: String! = "N"
    var DateOfVisaTypeChange: String!
    var LastYearTaxStatus: String! = "N"
    var VisaType: String!
    var LastYearFormNumber: String!
    var SubjectToTaxInForeignCountry: String! = "N"
    var ClaimingTreatyBenefits: String! = "N"
    var Wages : String! = "0"
    var TaxableRefunds : String! = "0"
    var Scholarships : String! = "0"
    var FederalTaxWithheld : String! = "0"
    var ItemizedDeductions : String! = "12200"
    var pdfView: PDFView!
    
    func initializeVariables() {
        
        
        firstName = input_text[0]
        lastName = input_text[1]
        SSN = input_text[2]
        presentAddress = input_text[3]
        CityTown = input_text[4]
        Married = input_text[5]
        if input_text[6] != ""{
            Wages = input_text[6]
        }
        if input_text[7] != ""{
            TaxableRefunds = input_text[7]
        }
        if input_text[8] != ""{
            Scholarships = input_text[8]
        }
        if input_text[9] != ""{
        FederalTaxWithheld = input_text[9]
        }
        RoutingNumber = input_text[10]
        AccountNumber = input_text[11]
        Nationality = input_text[12]
        GreenCardApply = input_text[13]
        USCitizenHistory = input_text[14]
        GreenCardStatus = input_text[15]
        VisaTypeChange = input_text[17]
        DateOfVisaTypeChange = input_text[18]
        VisaType = input_text[16]
        LastYearTaxStatus = input_text[19]
        LastYearFormNumber = input_text[20]
        SubjectToTaxInForeignCountry = input_text[21]
        ClaimingTreatyBenefits = input_text[22]
    }
    
    public override func viewDidLoad() {
            super.viewDidLoad()
            
            let pdfView = PDFView(frame:self.view.bounds)
            
            initializeVariables()
            
            guard let path = Bundle.main.url(forResource: "1040NREZ", withExtension: "pdf") else { return }
        
            if let document = PDFDocument(url: path) {
                pdfView.autoresizesSubviews = true
                pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight, .flexibleTopMargin, .flexibleLeftMargin]
                pdfView.displayDirection = .vertical

                pdfView.autoScales = true
                pdfView.displayMode = .singlePageContinuous
                pdfView.displaysPageBreaks = true
                pdfView.document = document

                pdfView.maxScaleFactor = 4.0
                pdfView.minScaleFactor = pdfView.scaleFactorForSizeToFit
            }
        
        
            guard let page1 = pdfView.document?.page(at:0) else {return}
            annotatePage1(page: page1)
        
            guard let page2 = pdfView.document?.page(at:1) else {return}
            annotatePage2(page: page2)
            
            view.addSubview(pdfView)
            
            pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            
        }
    
    
    func annotatePage1(page: PDFPage) {
        
        var counter = 0
        var count_check_box = 0
        var tax = 0.0
        
        
        for annotation in page.annotations {
            annotation.isReadOnly = false
            
            if annotation.widgetFieldType == .button {
                if count_check_box == 0 && (Married == "N" || Married == ""){
                    annotation.buttonWidgetState = .onState
                }
                else if count_check_box == 1 && Married == "Y"{
                    annotation.buttonWidgetState = .onState
                }
                else if count_check_box == 5{
                    annotation.buttonWidgetState = .onState
                }
                count_check_box += 1
            }
            else if annotation.widgetFieldType == .text {
                if counter == 0{
                    annotation.widgetStringValue = firstName
                }
                else if (counter == 1){
                    annotation.widgetStringValue = lastName
                }
                else if (counter == 2){
                    annotation.widgetStringValue = SSN
                }
                else if (counter == 3){
                    annotation.widgetStringValue = presentAddress
                }
                else if (counter == 4){
                    annotation.widgetStringValue = CityTown
                }
                else if (counter == 8){
                    annotation.widgetStringValue = Wages
                }
                else if (counter == 9){
                    annotation.widgetStringValue = TaxableRefunds
                }
                else if (counter == 10){
                    annotation.widgetStringValue = Scholarships
                }
                else if (counter == 11 || counter == 15){
                    let int_wages = Int(Wages)!
                    let int_taxrefunds = Int(TaxableRefunds)!
                    let int_scholarships = Int(Scholarships)!
                    let total = int_wages + int_taxrefunds + int_scholarships
                    annotation.widgetStringValue = String(total)
                }
                else if (counter == 16){
                    annotation.widgetStringValue = ItemizedDeductions
                }
                else if(counter == 19){
                    let int_wages = Int(Wages)!
                    let int_taxrefunds = Int(TaxableRefunds)!
                    let int_scholarships = Int(Scholarships)!
                    let total = int_wages + int_taxrefunds + int_scholarships
                    let int_Itemized = Int(ItemizedDeductions)!
                    var final = 0
                    if total > int_Itemized{
                        final = total - int_Itemized
                        if final <= 9700{
                            tax = Double(final) * 0.1
                        }
                        else if final <= 39475{
                            tax = Double(final) * 0.12
                        }
                        else if final <= 84200{
                            tax = Double(final) * 0.22
                        }
                        else if final <= 160725{
                            tax = Double(final) * 0.24
                        }
                        else if final <= 204100{
                            tax = Double(final) * 0.32
                        }
                        else if final <= 510300{
                            tax = Double(final) * 0.35
                        }
                        else if final > 510300{
                            tax = Double(final) * 0.37
                        }
                    }
                    let final_str = String(final)
                    annotation.widgetStringValue = String(final_str)
                }
                else if (counter == 23 || counter == 27){
                    annotation.widgetStringValue = FederalTaxWithheld
                }
                else if (counter == 20 || counter == 22){
                    let tax_str : String = String(format:"%.1f", tax)
                    annotation.widgetStringValue = tax_str
                                    
                }
                else if (counter == 28 || counter == 29){
                    let payment_int = Int(FederalTaxWithheld)!
                    let payments = Double(payment_int)
                    var refunds = 0.0
                    if payments > tax{
                        refunds = payments - tax
                    }
                    let refunds_str : String = String(format:"%.1f", refunds)
                    annotation.widgetStringValue =  refunds_str
                    
                }
                else if (counter == 30){
                    annotation.widgetStringValue = RoutingNumber
                }
                else if (counter == 31){
                    annotation.widgetStringValue = AccountNumber
                }
                else if (counter == 13 || counter == 14 || counter == 24 || counter == 25 ){
                    annotation.widgetStringValue = "0"
                }
                else if counter == 35{
                    let payment_int = Int(FederalTaxWithheld)!
                    let payments = Double(payment_int)
                    var refunds = 0.0
                    if payments > tax{
                        annotation.widgetStringValue = "0"
                    }
                    else{
                        refunds = tax - payments
                        let refunds_str : String = String(format:"%.1f", refunds)
                        annotation.widgetStringValue =  refunds_str
                    }
                }
                counter = counter + 1
            }
        }
    }
    
    func annotatePage2 (page: PDFPage) {
        
        var counter = 0
        var count_check_box1 = 0
        for annotation in page.annotations {
            if annotation.widgetFieldType == .text{
                if counter == 0 || counter == 1{
                    annotation.widgetStringValue = Nationality
                }
                else if counter == 2{
                    annotation.widgetStringValue = VisaType
                }
                else if counter == 3{
                    annotation.widgetStringValue = DateOfVisaTypeChange
                }else if counter == 23{
                    annotation.widgetStringValue = LastYearFormNumber
                }
                counter += 1
            }
            else if(annotation.widgetFieldType == .button){
                if (count_check_box1 == 0){
                    if GreenCardApply == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 1){
                    if GreenCardApply == "N" || GreenCardApply == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 2){
                    if USCitizenHistory == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 3){
                    if USCitizenHistory == "N" || USCitizenHistory == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 4){
                    if GreenCardStatus == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 5){
                    if GreenCardStatus == "N" || GreenCardStatus == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 6){
                    if VisaTypeChange == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 7){
                    if VisaTypeChange == "N" || VisaTypeChange == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 10){
                    if LastYearTaxStatus == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 11){
                    if LastYearTaxStatus == "N" || LastYearTaxStatus == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 12){
                    if SubjectToTaxInForeignCountry == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 13){
                    if SubjectToTaxInForeignCountry == "N" || SubjectToTaxInForeignCountry == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 14){
                    if ClaimingTreatyBenefits == "Y"{
                        annotation.buttonWidgetState = .onState
                    }
                }
                else if (count_check_box1 == 15){
                    if ClaimingTreatyBenefits == "N" || ClaimingTreatyBenefits == ""{
                        annotation.buttonWidgetState = .onState
                    }
                }
                count_check_box1 += 1
            }
        }
    }
    
} // PDFController
