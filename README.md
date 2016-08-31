# DLSharedBundleResources

Do you ever build an app with multiple targets and you ever forget to add a resource to all of them?
This is a big problem for me, because I'm working in a huge developer group and I don't want that my files are missing in another developer project.
So...
This script will add reference to the missing file in a target. Only one thing, you have to specify a "complete" target to start the comparison.

# Instructions

To run the script you have to install `Xcodeproj` and `colorize` gems

    sudo gem install xcodeproj
    sudo gem install colorize

Then open the `rb` file and set the `blacklist` array, if you want.
Now launch the ruby script and follow the steps
