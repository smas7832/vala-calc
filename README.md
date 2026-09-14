# vala-calc

Little experiment to of building a below-basic calculator in vala-lang and GTK4

---

## Build
- Dependency: GTK4

using Meson:

``` SHELL
meson compile -C build //output: /build/main
```


using Valac:
``` SHEll 
valac --pkg gtk4 main.vala //output: main
```
