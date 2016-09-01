//
//  ViewController.h
//  collectionview
//
//  Created by ilyas on 8/29/16.
//  Copyright © 2016 ilyas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCell.h"

@interface ViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *myCollectionView;
@property (strong, nonatomic) NSMutableArray *arrayOfImages;

@property (strong, nonatomic) CustomCell *cell;
@property (strong, nonatomic) NSIndexPath *selectedPath;

@end

