#import "ViewController.h"

@interface ViewController() <UITextFieldDelegate>
@property(nonatomic, strong) UIView *viewResultColor;
@property(nonatomic, strong) UILabel *labelRed;
@property(nonatomic, strong) UILabel *labelGreen;
@property(nonatomic, strong) UILabel *labelBlue;
@property(nonatomic, strong) UILabel *labelResultColor;
@property(nonatomic, strong) UITextField *textFieldRed;
@property(nonatomic, strong) UITextField *textFieldGreen;
@property(nonatomic, strong) UITextField *textFieldBlue;
@property(nonatomic, strong) UIButton *buttonProcess;
@end

@implementation ViewController

//MARK: -

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.accessibilityIdentifier = @"mainView";
    self.view.isAccessibilityElement = NO;
    
    //Main stack
    UIStackView *stackView = [UIStackView new];
    stackView.isAccessibilityElement = NO;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.spacing = 60;
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFill;
    
    [self.view addSubview:stackView];
    
    //Button
    self.buttonProcess = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.buttonProcess setTitle:@"Process" forState:UIControlStateNormal];
    self.buttonProcess.accessibilityIdentifier = @"buttonProcess";
    [self.buttonProcess addTarget:self action:@selector(buttonProcessedTaped) forControlEvents:UIControlEventTouchUpInside];
    
    //Result
    self.labelResultColor = [self labelWithText:nil accessibilityIdentifier:@"labelResultColor"];
    self.labelResultColor.text = @"Color";
    
    self.viewResultColor = [UIView new];
    self.viewResultColor.isAccessibilityElement = YES;
    self.viewResultColor.accessibilityIdentifier = @"viewResultColor";
    self.viewResultColor.backgroundColor = [UIColor grayColor];
    
    UIStackView *resultColorStack = [self horizontalStackViewWithSubviews:@[self.labelResultColor, self.viewResultColor]];
    
    //Red
    self.labelRed = [self labelWithText:@"RED" accessibilityIdentifier:@"labelRed"];
    self.textFieldRed = [self textFieldWithAccessibilityIdentifier:@"textFieldRed"];
    UIStackView *redStack = [self horizontalStackViewWithSubviews:@[self.labelRed, self.textFieldRed]];
    
    //Green
    self.labelGreen = [self labelWithText:@"GREEN" accessibilityIdentifier:@"labelGreen"];
    self.textFieldGreen = [self textFieldWithAccessibilityIdentifier:@"textFieldGreen"];
    UIStackView *greenStack = [self horizontalStackViewWithSubviews:@[self.labelGreen, self.textFieldGreen]];
    
    //Blue
    self.labelBlue = [self labelWithText:@"BLUE" accessibilityIdentifier:@"labelBlue"];
    self.textFieldBlue = [self textFieldWithAccessibilityIdentifier:@"textFieldBlue"];
    UIStackView *blueStack = [self horizontalStackViewWithSubviews:@[self.labelBlue, self.textFieldBlue]];
    
    //Content Stack
    UIStackView *contentStack = [[UIStackView alloc] initWithArrangedSubviews:@[resultColorStack, redStack, greenStack, blueStack]];
    contentStack.isAccessibilityElement = NO;
    contentStack.spacing = 32;
    contentStack.axis = UILayoutConstraintAxisVertical;
    contentStack.alignment = UIStackViewAlignmentFill;
    contentStack.distribution = UIStackViewDistributionFill;
    
    [stackView addArrangedSubview:contentStack];
    [stackView addArrangedSubview:self.buttonProcess];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:16],
        [stackView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-16],
        [stackView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:60],
        [self.textFieldRed.widthAnchor constraintEqualToAnchor:self.textFieldGreen.widthAnchor],
        [self.textFieldGreen.widthAnchor constraintEqualToAnchor:self.textFieldBlue.widthAnchor],
        [self.viewResultColor.heightAnchor constraintEqualToConstant:34],
        [self.viewResultColor.widthAnchor constraintEqualToAnchor:self.textFieldRed.widthAnchor multiplier:0.9]
    ]];
}

//MARK: - Action
- (void)buttonProcessedTaped {
    
    [self.view endEditing: YES];
    
    if (![self isColorValueValid:self.textFieldRed.text]
        || ![self isColorValueValid:self.textFieldGreen.text]
        || ![self isColorValueValid:self.textFieldBlue.text]) {
        
        self.labelResultColor.text = @"Error";
        return;
    }
    
    NSInteger red = self.textFieldRed.text.integerValue;
    NSInteger green = self.textFieldGreen.text.integerValue;
    NSInteger blue = self.textFieldBlue.text.integerValue;
    
    NSInteger hex = (red << 16) | (green << 8) | (blue);
    
    NSString *hexString = [[NSString stringWithFormat:@"%06lx", (long)hex] uppercaseString];
    self.labelResultColor.text = [NSString stringWithFormat:@"0x%@", hexString];
    self.viewResultColor.backgroundColor = [UIColor colorWithRed:((CGFloat)red)/255 green:((CGFloat)green)/255 blue:((CGFloat)blue)/255 alpha:1];
}


//MARK: - Private
- (UILabel*)labelWithText:(NSString*)text accessibilityIdentifier:(NSString*)identifier {
    UILabel *label = [UILabel new];
    label.isAccessibilityElement = YES;
    label.text = text;
    label.accessibilityIdentifier = identifier;
    return label;
}

- (UITextField *)textFieldWithAccessibilityIdentifier:(NSString*)identifier {
    UITextField *textField = [UITextField new];
    textField.delegate = self;
    textField.placeholder = @"0..255";
    textField.accessibilityIdentifier = identifier;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    return textField;
}

-(UIStackView*)horizontalStackViewWithSubviews:(NSArray<UIView*>*)subviews {
    UIStackView *stackView = [[UIStackView alloc] initWithArrangedSubviews:subviews];
    stackView.isAccessibilityElement = NO;
    stackView.spacing = 16;
    stackView.axis = UILayoutConstraintAxisHorizontal;
    stackView.alignment = UIStackViewAlignmentFill;
    stackView.distribution = UIStackViewDistributionFill;
    return stackView;
}

- (BOOL)isColorValueValid:(NSString *)text {
    if (text == nil || [text isEqualToString:@""]) {
        return NO;
    }
    NSCharacterSet *digitsSet = [NSCharacterSet decimalDigitCharacterSet];
    if (![[text stringByTrimmingCharactersInSet:digitsSet] isEqualToString:@""]) {
        return NO;
    }
    if (text.integerValue < 0 || text.integerValue > 255) {
        return NO;
    }
    return YES;
}

//MARK: - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    self.labelResultColor.text = @"Color";
    return YES;
}

@end
