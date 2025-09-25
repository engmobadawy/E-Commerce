//
//  CustomTextField.swift
//  MagdyTask
//
//  Created by AMNY on 21/08/2025.
//


import UIKit

@IBDesignable

class CustomTextField: UITextField {
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            updateStyle()
        }
    }
    
    @IBInspectable var horizontalPadding: CGFloat = 12

   
    @IBInspectable var fillColor: UIColor = .lightBlueF5F9FE {
        didSet {
            updateStyle()
        }
    }
    
    @IBInspectable var selectedStrokeColor: UIColor = UIColor.systemBlue
    @IBInspectable var placeholderColor: UIColor = .gray404040 {
        didSet {
            updatePlaceholder()
        }
    }
    @IBInspectable var showEyeButton: Bool = false {
        didSet {
            configureEyeButton()
        }
    }
    private var originalBorderColor: CGColor?
  

    private var eyeButton: UIButton?


  

    // Init for Storyboard/XIB
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    // Init for code
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    private func setup() {
        borderStyle = .none
        updateStyle()
        originalBorderColor = layer.borderColor
        addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
        updatePlaceholder()
    }

    private func updatePlaceholder() {
        guard let placeholder = self.placeholder else { return }
        self.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
        )
    }
    
    private func updateStyle() {
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.layer.masksToBounds = true
        self.backgroundColor = fillColor
    }
    
    private func leadingInset(for bounds: CGRect) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: horizontalPadding, bottom: 0, right: horizontalPadding)
    }
    
    private func configureEyeButton() {
     

        guard showEyeButton else { return }

        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.tintColor = .gray
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        eyeButton = button

        let padding: CGFloat = 10
        let containerWidth = button.frame.width + padding
        let containerHeight = max(button.frame.height, self.frame.height)
        let container = UIView(frame: CGRect(x: 0, y: 0, width: containerWidth, height: containerHeight))

        // Center the button vertically in the container
        button.center = CGPoint(x: button.frame.width / 2, y: containerHeight / 2)
        container.addSubview(button)
        
        rightView = container
        rightViewMode = .always

        // Must be secureTextEntry for password field
        self.isSecureTextEntry = true
    }

    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leadingInset(for: bounds))
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leadingInset(for: bounds))
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: leadingInset(for: bounds))
    }
    
    @objc private func editingDidBegin() {
        layer.borderWidth = 2
        layer.borderColor = selectedStrokeColor.cgColor
    }
    
    @objc private func editingDidEnd() {
        layer.borderWidth = 0
        layer.borderColor = originalBorderColor
    }
    
    @objc private func togglePasswordVisibility() {
        self.isSecureTextEntry.toggle()
        let currentText = self.text
        self.text = ""
        self.text = currentText
        let imageName = self.isSecureTextEntry ? "eye.slash" : "eye"
        eyeButton?.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        if let rightView = self.rightView {
//            let rightViewPoint = self.convert(point, to: rightView)
//            if rightView.bounds.contains(rightViewPoint) {
//                return rightView.hitTest(rightViewPoint, with: event)
//            }
//        }
//        return super.hitTest(point, with: event)
//    }
//شرح وظيفة الدالة باختصار
//    عند حدوث لمسة على الحقل، تتحقق الدالة أولًا مما إذا كانت اللمسة ضمن حدود الجزء الأيمن (rightView).
//
//    إذا كانت كذلك، تحول مكان اللمسة لإحداثيات الفيو وتعيد نتيجة اختبار اللمسة لهذا الجزء، مما يعني أن التفاعل يُعطى لهذا العنصر داخل الحقل (غالبًا زر أو أيقونة).
//
//    إذا لم تكن اللمسة في الفيو، تترك المعالجة الافتراضية لنظام iOS لتحديد العنصر المناسب الذي سيستقبل الحدث.
//
//    متى نحتاج هذه الطريقة؟
//    إذا أضفنا عناصر تفاعلية داخل الطرف الأيمن لحقل نصي (مثل زر مسح أو رمز)، وتريد أن تلتقط هذه العناصر اللمسات بشكل صحيح حتى لو تداخلت مع جزء من الحقل الأساسي.
//
//    تساعد في تحسين تجربة المستخدم، خاصة في الحالات التي تكون فيها مساحة التفاعل مع الأزرار أو الأيقونات صغيرة أو متداخلة.
//
//    ملخص مبسط
//    هذه الطريقة تجعل الدالة تعطي أولوية للتفاعل مع العنصر الموجود على الطرف الأيمن (rightView)، وقبل أن تعتمد على السلوك الافتراضي لجهاز iOS في توزيع اللمسات على العناصر الأخرى.
}
