
#import "GLViewController.h"
#import "GLView.h"

@implementation GLViewController
{
  GLView* m_view;
}

- (void)dealloc
{
  [m_view release];
  [super dealloc];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  m_view = [[GLView alloc] initWithFrame:self.view.frame];
  [self.view addSubview:m_view];
}

@end
