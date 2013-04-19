//
//  CGLoginViewController.h
//  CityGusto
//
//  Created by Padraic Doyle on 4/19/13.
//  Copyright (c) 2013 CityGusto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CGLoginViewDelegate
- (void) loginSuccessful;
@end

@interface CGLoginViewController : UIViewController <UITextFieldDelegate>{
    id <CGLoginViewDelegate> delegate;
}

@property (nonatomic, assign) id <CGLoginViewDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)login:(id)sender;

@property (strong, nonatomic) IBOutlet UIScrollView *scroller;
@property (strong, nonatomic) UIActivityIndicatorView *activityView;

@end
