/*
The MIT License (MIT)

Copyright (c) 2015 Terence Parr, Hanzhou Shi, Shuai Yuan, Yuanyuan Zhang

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
package wich.codegen.model.expr;


import org.antlr.symtab.Type;
import wich.codegen.model.FloatType;
import wich.codegen.model.ModelElement;
import wich.semantics.SymbolTable;
import wich.semantics.symbols.WVariableSymbol;

public class VectorIndexExpr extends Expr {
	public final String varName;
	public final WVariableSymbol symbol;
	@ModelElement public Expr expr;

	public VectorIndexExpr(String object, WVariableSymbol v, Expr indexExpr, String tempVar) {
		this.varName = object;
		this.symbol = v;
		this.expr = indexExpr;
		this.type = new FloatType();
		this.varRef = tempVar;
	}

	@Override
	public Type getType() {
		return SymbolTable._float;
	}
}
