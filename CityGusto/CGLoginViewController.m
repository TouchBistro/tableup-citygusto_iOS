//
//  CGLoginViewController.m
//  CityGusto
//
//  Created by Padraic Doyle on 4/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import "CGRestaurantParameter.h"
#import "CGAppDelegate.h"
#import <RestKit/RestKit.h>
#import "CGLoginViewController.h"

@interface CGLoginViewController ()

@end

@implementation CGLoginViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    if ([self.navigationController.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        UIImage *navBarImg = [UIImage imageNamed:@"appHeader.png"];
        [self.navigationController.navigationBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    
    self.fbLoginView.delegate = self;
    
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityView.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    [self.view addSubview: self.activityView];
    
    [self.scroller setScrollEnabled:YES];
    [self.scroller setContentSize:CGSizeMake(320, 800)];
    
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    
    if (user && user.id){
        NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
        [params setObject:user.id forKey:@"fbUid"];
        
        [self.activityView startAnimating];
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/facebook/login"
                                               parameters:params
                                                  success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                      if (mappingResult){
                                                          [CGRestaurantParameter shared].loggedInUser = [[mappingResult array] objectAtIndex:0];
                                                          [self dismissViewControllerAnimated:YES completion:nil];
                                                          [self.delegate loginSuccessful];
                                                      }
                                                      
                                                      [self.activityView stopAnimating];
                                                  }
                                                  failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                      message:@"There was an issue"
                                                                                                     delegate:nil
                                                                                            cancelButtonTitle:@"OK"
                                                                                            otherButtonTitles:nil];
                                                      [alert show];
                                                      NSLog(@"Hit error: %@", error);
                                                      
                                                      [self.activityView stopAnimating];
                                                  }];
        
    }
}

- (IBAction)login:(id)sender {
    if (self.emailTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email"
                                                        message:@"Email can not be blank."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
        
    }
    
    if (self.passwordTextField.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password"
                                                        message:@"Password can not be blank."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    NSString *username = self.emailTextField.text;
    NSString *password = self.passwordTextField.text;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username forKey:@"username"];
    [params setObject:password forKey:@"password"];
    
    [self.activityView startAnimating];
    [[RKObjectManager sharedManager] getObjectsAtPath:@"/MattsMenus/mobile/native/login"
                                           parameters:params
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  if (mappingResult){
                                                      [CGRestaurantParameter shared].loggedInUser = [[mappingResult array] objectAtIndex:0];
                                                      [self dismissViewControllerAnimated:YES completion:nil];
                                                      [self.delegate loginSuccessful];
                                                  }
                                                  
                                                  [self.activityView stopAnimating];
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:@"There was an issue"
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                                  [alert show];
                                                  NSLog(@"Hit error: %@", error);
                                                  
                                                  [self.activityView stopAnimating];
                                              }];
    
}


- (void)keyboardWasShown:(NSNotification *)notification
{
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    self.scroller.contentInset = contentInsets;
    self.scroller.scrollIndicatorInsets = contentInsets;
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, self.loginButton.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, self.loginButton.frame.origin.y - (keyboardSize.height-68));
        [self.scroller setContentOffset:scrollPoint animated:YES];
    }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scroller.contentInset = contentInsets;
    self.scroller.scrollIndicatorInsets = contentInsets;
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.passwordTextField resignFirstResponder];
}



- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
