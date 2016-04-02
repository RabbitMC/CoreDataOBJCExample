//
//  TableViewController.m
//  CarSpotter
//
//  Created by Miralem Cebic on 02/04/16.
//  Copyright © 2016 Miralem Cebic. All rights reserved.
//

#import "TableViewController.h"
#import <CoreData/CoreData.h>

@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *devices;

@end

@implementation TableViewController

#pragma mark - private
- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *moContext = nil;
    id delegate = [[UIApplication sharedApplication] delegate];

    if ([delegate performSelector:@selector(managedObjectContext)]) {
        moContext = [delegate managedObjectContext];
    }

    return moContext;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    NSManagedObjectContext *moContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Device"];

    NSError *fetchError = nil;
    self.devices = [[moContext executeFetchRequest:fetchRequest error:&fetchError] mutableCopy];
    if (fetchError) {
        NSLog(@"Error while fetching from CoreData DataBade %@ %@ %@", fetchError, fetchError.localizedDescription, fetchError.localizedFailureReason);
    }

    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.devices.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];

    NSManagedObject *device = self.devices[indexPath.row];

    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [device valueForKey:@"text1"], [device valueForKey:@"text2"]]; // car model // car make
    cell.detailTextLabel.text = [device valueForKey:@"text3"]; // car year

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
