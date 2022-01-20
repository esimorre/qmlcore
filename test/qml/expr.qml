// RUN: %build
// RUN: grep "this.a = (2+(((2\*2)\%3)/4))" %out/qml.expr.js
// RUN: grep "this.b = ((~1)-(~2))" %out/qml.expr.js
// RUN: grep "this.c = ((2\*\*2)+2)" %out/qml.expr.js
// RUN: grep "this.d = ((+3)+(-2))" %out/qml.expr.js
// RUN: grep "this.e = (~(~0))" %out/qml.expr.js
// RUN: grep "this.f = ((1+1)<<(2+1))" %out/qml.expr.js
// RUN: grep "this.g = (1+(2\*(1+1)))" %out/qml.expr.js
// RUN: grep "this.h = \[(1\*\*2),\$this.a,\$this.b\]" %out/qml.expr.js

Object {
	property int a: 2 + 2 * 2 % 3 / 4;
	property int b: ~1 - ~2;
	property int c: 2 ** 2 + 2;
	property int d: + 3 + - 2;
	property int e: ~~0;
	property int f: 1 + 1 << 2 + 1;
	property int g: 1 + 2 * (1 + 1);
	property array h: [1 ** 2, a, b]
}
