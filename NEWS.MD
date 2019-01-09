# harrypotter 2.1.0

* `house` argument is officially *deprecated*. New argument `option` should be used instead. Functionality is absolutely equal. This change adds consistency with other similar packages and opens the possibility to add more palette options, outside the Hogwarts Houses. 

* Fixed major bug regarding `_d()` functions. Now they work properly.

# harrypotter 2.0.0

* Colour palettes from the actual movies removed. Now the only options available are the ones from Hogwarts' houses. Nobody used them and were actually terrible.
* `movie` argument works no longer. It is replaced by `house`.
* New functions for discrete scales. Example:`scale_fill_hp_d()` as shortcut for `scale_fill_hp(discrete = TRUE)`. Same with `colour` instead of `fill`.