#import "TableViewViewController.h"
#import "User.h"
#import "DetailViewController.h"

@interface TableViewViewController () <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSMutableArray *arrayUserData;
    User *user;
    NSManagedObjectContext *managedObjectContext;
}

@end


@implementation TableViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] setDataSource:self];
    [[self tableView] setDelegate:self];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    
    arrayUserData = [[NSMutableArray alloc] init];
    user = [[User alloc] init];
    
    [self loadUserData];
    [[self tableView] reloadData];
}

- (void)loadUserData {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext]];
    [fetchRequest setIncludesPropertyValues:NO];
    
    NSError *error = nil;
    NSArray *arrayFetchObject = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    for (user in arrayFetchObject) {
        [arrayUserData addObject:user];
    }
    [[self tableView] reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayUserData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[self tableView] dequeueReusableCellWithIdentifier:@"Cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    user = [arrayUserData objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[user name]];
    [[cell detailTextLabel] setText:[user last_name]];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    managedObjectContext = [appDelegate managedObjectContext];
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    fetch.entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:managedObjectContext];
    NSArray *array = [managedObjectContext executeFetchRequest:fetch error:nil];
    
    NSLog(@"%@", array);
    
    NSManagedObject *object = [array objectAtIndex:[indexPath row]];
    [managedObjectContext deleteObject:object];
    
    NSError *error = nil;
    [managedObjectContext save:&error];
    
    [arrayUserData removeObjectAtIndex:[indexPath row]];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"OpenDetail" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *detail = [segue destinationViewController];
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    user = [arrayUserData objectAtIndex:[indexPath row]];
    [detail setUser:user];
}

@end
