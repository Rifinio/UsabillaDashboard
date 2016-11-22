#DashBilla
![alt tag](https://s16.postimg.org/sdmlihns5/Dashbilla_hand_phone_cover_youtube.png)

Dashbilla is my implementation of the Usabilla iOS Challenge. The idea here is to represent the data retrieved from the json file, and show them in beautiful Charts with meaninful and clear statistics.

## Process
So, reading the json file that contains user feedbacks, i went on to identify and only parse the needed parameters :

- Browser
- Platform
- Geo location
- Rating
- Labels

Once the parameters made sense, i had the idea of showing the data in a dashboard, using [Charts](https://github.com/danielgindi/Charts). And one very nice feature that i thought of, is to implement a usabilla feedback form, and since the API is only for clients :/
i created one myself.

## Screenshots
### Mainview : Dashboard
A collectionView that shows the different KPI in different chart types : PieChart, Horizontal Bar Chart and Vertical bar chart.

![alt tag](https://s16.postimg.org/annsxh3ad/dashboard_screenshots.png)

## ABUsabillaAPI
So, ABUsabillaAPI allows you to implement it in any ViewController and helps you highlight the UI elements that you as a developer want the user to be able to highlight and give feedback about.

![alt tag](https://s22.postimg.org/oso56qekx/feedback_Api_screenshots.png)

### Usage ?
* Implement ```<ABUsabillaFeedbackDelegate>``` in your viewController

* declare usabillaFeedback object as a property
```@property (nonatomic, strong) ABUsabillaFeedback *usabillaFeedback;```

* Then in your ```viewDidLoad`` add this code snippet :
```
_usabillaFeedback = [ABUsabillaFeedback new];
self.usabillaFeedback.delegate = self;
self.usabillaFeedback.classes = @[[UILabel class], [UIImageView class]];
```
Specify in ```.classes``` the UI elements classes that you want to let your users highlight and give feedback about.

* Add usabilla feedback button to you navigation bar
```
UIImage *image = [ABUsabillaFeedback usabillaBarButtonImage];
UIBarButtonItem *feedBackButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(feedbackClicked)];
self.navigationItem.rightBarButtonItem = feedBackButton;
```
* create a button action method : ```feedbackClicked``` that will call usabillaFeedBack object and highlight the UI Objects
```
- (void)feedbackClicked
{
    [self.usabillaFeedback highlightViews];
}
```
Done, now users can click and highlight the views they want to give thier opinion about and give you their feedback.
In this project i am using Firebase [Firebase](https://github.com/firebase/) real time database to save the feedbacks sent from the app.


## External Pods

* [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
* [Firebase](https://github.com/firebase/)

* [Masonry](https://github.com/SnapKit/Masonry)
* [ChameleonFramework](https://github.com/ViccAlexander/Chameleon)
* [Charts](https://github.com/danielgindi/Charts)

* [Kiwi](https://github.com/kiwi-bdd/Kiwi)
* [OCMock](https://github.com/erikdoe/ocmock)

## What i would add, given more time ?
* Add a detail view that shows more info about a selected KPI 
* I would finalize the ABFeedbackAPI
* Add more ways options in ABFeedbackAPI, like including a screenshot, and allow user to draw on it, like Snapshat.
* Increase UT coverage.
