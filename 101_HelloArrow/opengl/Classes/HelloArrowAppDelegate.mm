#import "HelloArrowAppDelegate.h"
#import "GLViewController.h"


@implementation HelloArrowAppDelegate

- (void) applicationDidFinishLaunching: (UIApplication*) application
{
  CGRect screenBounds = [[UIScreen mainScreen] bounds];

  m_window = [[UIWindow alloc] initWithFrame: screenBounds];
  GLViewController *rootVwCtrl = [[GLViewController alloc] initWithNibName:nil bundle:nil];
  [m_window setRootViewController:rootVwCtrl];
  [rootVwCtrl release];
  [m_window makeKeyAndVisible];
}

- (void) dealloc
{
  [m_window release];
  [super dealloc];
}

@end
