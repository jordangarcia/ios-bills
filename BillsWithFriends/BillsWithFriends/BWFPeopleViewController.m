//
//  BWFPeopleViewController.m
//  BillsWithFriends
//
//  Created by Austin Marusco on 12/7/13.
//  Copyright (c) 2013 Austin Marusco. All rights reserved.
//

#import "BWFPeopleViewController.h"
#import "BWFAppDelegate.h"

#define PERSON_TEXT_VIEW_HORIZONTAL_BUFFER 10
#define PERSON_TEXT_VIEW_VERTICAL_BUFFER 10
#define PERSON_TEXT_VIEW_VERTICAL_HEIGHT 30

#define PERSON_TABLEVIEW_ORIGIN_Y PERSON_TEXT_VIEW_VERTICAL_BUFFER *2 + TOP_BAR_HEIGHT + self.personTextField.frame.size.height
#define TOP_BAR_HEIGHT [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height

@interface BWFPeopleViewController ()

@property (nonatomic,strong) UITextField *personTextField;
@property (nonatomic,strong) UITableView *personTableView;

@property (nonatomic,strong) NSMutableArray *peopleArray;

@end

@implementation BWFPeopleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.peopleArray = [[NSMutableArray alloc] init];
    
    self.personTextField = [[UITextField alloc] init];
    self.personTextField.backgroundColor = [UIColor redColor];
    self.personTextField.delegate = self;
    
    self.personTableView = [[UITableView alloc] init];
    self.personTableView.delegate = self;
    self.personTableView.dataSource = self;
    [self.personTableView setBackgroundColor:[UIColor greenColor]];
    [self.personTableView setSeparatorInset:UIEdgeInsetsZero];
    self.personTableView.contentOffset = CGPointMake(0, 0);
    
    
    //nav button
    UIBarButtonItem *nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStylePlain target:self action:@selector(nextButtonPressed:)];
    self.navigationItem.rightBarButtonItem = nextButton;
    
    [self.view addSubview:self.personTableView];
    [self.view addSubview:self.personTextField];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self layoutViews];
}

- (void)layoutViews
{

    self.personTextField.frame = CGRectMake(PERSON_TEXT_VIEW_HORIZONTAL_BUFFER,
                                           PERSON_TEXT_VIEW_VERTICAL_BUFFER + TOP_BAR_HEIGHT,
                                           self.view.frame.size.width - 2*PERSON_TEXT_VIEW_HORIZONTAL_BUFFER,
                                           PERSON_TEXT_VIEW_VERTICAL_HEIGHT);
    
    self.personTableView.frame = CGRectMake(PERSON_TEXT_VIEW_HORIZONTAL_BUFFER,
                                            PERSON_TABLEVIEW_ORIGIN_Y,
                                            self.view.frame.size.width - 2*PERSON_TEXT_VIEW_HORIZONTAL_BUFFER,
                                            self.view.frame.size.height - PERSON_TABLEVIEW_ORIGIN_Y);
    
    
    // NSLog(@"first output:%@ second output:%@",self.personTextView,self.personTableView);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - text edit
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.peopleArray addObject:textField.text];
    [self.personTableView reloadData];
    
    textField.text = @"";
    
    //[textField resignFirstResponder];

    return NO;
}

#pragma mark - table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.peopleArray count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [self.peopleArray objectAtIndex:[self.peopleArray count]-1 - indexPath.row];
    
    
    return cell;
}

#pragma mark - buttons
-(void)nextButtonPressed:(id)sender
{
    
    UIViewController *newViewController = [[UIViewController alloc] init];
    [newViewController.view setBackgroundColor:[UIColor yellowColor]];
    
    [self.navigationController pushViewController:newViewController animated:YES];
    
    
}




@end
