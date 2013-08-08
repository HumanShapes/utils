# Cabin utils

A set of AngularJS components that we use across projects.

## Directives

### `cb-at2x`

A simple directive for including retina image assets. Include `cabin.at2x` as a
dependency and add a `cb-at2x` attribute to any `img` element that has an
associated high-DPI version. If the `cb-at2x` attribute has no value, the
directive will attempt to guess the retina URL by inserting `@2x` immediately
before the `src`'s extension (e.g., `logo.png` becomes `logo@2x.png`). Add a
value to `cb-at2x` to set the retina URL explicitly.

The directive allows the non-retina asset to load normally, then attempts to
load the retina URL (using the `preload` service). Once the retina asset loads
successfully, it is swapped in.


## Services

### `isRetina`

Test whether the current screen is capable of high DPI. Include
`cabin.isRetina` as a dependency, inject `isRetina`, and then simply call the
service object (`isRetina()`), which returns a boolean value.


### `preload`

Load an asset (using a JavaScript `Image` object), and return a promise that
will be resolved once the asset loads or rejected on any errors. Include
`cabin.preload` as a dependency, then call the service object:

    preload('logo.png').then(function (src) { console.log(src, 'loaded'); });
