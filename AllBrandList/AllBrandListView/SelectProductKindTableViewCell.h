//
//  SelectProductKindTableViewCell.h
//  MustListen
//
//  Created by 侯琛 on 16/8/29.
//  Copyright © 2016年 MustListen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectProductKindTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *kindTitle;
@property (nonatomic,assign)BOOL ifSelected;
@end
