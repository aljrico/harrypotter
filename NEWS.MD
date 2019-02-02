# harrypotter 2.1.1

* Now 'option' is the first parameter on `scale_fill_hp()` and `scale_colour_hp()`. As it is the most common specified parameter, this change makes its use more natural and easy.

* New `gryffindor2` palette available.

# harrypotter 2.1.0

* `house` argument is officially *deprecated*. New argument `option` should be used instead. Functionality is absolutely equal. This change adds consistency with other similar packages and opens the possibility to add more palette options, outside the Hogwarts Houses. 
* Fixed major bug regarding `_d()` functions. Now they work properly.
* Removed useless duplicated function called `hpMap`. 
* **New set of palettes relseased!**
* New function `hp_palettes()` that outputs all palettes' name. Very handy if you don't remember them.

# harrypotter 2.0.0

* Colour palettes from the actual movies removed. Now the only options available are the ones from Hogwarts' houses. Nobody used them and were actually terrible.
* `movie` argument works no longer. It is replaced by `house`.
* New functions for discrete scales. Example:`scale_fill_hp_d()` as shortcut for `scale_fill_hp(discrete = TRUE)`. Same with `colour` instead of `fill`.