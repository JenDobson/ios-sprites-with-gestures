# ios-sprites-with-gestures

To begin working with this repository in Xcode:

1. Check out the repository.  (An easy option:  Go to the "Source Control" Menu in XCode, then "Check out..." and enter the URL for this repository.)
2. Open the JADSKSpriteKitExtensionsDevApp (the "DevApp") project.  When you open the DevApp project, you will see that it contains the JADSpriteKitExtensions library as a reference.
3. Before running the DevApp, you will need to build the library.  Select "JADSpriteKitExtensions" (i.e. NOT the DevApp)from the configurations bar.  Then press the run triangle to build the library.  If the build is successful, the library file "libJADSpriteKitExtensions.a" should be created and appear black in the project.
4. In the DevApp project, click on the DevApp target and go to "Build Phases".  Under "Link Binary With Libraries" select the "+" and add the library (lib*.a) file that was just generated.  
5. To run the DevApp, select the JADSKSpriteKitExtensionsDevApp in the configuration bar and then run the project.


Working with the static library:
