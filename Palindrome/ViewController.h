//
//  ViewController.h
//  Palindrome
//
//  Created by DetroitLabs on 5/24/16.
//  Copyright © 2016 DetroitLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, strong)NSString *userInput;

- (void)checkForPalindrome:(NSString *)userInput;
- (NSString *)sanitizeString:(NSString *)userInput;
- (NSString *)reverseString:(NSString *)sanitizedString;
- (NSUInteger)numberOfMatches:(NSString *)userInput;
- (void)checkStringEquality:(NSString *)stringToCheck originalString:(NSString *)originalString;
- (void)checkAgainstRegularExpressions:(NSString *)stringToEvaluate;

@property (weak, nonatomic) IBOutlet UILabel *isPalindromeLabel;
@property (weak, nonatomic) IBOutlet UITextField *userInputTextField;

@end

