#include <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

// AppDelegate interface and implementation
@interface AppDelegate : NSObject <NSApplicationDelegate>
@property(strong) NSWindowController *window;
@end

@implementation AppDelegate
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
  NSTextField *textField =
      [[NSTextField alloc] initWithFrame:NSMakeRect(0, 0, 200, 24)];
  [textField setStringValue:@"Hello World!"];
  [textField setBordered:NO];
  [textField setDrawsBackground:NO];
  [textField setEditable:NO];
  [textField setSelectable:NO];

  NSWindow *w = [[NSWindow alloc]
      initWithContentRect:NSMakeRect(0, 0, 300, 300)
                styleMask:(NSWindowStyleMaskTitled | NSWindowStyleMaskClosable |
                           NSWindowStyleMaskResizable |
                           NSWindowStyleMaskMiniaturizable)
                  backing:NSBackingStoreBuffered
                    defer:NO];
  [w setContentView:textField];

  self.window = [[NSWindowController alloc] initWithWindow:w];
  [self.window showWindow:self];

  [NSApp activateIgnoringOtherApps:YES];
}

@end

// Main function (runs the application)
int main(int argc, const char *argv[]) {
  AppDelegate *delegate = [[AppDelegate alloc] init];
  [NSApplication sharedApplication].delegate = delegate;
  return NSApplicationMain(argc, argv);
}
