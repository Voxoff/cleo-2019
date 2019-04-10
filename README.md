To run the programme,

```rb ruby run.rb ```

The most challenging part of this project was the architectural layout. I opted for MVC, clearly drawing on a Rails setup.

One potential weakness of the implemented design concerns the input choices. Currently, once an item has been selected, a user is locked into providing the correct change. A real vending machine would allow one to change choice up until the moment of vending. But this mostly stems from the CLI input being all numbers, not coins and buttons.

I use @@all class variables to mimic a database. This allows us to keep track of the items and change. It serves us better than a constant which would be inconvenient to empty (i.e. reload).

The vending machine expects the user to enter the number he wants.
