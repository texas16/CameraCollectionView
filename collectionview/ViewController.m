//
//  ViewController.m
//  collectionview
//
//  Created by ilyas on 8/29/16.
//  Copyright © 2016 ilyas. All rights reserved.
//

#import "ViewController.h"
#import "CustomCell.h"

#define NUMBER_OF_IMAGES 5


@interface ViewController ()
{
    //NSArray *arrayOfImages;
    int pos;

}
@end

@implementation ViewController
@synthesize arrayOfImages,cell,selectedPath;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[self myCollectionView]setDataSource:self];
    [[self myCollectionView]setDelegate:self];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [collectionViewFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.myCollectionView.collectionViewLayout = collectionViewFlowLayout;
    
    self.myCollectionView.pagingEnabled = NO;
 
    arrayOfImages = [[NSMutableArray alloc] initWithObjects:
                     [UIImage imageNamed:@"photo.png"],
                     nil];
}

//- (void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    [self.myCollectionView layoutIfNeeded];
//
//    //NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[arrayOfImages count] inSection:1]; // compute some index path
//    NSIndexPath *indexPath =[arrayOfImages objectAtIndex:0];
//    
//    [self.myCollectionView scrollToItemAtIndexPath:indexPath
//                                atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
//                                        animated:YES];
//}

// add delegate methods below

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return [arrayOfImages count];

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{

    static NSString *CellIdentifier = @"Cell";
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,100,100)];
//    imgView.contentMode = UIViewContentModeScaleAspectFit;
//    imgView.clipsToBounds = YES;
//    imgView.image = [arrayOfImages objectAtIndex:indexPath.row];
//    [cell addSubview:imgView];
    cell.myImage.image = [arrayOfImages objectAtIndex:indexPath.item];
    
    //[[cell myImage]setImage:[UIImage imageNamed:[arrayOfImages objectAtIndex:indexPath.item]]];
   // [[cell myImage]setImage:[UIImage imageNamed:@"1.png"]];
   // cell.transform = self.myCollectionView.transform;

    
    return cell;
    

}

//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(nonnull UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    //top, left, bottom, right
//    return UIEdgeInsetsMake(0, 16, 0, 16);
//}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //return CGSizeMake( self.view.frame.size.width / 3, 140);
    return CGSizeMake( 100, 100);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // pos represents previous or initial position
    // indexPath represents clicked cell position
    
    if ([[arrayOfImages objectAtIndex:indexPath.row] isEqual:[UIImage imageNamed:@"photo.png"]]) {
        [self defaultImageClicked];
    } else {
        [self existingImageClicked];
    }
    self.selectedPath = indexPath;
    if(indexPath.row > pos)
    {
        if (indexPath.row - pos == 2) {
            pos = pos + 1;
        }
        [self changeDate];
    }
    else if (indexPath.row == pos)
    {
        NSLog(@"Do Nothing");
    }
    else
    {
        if (indexPath.row + 2 == pos) {
            pos = pos - 1;
        }
        [self changeDate1];
    }
    //NSLog(@"%@",[arrDate objectAtIndex:indexPath.row]);
}

-(void)changeDate
{
    if (pos<(arrayOfImages.count - 2)) {
        pos=pos+1;
        [self.myCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:pos inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        NSLog(@"%@",[arrayOfImages objectAtIndex:pos]);
        //self.lblMovieName.text =[arrayOfImages objectAtIndex:pos];
    }
}
-(void)changeDate1
{
    if(pos>2)
    {
        pos=pos-1;
        [self.myCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:pos inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
        NSLog(@"%@",[arrayOfImages objectAtIndex:pos]);
        //self.lblMovieName.text =[arrayOfImages objectAtIndex:pos];
    }
    else{
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) defaultImageClicked
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Photo" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [message addButtonWithTitle:@"Take Photo"];
    [message addButtonWithTitle:@"Use Camera Roll"];
    [message show];
    
}


-(void) existingImageClicked
{
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Choose Photo" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
    [message addButtonWithTitle:@"Take Photo"];
    [message addButtonWithTitle:@"Use Camera Roll"];
    [message addButtonWithTitle:@"Delete"];
    
    [message show];
    
}

- (void)alertView:(UIAlertView *)alertView
clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0){
        NSLog(@"cancel");
    }
    else if (buttonIndex == 1)
    {
        NSLog(@"photo");
        [self selectPhotoFromGallery];
    }
    else if (buttonIndex == 2)
    {
        NSLog(@"camera");
        [self takePhotoFromCamera];
    }
    else if(buttonIndex == 3)
    {
        [self removeSelected];

    }
}

-(void) selectPhotoFromGallery
{
    UIImagePickerControllerSourceType source = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //[self presentViewController:picker animated:YES completion:NULL];
    [self presentViewController:picker animated:YES completion:^{
        //iOS 8 bug.  the status bar will sometimes not be hidden after the camera is displayed, which causes the preview after an image is captured to be black
        if (source == UIImagePickerControllerSourceTypeCamera) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
    }];
}

- (void) takePhotoFromCamera
{
    UIImagePickerControllerSourceType source = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //[self presentViewController:picker animated:YES completion:NULL];
    [self presentViewController:picker animated:YES completion:^{
        //iOS 8 bug.  the status bar will sometimes not be hidden after the camera is displayed, which causes the preview after an image is captured to be black
        if (source == UIImagePickerControllerSourceTypeCamera) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImagePickerControllerSourceType source = [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    //selectPhotoBtnOutlet.hidden=YES;
    //takePhotoBtnOutlet.hidden=YES;
    __block ViewController *aBlockSelf = self; // Replace MyViewController with your View Controller
    [picker dismissViewControllerAnimated:YES completion:^{
        //aBlockSelf.productImg.hidden = NO;
        // aBlockSelf.makeTF.hidden = NO;
        //aBlockSelf.cancelBtnOutlet.hidden=NO;
       // [aBlockSelf.arrayOfImages objectAtIndex:0] = chosenImage;
       // aBlockSelf.cell.myImage.image
        //aBlockSelf.productImg.image = chosenImage;
        //[aBlockSelf.arrayOfImages a:chosenImage];
        [aBlockSelf.arrayOfImages replaceObjectAtIndex:self.selectedPath.row withObject:chosenImage];
        if([aBlockSelf.arrayOfImages count]< NUMBER_OF_IMAGES)
        {
            [aBlockSelf.arrayOfImages addObject:[UIImage imageNamed:@"photo.png"]];
        }
        
        [self.myCollectionView reloadData];
        
        [self.myCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:[aBlockSelf.arrayOfImages count]-1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];

        if (source == UIImagePickerControllerSourceTypeCamera) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
        }
    }];
}

-(void) removeSelected
{
    [arrayOfImages removeObjectAtIndex: self.selectedPath.row];
    if (![[arrayOfImages objectAtIndex:[arrayOfImages count]-1] isEqual:[UIImage imageNamed:@"photo.png"]])
    {
        [arrayOfImages addObject:[UIImage imageNamed:@"photo.png"]];
    }
    
    [self.myCollectionView reloadData];
    
     [self.myCollectionView selectItemAtIndexPath:[NSIndexPath indexPathForRow:[self.arrayOfImages count]-1 inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    
   /* if([UIImageJPEGRepresentation(image1) isEqualToData:UIImageJPEGRepresentation(image2)])
    {
        NSLog(@"Same images");
    } */

}


@end
