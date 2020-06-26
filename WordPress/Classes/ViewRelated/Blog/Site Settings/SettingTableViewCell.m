#import "SettingTableViewCell.h"
#import "WordPress-Swift.h"

@implementation SettingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [self initWithLabel:@"" editable:YES reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithLabel:(NSString *)label editable:(BOOL)editable reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.text = label;
        [WPStyleGuide configureTableViewCell:self];
        self.detailTextLabel.textColor = [UIColor murielTextSubtle];
        if (editable) {
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.selectionStyle = UITableViewCellSelectionStyleDefault;
        } else {
            self.accessoryType = UITableViewCellAccessoryNone;
            self.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    return self;
}

- (void)setTextValue:(NSString *)value
{
    self.detailTextLabel.text = value;
}

- (NSString *)textValue
{
    return self.detailTextLabel.text;
}

- (void)setShowHighlight:(BOOL)showHighlight
{
    if (self.accessoryType != UITableViewCellAccessoryDisclosureIndicator) {
        return;
    }

    if (showHighlight) {
        if (![self.accessoryView isKindOfClass:[QuickStartSpotlightView class]]) {
            QuickStartSpotlightView *spotlight = [QuickStartSpotlightView new];
            self.accessoryView = spotlight;
            [spotlight fadeInWithAnimation];
        }
    } else {
        self.accessoryView = nil;
    }
}

@end
