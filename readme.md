# CSS Inliner

As we learn more and more about how to increase the speed of our pages, front-end developers are asked to jump through more and more hoops. The article, [Why Inlining Everything Is NOT The Answer](http://calendar.perfplanet.com/2011/why-inlining-everything-is-not-the-answer/), recommends the rule that files above 4KB should be linked and not inlined. Don't want to deal with that yourself? This project helps.

Small files are output as inline CSS. Big files are output as `<link>` tags.

``` coldfusion
<cfscript>
	cssinliner.showCSS('css/small.css');
	cssinliner.showCSS('css/big.css');
	cssinliner.showCSS([
		'css/small.css',
		'css/big.css'
	]);
</cfscript>
```