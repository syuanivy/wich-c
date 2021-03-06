package wich.semantics;/*
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
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
IN THE
SOFTWARE.
*/

import org.antlr.symtab.Symbol;
import org.antlr.symtab.TypedSymbol;
import wich.errors.WichErrorHandler;
import wich.parser.WichParser;
import wich.semantics.symbols.WVariableSymbol;

import static wich.errors.ErrorType.SYMBOL_NOT_FOUND;


/*Assign types to variable initializations wherever possible, keep track of whether all variables have been assigned types*/
public class AssignTypes extends MaintainScopeListener{
	public int numOfVars = 0;
	protected int countOfAssigned = 0;

	public AssignTypes(WichErrorHandler errorHandler, int numOfVars) {
		super(errorHandler);
		this.numOfVars = numOfVars;
	}

	@Override
	public void exitVardef(WichParser.VardefContext ctx) {
		Symbol var = currentScope.resolve(ctx.ID().getText());

		if (var == null || !(var instanceof WVariableSymbol)) {
			error(ctx.ID().getSymbol(), SYMBOL_NOT_FOUND, ctx.ID().getText());
		}
		else if (((TypedSymbol) var).getType() == null) {
			if(ctx.expr().exprType != null) {
				((TypedSymbol) var).setType(ctx.expr().exprType);
				countOfAssigned++;
			}
		}
	}

	public boolean isAssignFinished() { return countOfAssigned == numOfVars; }

	public int getCountOfAssigned() { return countOfAssigned; }
}
