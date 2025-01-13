# Initial design sketch

https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=EmberTripViewer.drawio#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1kRO3MupVB5u83_ZA1mG_OnLR8cYoii9I%26export%3Ddownload

# Development Notes

## API Layer

- This was the layer I started from so as to get some data available for testing and getting quick feedback
- JSON parsing was surprisingly annoying for a framework that is FE focussed. There are JSON parsing libraries that I would prefer to use that would allow better handling of format exceptions and null/empty checks rather than containing a lot of custom code within the models for parsing. However I thought for the demo it would (hopefully) be quicker and simpler to just generate the models from the JSON API examples using an online generator.

## Repository

- Improvements in this area would definitely be to implement a basic cache. I'd had a quick look and found a basic one: https://pub.dev/packages/dart_basic_cache
- I suppose there is an argument for doing more of the transformation work on the models in this layer. I am not super familiar with the MVVM architecture I was attempting to follow, but I decided that the repository was better left to fetching the raw model and leaving the transformations to the viewmodel layer. Most of the transformation logic has been extracted into discrete classes anyways, so they would still be reuseable between multiple viewmodels if that were required for some reason.

## ViewModel

- There is one TripViewModel for the whole screen, which initially I wasn't totally sure about but after I warmed to the pattern of having *Data and *Widget classes then it felt right. That pattern is something I kind of made up; it's not something I found anywhere. So perhaps it's an odd one, but I found it very useful for compositing the data for the view into objects that would then be as simple as possible for the view to extract the data from.
- As mentioned, much of the actual logic is pulled out into the TripDataBuilder and the NodeScheduleExtractor. They both have methods which are essentially pure functions so they can be mocked and rationalised simply.

## View

- The development in this part is what took a lot of my time, given I haven't done any mobile or front end development with anything like this sort of framework. I encountered several rendering errors and frustrations through the project which took up most of my time. They were the sort of things that once you have solved them and understood it then you are unliklely going to do again. One was around the ListView being inside a Column and being unable to size its viewport. I solved that with an Exapanded fairly quickly, but then as I developed the ListView further with some intermediary objects then I was going in circles for a long time.
- Another one that took a lot of time was getting the RouteDisplayWidget to maintain its reference to the map qidget so it wouldn't be rebuilt every time the view was toggled. I ended up redoing a fair amount of the provider approach to use the `select` method so that rebuilds would be more targetted. In the end I finally managed to get the right phrase in google and came across the Stack  which worked perfectly.
- Working with the map was actually not so bad - though I did end up with a bit of a strange approach to initialising it, however it does look from the examples the developers of it gave that that is how they do it. I had hoped to add functionality to click on the nodes and display a pop up at the bottom of the view to give mor information on the stop (which could simply re-use the widgets from the list view) but it was going to be too much in the end.
- Language localisation config and accessibility (beyond what Flutter already gives) have not been looked at for the purposes of time
- Theming and generally prettyfying are other things that I decided not to go into given the scope limit

## Testing

- Only the HTTP class has any actual tests around it, however some other test files have been created with comments to explain what I would perhaps be looking for. I was keen to try a couple of widget tests too, but given the time then again I left those

## Future Work

- If I were to carry on with this project with the aim of putting it in front of customers then I would likely continue on the route of the design I made at the start that is linked at the top. I'd want to dig into more visual indicators particularly around the bookable stops and whether they are a guaranteed stop from someone elses booking or still potentially being skipped as this is more unique to Ember and customers are less likely to be familiar with it.