FEEDBACK

'glowing'...(but failed cultural)

Test Review
Solving requirements  No rating disabled
0-10* YES - Once an item is selected and the appropriate amount of money is inserted, the vending machine should return the correct product * YES - It should also return change if too much money is provided, or ask for more money if insufficient funds have been inserted * ISH - The machine should take an initial load of products and change. The change will be of denominations 1p, 2p, 5p, 10p, 20p, 50p, £1, £2 - it takes numbers not £ or p values it converts, it doesn't try to convert backwards from numbers to £ and p for display either, so we get a message like "2 x 100p" for change or "250p" for a price * YES - There should be a way of reloading either products or change at a later point * YES - The machine should keep track of the products and change that it contains * YES - Be written in ruby * YES - Include a readme - it has some nice reflections on design choices too which is good to see Meets all the requirements, docking a point for the change thing. 9 No rating disabled
Good quality tests  No rating disabled
0-3The specs are ok. There's decent coverage of the models, because they are pretty simple data objects. We don't really have great coverage of the controller or view. I'd have liked to see an integration style test for a complete user journey of starting a vending machine, picking an item, inserting coins and getting my item and change. We don't really have that which is a shame. It'd also be nice to see a bunch of edgecase tests for not inserting enough coins, or the machine not having enough change, etc. Some of the tests are a bit weird in that they test things like a ruby initializer returns the correct class or that a variable set up in a `let` is of the correct type. 1  No rating disabled
Follows OOP best practices with good class design and separation  No rating disabled
0-4MVC is a standard OO pattern and it's well applied here I think. I'm not 100% clear that the division of labour between the `VendingMachine` and the `MachineController` is particularly clear though. In fact, I think we might be better off saying that the `MachineController` _is_ the `VendingMachine`. I'd usually expect a controller to translate between the user input from the view and marshall that down into the relevant business logic in the lower layer (models or services or whatever). In Gus' solution most of the business logic lives in the `MachineController` and the `VendingMachine` doesn't really do anything at all - it just serves to translate the initial coin and item load into the `Coin.all` and `Item.all` "databases". The `View` and other models are pretty much exactly what I'd expect to see though. One test I like to apply is to think how much of the code we could reuse if we wanted to change the UI (e.g. add a web interface to a cli app, or a cli interface to a web app). I'm not 100% sure we could just swap out the `View` for a `WebView`, but I don't think it'd be too bad. It's nice that the change calculation has been identified as a separate concern and not left lurking in the controller. Living on the `Coin` is a reasonable place for it, but a separate service might make sense. 3  No rating disabled
Correct change calculation  No rating disabled
0-2It follows the standard algorithm and counts down releasing coins until we've given the user enough. There are edgecases here (what if we don't have enough money at all, what if we do, but not in combinations that can be used to make up the exact change) that aren't explicitly handled, but the basic algorithm is correct. 1 No rating disabled
Writing using Ruby best practices No rating disabled
0-2The models take a hash of attributes, and it might be nicer to use keyword arguments instead as there are only a couple of attributes in most models. Using `@@all` class variables to represent the "repository" of all the coins or items is a bit weird, but understandable. The `VendingMachiine` defines instance variables for the coins and items it uses but never exposes them, preferring to expose the `.all` method on `Coin` and `Item` instead. I suspect this is a refactor that hasn't been completed, rather then a ruby idiom mistake. There's some inconsistency between use of instance variables vs. local variables (e.g. `@money_inserted` in `wait_for_coin` vs. `insert_change` in `select`). None of this is incredibly major though. 1  No rating disabled
Not over engineering  No rating disabled
0-2Using MVC is an interesting approach. It's a good way to separate the concerns while giving us an obvious structure to hang things off. It could be one step down an architecture rabbit hole, but Gus has stopped here so this isn't over-engineered. 2 No rating disabled
Not spending way too long on it No rating disabled
0-1There's a reference to "my time is up" in the commits and it doesn't look like this took an excessive amount of time. 1  No rating disabled
Good names of classes and methods No rating disabled
0-1All pretty good. There is a slightly weird mix in naming things in the controller between using domain language like `turn_on` or `wait_for_coin` and using framework language like `route_action`. Ditto with `MachineController` vs. `View`. I'd prefer to see the domain and framework more clearly separated, but this isn't major. 1  No rating disabled





To run the programme,

```rb ruby run.rb ```

The most challenging part of this project was the architectural layout. I opted for MVC, clearly drawing on a Rails setup.

One potential weakness of the implemented design concerns the input choices. Currently, once an item has been selected, a user is locked into providing the correct change. A real vending machine would allow one to change choice up until the moment of vending. But this mostly stems from the CLI input being all numbers, not coins and buttons.

I use @@all class variables to mimic a database. This allows us to keep track of the items and change. It serves us better than a constant which would be inconvenient to empty (i.e. reload).

The vending machine expects the user to enter the number he wants.
