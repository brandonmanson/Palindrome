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

- (NSString *)sanitizeString:(NSString *)userInput {
    NSString *whiteSpaceTrimmedString = [[NSString alloc]initWithString:[userInput stringByReplacingOccurrencesOfString:@" " withString:@""]];
    NSString *sanitizedString = [whiteSpaceTrimmedString lowercaseString];
    NSLog(@"Sanitized string is %@", sanitizedString);
    return sanitizedString;
}

- (NSString *)reverseString:(NSString *)sanitizedString {
    
    NSMutableString *reverseString = [NSMutableString stringWithCapacity:[sanitizedString length]];
    [sanitizedString enumerateSubstringsInRange:NSMakeRange(0, [sanitizedString length]) options:(NSStringEnumerationReverse | NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        [reverseString appendString:substring];
    }];
    return reverseString;
}

- (BOOL)isValidFormat:(NSString *)stringToEvaluate {
    NSUInteger numberOfMatches = [self numberOfMatches:stringToEvaluate];
    NSLog(@"Number of matches is %lu", numberOfMatches);
    if (numberOfMatches > 0) {
        return NO;
    } else {
        return TRUE;
    }
}

- (NSUInteger)numberOfMatches:(NSString *)userInput {
    NSError *error = NULL;
    
    // Regex for checking for special characters
    NSRegularExpression *containsSpecialCharactersRegex = [NSRegularExpression regularExpressionWithPattern:@"\\W" options:NSRegularExpressionCaseInsensitive error:&error];
    
    // Regex for checking for numbers
    NSRegularExpression *containsNumbersRegex = [NSRegularExpression regularExpressionWithPattern:@"\\d" options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSUInteger numberOfMatches = 0;
    
    // Check for special characters
    NSUInteger numberOfMatchesForSpecialCharacters =[containsSpecialCharactersRegex numberOfMatchesInString:userInput
                                                                                                    options:0
                                                                                                      range:NSMakeRange(0, [userInput length])];
    //Check for numbers
    NSUInteger numberOfMatchesForNumbers = [containsNumbersRegex numberOfMatchesInString:userInput
                                                                                 options:0
                                                                                   range:NSMakeRange(0, [userInput length])];
    numberOfMatches = numberOfMatchesForSpecialCharacters + numberOfMatchesForNumbers;
    return numberOfMatches;
}

- (void)checkStringEquality:(NSString *)stringToCheck originalString:(NSString *)originalString {
    NSString *sanitizedString = [self sanitizeString:stringToCheck];
    NSString *reversedString = [self reverseString:sanitizedString];
    if ([stringToCheck isEqualToString:reversedString]) {
        _isPalindromeLabel.text = [NSString stringWithFormat:@"%@ is a palindrome!", originalString];
    } else {
        _isPalindromeLabel.text = [NSString stringWithFormat:@"%@ is not a palindrome", originalString];
    }
}

- (void)checkForPalindrome:(NSString *)userInput {
    NSString *sanitizedString = [self sanitizeString:userInput];
    if ([userInput isEqualToString:@""]) {
        _isPalindromeLabel.text = @"Input cannot be empty. Please enter a string.";
    } else if ([self isValidFormat:sanitizedString]) {
        [self checkStringEquality:sanitizedString originalString:userInput];
    } else {
        _isPalindromeLabel.text = @"Input cannot contain special characters or numbers";
    }

    
}
- (IBAction)checkPalindromeButtonPressed:(id)sender {
    [self checkForPalindrome:_userInputTextField.text];
}

@end
