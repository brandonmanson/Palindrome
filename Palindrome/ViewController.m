//
//  ViewController.m
//  Palindrome
//
//  Created by DetroitLabs on 5/24/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//
// String property userInput
// Error handling for special characters
// Error handling for empty string
// Method for checking equality between userInput and userInput.reverse



#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Sanitize String

- (NSString *)sanitizeString:(NSString *)userInput {
    NSError *error = NULL;
    NSString *lowerCaseString = [userInput lowercaseString];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\W" options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *sanitizedString = [regex stringByReplacingMatchesInString:lowerCaseString options:0 range:NSMakeRange(0, [userInput length]) withTemplate:@""];
    NSLog(@"Sanitized string is %@", sanitizedString);
    return sanitizedString;
}

#pragma mark Reverse String

- (NSString *)reverseString:(NSString *)sanitizedString {
    
    NSMutableString *reverseString = [NSMutableString stringWithCapacity:[sanitizedString length]];
    [sanitizedString enumerateSubstringsInRange:NSMakeRange(0, [sanitizedString length]) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverseString appendString:substring];
    }];
    return reverseString;
}


- (void)checkStringEquality:(NSString *)originalString {
    NSString *sanitizedString = [self sanitizeString:originalString];
    NSString *reversedString = [self reverseString:sanitizedString];
    if ([sanitizedString isEqualToString:reversedString]) {
        _isPalindromeLabel.text = [NSString stringWithFormat:@"%@ is a palindrome!", originalString];
    } else {
        _isPalindromeLabel.text = [NSString stringWithFormat:@"%@ is not a palindrome", originalString];
    }
}

- (void)checkForPalindrome:(NSString *)userInput {
    if ([userInput isEqualToString:@""]) {
        _isPalindromeLabel.text = @"Input cannot be empty. Please enter a string.";
    } else {
        [self checkStringEquality:userInput];
    }

    
}
- (IBAction)checkPalindromeButtonPressed:(id)sender {
    [self checkForPalindrome:_userInputTextField.text];
}

@end
