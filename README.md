## Zucko *(Little Yellow Fellow)*

[![Code Climate](https://codeclimate.com/github/Tonkec/Zucko.png)](https://codeclimate.com/github/Tonkec/Zucko)

###### Rapidly find your next bus drive from Samobor to Zagreb!

The [default page for the bus schedule in Samobor](http://www.samoborcek.hr/vozni-red/) is stuck in the past. 
Let's bring the future to it!

### Features

* Shows when did last bus leave
* Tells you when the next bus arrives
* Gives an option to easily switch destination from Zagreb to Samobor
* Informs wether the drive is direct or not
* Gives an option for filtering fast or slow routes

### Getting started

Import some data with

```
rake db:import:winter
```

Start the server with 

```
rake server
```

### Running tests

```
rake
```

### License

MIT
