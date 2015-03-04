//
//  ViewController.m
//  prlx
//
//  Created by xcode on 2/12/15.
//  Copyright (c) 2015 MSCline. All rights reserved.
//

#import "ViewController.h"


@interface ViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

  @property (weak, nonatomic) IBOutlet UITableView *tableView;
  @property NSMutableArray *arrayOfDataToDisplay;

  @property UIImageView *headerImageView;
  @property UIImageView *backgroundImageForHeader;

  @property float imageHeight;
  @property float imageWidth;

  @property int counter;

@end


@implementation ViewController
  @synthesize headerImageView, tableView, backgroundImageForHeader;

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self buildHeader];

}

-(void)buildHeader
{
    // set defaults
    self.imageWidth = self.view.frame.size.width;
    self.imageHeight = 200;

    // create header image
    headerImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
    headerImageView.image = [UIImage imageNamed:@"photo.png"];

    // create header background image
    backgroundImageForHeader = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.imageWidth, self.imageHeight)];
    backgroundImageForHeader.image = [UIImage imageNamed:@"hw.png"];

    // create header
    UIView *view = [[UIView alloc]initWithFrame:headerImageView.frame];
    view.clipsToBounds = true;
    view.backgroundColor = [UIColor blackColor];
    self.tableView.tableHeaderView = view;

    // add items to header
    [self.tableView.tableHeaderView addSubview:backgroundImageForHeader];
    [self.tableView.tableHeaderView addSubview:headerImageView];

    // change background color for when it shrinks
    tableView.backgroundColor = [UIColor blackColor];

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 3;

}

-(UITableViewCell *)tableView:(UITableView *)tableVieww cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    cell.textLabel.text = @"Some Text";
    cell.backgroundColor = [UIColor grayColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;

}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Section Header";
}

#pragma mark RESIZE HEADER IMAGE ON SCROLL

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [self moveAndScaleImage];
    [self flickerImage];

}

-(void)moveAndScaleImage
{

    // move image
    float velocityDampingFactor = 10;
    float yPosition = tableView.contentOffset.y / velocityDampingFactor;

    // let image jump up and down a bit by adding a little here or there
    float xPosition = arc4random_uniform(5);
    yPosition = yPosition + arc4random_uniform(8);

    // scale image
    float scaling = 1  + tableView.contentOffset.y / self.imageHeight;

    float width = self.imageWidth * scaling;
    float height = self.imageHeight * scaling;

    // resize
    headerImageView.frame = CGRectMake(xPosition, yPosition, width, height);
    backgroundImageForHeader.frame = CGRectMake(xPosition/2, yPosition/2, width*2, height*2);
}

-(void)flickerImage
{
    self.counter++;

    if (self.counter % 4 == 0) {

        headerImageView.hidden = !headerImageView.hidden;
        backgroundImageForHeader.hidden = !backgroundImageForHeader.hidden;
    }

}


#pragma mark RESET IMAGE ON STOP SCROLL

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    headerImageView.hidden = false;
    backgroundImageForHeader.hidden = false;

}

@end
