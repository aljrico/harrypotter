## Update

* Ships the roxygen-generated NAMESPACE (previously excluded from the build by mistake).
* Calls `discrete_scale()` with a named `palette`, ahead of ggplot2 removing `scale_name`.
* Drops the unused gridExtra dependency.

## R CMD check results

0 errors | 0 warnings | 0 notes
