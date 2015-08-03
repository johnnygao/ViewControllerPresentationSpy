#import "ViewController.h"

#import "QCOMockAlertController.h"
#import "QCOMockAlertVerifier.h"
#import <XCTest/XCTest.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>


@interface ViewControllerTests_Internal : XCTestCase
@end

@implementation ViewControllerTests_Internal
{
    ViewController *sut;
}

- (void)setUp
{
    [super setUp];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    sut = [storyboard instantiateViewControllerWithIdentifier:@"main"];
    [sut view];
}

- (void)testShowAlert_TryingToGetStyleForNonexistentButton_ShouldThrowInternalInconsistency
{
    QCOMockAlertVerifier *alertVerifier = [[QCOMockAlertVerifier alloc] init];
    sut.alertControllerClass = [QCOMockAlertController class];
    [sut showAlert:nil];

    XCTAssertThrowsSpecificNamed(
            [alertVerifier styleForButtonWithTitle:@"NO SUCH BUTTON"],
            NSException,
            NSInternalInconsistencyException);
}

- (void)testShowAlert_TryingToGetStyleForNonexistentButton_ShouldThrowExceptionWithReason
{
    QCOMockAlertVerifier *alertVerifier = [[QCOMockAlertVerifier alloc] init];
    sut.alertControllerClass = [QCOMockAlertController class];
    [sut showAlert:nil];

    @try
    {
        [alertVerifier styleForButtonWithTitle:@"NO SUCH BUTTON"];
    }
    @catch (NSException *exception)
    {
        assertThat(exception.reason, is(@"Button not found"));
    }
}

- (void)testShowAlert_TryingToExecuteActionForNonexistentButton_ShouldThrowInternalInconsistency
{
    QCOMockAlertVerifier *alertVerifier = [[QCOMockAlertVerifier alloc] init];
    sut.alertControllerClass = [QCOMockAlertController class];

    [sut showAlert:nil];

    XCTAssertThrowsSpecificNamed(
            [alertVerifier executeActionForButtonWithTitle:@"NO SUCH BUTTON"],
            NSException,
            NSInternalInconsistencyException);
}

- (void)testShowAlert_TryingToExecuteActionForNonexistentButton_ShouldThrowExceptionWithReason
{
    QCOMockAlertVerifier *alertVerifier = [[QCOMockAlertVerifier alloc] init];
    sut.alertControllerClass = [QCOMockAlertController class];
    [sut showAlert:nil];

    @try
    {
        [alertVerifier executeActionForButtonWithTitle:@"NO SUCH BUTTON"];
    }
    @catch (NSException *exception)
    {
        assertThat(exception.reason, is(@"Button not found"));
    }
}

@end
