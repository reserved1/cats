import UIKit

class SheetRequirementView: UIViewController {
// MARK: Properties for Sheet View.
    var confirmButton: ( () -> Void )?
    var flag: Bool = false
    let requirement: Requirement
    let textField: UITextField = UITextField(frame: CGRect(x: 45, y: 40, width: 300, height: 50))
    let sheetButton: UIButton = UIButton(frame: CGRect(x: 120, y: 140, width: 150, height: 30))
// MARK: Initializers.
    init(_ requirement: Requirement) {
        self.requirement = requirement
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: View Lifecyle.
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTextField()
        setupButton()
        sheetButton.addTarget(self, action: #selector(doActionButton), for: .touchUpInside)
    }
    // Binding for closure confirmButton. Used on Requirement View Controller.
    @objc private func doActionButton() {
        confirmButton?()
        dismiss(animated: true)
    }
// MARK: View properties configuration.
    func setupTextField() {
        textField.placeholder = requirement.text.isEmpty ? "Write your requirement" : requirement.text
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.keyboardType = .default
        textField.autocorrectionType = .no
        self.view.addSubview(textField)
    }

    func setupButton() {
        sheetButton.setTitle("Confirm", for: .normal)
        sheetButton.setTitleColor(.systemBackground, for: .normal)
        sheetButton.backgroundColor = .label
        sheetButton.layer.cornerRadius = 10
        sheetButton.layer.cornerCurve = .continuous
        self.view.addSubview(sheetButton)
    }

}
