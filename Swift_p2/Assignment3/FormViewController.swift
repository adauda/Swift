import UIKit

class FormViewController: UITableViewController,UITextFieldDelegate {
    
    
    private let formModel = FormModel()
    private var viewModel: ValidateField =  ValidateField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField.delegate = self
        phoneTextField.delegate = self
        passwordTextField.delegate = self
        
        signUPButton.isEnabled = false
        imageLabel.isHidden = true
        
        let tapG = UITapGestureRecognizer(target: self, action: #selector(tappedBack))
        view.addGestureRecognizer(tapG)
    }
    
    
    @objc func tappedBack(){  view.endEditing(true)  }
    
    
    @IBOutlet weak var imageLabel: UIImageView!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var textViewField: UITextView!
    
    @IBOutlet weak var nameErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var passwdErrLabel: UILabel!
    @IBOutlet weak var phoneErrLabel: UILabel!
    
    
    @IBAction func nameFieldBegin(_ sender: Any) {
        nameErrorLabel.isHidden = true
        viewModel.nameError = ""
        imageLabel.isHidden = true
        
        if ((passwordTextField.text?.count)! > 6) && ((phoneTextField.text?.count)! > 9) && ((emailTextField.text?.count)! > 2) && ((nameTextField.text?.count)! > 2){
            signUPButton.isEnabled = true
        }
        else if (nameTextField.text?.count)! < 3 {
            signUPButton.isEnabled = false
        }
    }
    
    
    @IBAction func emailEditBegin(_ sender: Any) {
        emailErrorLabel.isHidden = true
        viewModel.emailError = ""
        imageLabel.isHidden = true
        
        if ((passwordTextField.text?.count)! > 6) && ((phoneTextField.text?.count)! > 9) && ((emailTextField.text?.count)! > 2) && ((nameTextField.text?.count)! > 2){
            signUPButton.isEnabled = true
        }
        else if (emailTextField.text?.count)! < 3 {
            signUPButton.isEnabled = false
        }
        
    }
    
    
    @IBAction func passwdEditChanging(_ sender: Any) {
        passwdErrLabel.isHidden = true
        viewModel.psswdError = ""
        imageLabel.isHidden = true
        
        if ((passwordTextField.text?.count)! > 6) && ((phoneTextField.text?.count)! > 9) && ((emailTextField.text?.count)! > 2) && ((nameTextField.text?.count)! > 2){
            signUPButton.isEnabled = true
        }
        else if (passwordTextField.text?.count)! < 7 {
            signUPButton.isEnabled = false
        }
    }
   
    
    @IBAction func phoneEditChanging(_ sender: Any) {
        imageLabel.isHidden = true
        phoneErrLabel.isHidden = true
        viewModel.phoneError = ""
        
        if ((passwordTextField.text?.count)! > 6) && ((phoneTextField.text?.count)! > 9) && ((emailTextField.text?.count)! > 2) && ((nameTextField.text?.count)! > 2){
            signUPButton.isEnabled = true
        }
        else if (phoneTextField.text?.count)! < 11 {
            signUPButton.isEnabled = false
        }
        
    }
    
    
    @IBOutlet weak var signUPButton: UIButton!
    
    
    @IBAction func signUPButton(_ sender: UIButton) {
        addName()
    
        print("\(formModel.names)")
        print(self.formModel)
        
        var RNames = [String]()
        RNames.append(contentsOf: formModel.names)
        print("\(RNames)")
        
        if self.viewModel.isValid {
            /*
            let arrayNames = formModel.names.map { "\($0)" }
            textViewField.text = arrayNames.joined(separator: "\n")
            */
            
            textViewField.text = RNames.joined(separator: "\n")
            clear()
            imageLabel.isHidden = false
            print("update successfully!")
            signUPButton.isEnabled = false
        }
        else{
            
            print(self.viewModel.brokenRules)
            
            if viewModel.nameError.isEmpty {
                nameErrorLabel.isHidden = true
            }
            else {
                nameErrorLabel.text = viewModel.nameError
                nameErrorLabel.isHidden = false
            }
            
            if viewModel.psswdError.isEmpty { passwdErrLabel.isHidden = true }
            else {
                passwdErrLabel.text = viewModel.psswdError
                passwdErrLabel.isHidden = false
            }
            
            if viewModel.emailError.isEmpty { emailErrorLabel.isHidden = true }
            else {
                emailErrorLabel.text = viewModel.emailError
                emailErrorLabel.isHidden = false
            }
            
            if viewModel.phoneError.isEmpty { phoneErrLabel.isHidden = true }
            else {
                phoneErrLabel.text = viewModel.phoneError
                phoneErrLabel.isHidden = false
            }
            
            //RNames.removeLast()
            formModel.names.removeLast()
            
           // addRN()
            print(self.formModel)
            print("after: \(formModel.names)")
            //print("after: \(formModel.RNames)")
            print("after: \(RNames)")
        }
    }
    
    
    @IBAction func restartButtion(_ sender: Any) {
        textViewField.text = ""
        clear()
        formModel.names = [""]
        
        self.view.endEditing(true)   //dismiss keyboard
        signUPButton.isEnabled = false
    }
    
    
    @IBAction func clearButton(_ sender: Any) {
        clear()
        self.view.endEditing(true)  //dismiss keyboard
        signUPButton.isEnabled = false
    }
    
    
    private func addName() {
        guard let nameTitle = nameTextField.text else { return }
        
        formModel.addName(title: nameTitle)
    
        viewModel.password = passwordTextField.text!
        viewModel.email = emailTextField.text!
        viewModel.name = nameTextField.text!
        viewModel.phone = phoneTextField.text!
    
        view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //nameTextField.resignFirstResponder()
        if (textField == nameTextField) {
           textField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        }
        else if (textField == emailTextField) {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }
        else if (textField == passwordTextField) {
            textField.resignFirstResponder()
            phoneTextField.becomeFirstResponder()
        }
        else if (textField == phoneTextField){
            textField.resignFirstResponder()
        }
        return true
    }

    
    func  clear() {
        nameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        phoneTextField.text = ""
        imageLabel.isHidden = true
    }
}


