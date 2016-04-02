//
//  AddDataViewController.m
//  CarSpotter
//
//  Created by Miralem Cebic on 02/04/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "AddDataViewController.h"
#import <CoreData/CoreData.h>

@interface AddDataViewController ()
@property (weak, nonatomic) IBOutlet UITextField *carMakeTextfield;
@property (weak, nonatomic) IBOutlet UITextField *carModelTextfield;
@property (weak, nonatomic) IBOutlet UITextField *carYearTextfield;

@end

@implementation AddDataViewController
@synthesize  device;

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *moContext = nil;
    id delegate = [[UIApplication sharedApplication] delegate];

    if ([delegate performSelector:@selector(managedObjectContext)]) {
        moContext = [delegate managedObjectContext];
    }

    return moContext;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveDataButton:(UIButton *)sender
{
    NSManagedObjectContext *moContext = [self managedObjectContext];

    NSManagedObject *newDevice = [NSEntityDescription insertNewObjectForEntityForName:@"Device"
                                                               inManagedObjectContext:moContext];

    [newDevice setValue:self.carMakeTextfield.text forKey:@"text1"];
    [newDevice setValue:self.carModelTextfield.text forKey:@"text2"];
    [newDevice setValue:self.carYearTextfield.text forKey:@"text3"];

    NSError *error = nil;
    if (![moContext save:&error]) {
        NSLog(@"Error while saving data %@ %@", error, error.localizedDescription);
    }

    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)dismissKeyboard:(id)sender
{
    [self resignFirstResponder];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
