//
//  DetailViewController.h
//  CoreDataTutorial
//
//  Created by Alex on 2/21/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "FirstViewController.h"

@interface DetailViewController : FirstViewController

@property (strong, nonatomic) User *user;

@end
