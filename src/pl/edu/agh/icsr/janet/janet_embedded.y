/* -*-Java-*- */

/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is the Java Language Extensions (JANET) package.
 *
 * The Initial Developer of the Original Code is Dawid Kurzyniec.
 * Portions created by the Initial Developer are Copyright (C) 2001
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s): Dawid Kurzyniec <dawidk@icsr.agh.edu.pl>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

/*
 * Janet grammar for embedded Java expressions and statements.
 */

%{
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is the Java Language Extensions (JANET) package.
 *
 * The Initial Developer of the Original Code is Dawid Kurzyniec.
 * Portions created by the Initial Developer are Copyright (C) 2001
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s): Dawid Kurzyniec <dawidk@icsr.agh.edu.pl>
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

/* Important information:
 * THIS FILE HAS BEEN AUTOMATICALLY GENERATED by the public domain JB tool
 * (see README.html for details).
 */

import pl.edu.agh.icsr.janet.yytree.*;
import pl.edu.agh.icsr.janet.reflect.*;
import pl.edu.agh.icsr.janet.natives.*;
//import pl.edu.agh.icsr.janet.ParseException;
import java.lang.reflect.Modifier; // for Modifiers productions
%}

%union { 
  YYCompilationUnit; 
  YYPackage;
  YYImportDeclarations;
  YYName;
  YYNameNode;
  YYType;
  YYModifier;
  YYModifierList;
  YYDims;
  YYExpression;
  YYThis;
  //  YYVariableExpression;
  YYExpressionList;
  YYMethodInvocationExpression;
  YYAssignmentExpression;
  YYStatement;
  YYNativeCode;
  YYVariableDeclarator;
  YYVariableDeclaratorList;
  YYNode;
  YYCatchClause;
  YYFinally;
//YYCatchClauseList;
  String;
  Character;
  BinaryOperator;
  
  default Integer
}

%token LEX_ERROR 
%token EPSILON

%token INTEGER_LITERAL
%token LONG_LITERAL
%token FLOAT_LITERAL
%token DOUBLE_LITERAL
%token BOOLEAN_LITERAL
%token<String> STRING_LITERAL
%token<Character> CHARACTER_LITERAL
%token NULL_LITERAL

%token<String> IDENTIFIER

%token ABSTRACT ANDAND
%token BOOLEAN BREAK BYTE
%token CASE CATCH CHAR CLASS CONST CONTINUE
%token DEFAULT DO DOUBLE
%token ELSE EQADD EQAND EQDIV EQEQ EQLOGRSHIFT EQLSHIFT EQMOD
%token EQMUL EQOR EQRSHIFT EQSUB EQXOR EXTENDS
%token FINAL FINALLY FLOAT FOR
%token GE GOTO
%token IF IMPLEMENTS IMPORT INSTANCEOF INT INTERFACE
%token LE LOGRSHIFT LONG LSHIFT
%token MINUSMINUS
%token NATIVE NE NEW
%token OROR
%token PACKAGE PLUSPLUS PRIVATE PROTECTED PUBLIC
%token RETURN RSHIFT
%token SHORT STATIC SUPER SWITCH SYNCHRONIZED STRICTFP
%token THIS THROW THROWS TRANSIENT TRY
%token VOID VOLATILE
%token WHILE

%token NH_EXPRESSION NH_STRING NH_UNICODE_STRING NH_ARRAY_PTR

%token <YYNativeCode> NATIVE_STATEMENTS NATIVE_STATEMENTS_WITH_JAVA_TAIL NATIVE_BLOCK
                      NATIVE_EXPRESSION NATIVE_STRING NATIVE_UNICODE_STRING

%type<YYName> Name
%type<YYNameNode> SimpleName

%type<YYModifierList> Modifiers
%type<YYModifier> Modifier

%type<YYType> Type 
              ReferenceType ClassType ClassOrInterfaceType
              ArrayType
              PrimitiveType

%type<YYDims> Dims

%type<YYExpression> MethodInvocation PostfixExpression CastExpression
                    RelationalExpression EqualityExpression ConditionalAndExpression ConditionalOrExpression
                    Primary PrimaryNoNewArray ArrayCreationExpression BracedExpression
                    ClassInstanceCreationExpression Expression MethodInvocation DimExpr
                    PostIncrementExpression PostDecrementExpression UnaryExpression
                    PreIncrementExpression PreDecrementExpression UnaryExpressionNotPlusMinus
                    MultiplicativeExpression AdditiveExpression ShiftExpression
                    AndExpression ExclusiveOrExpression InclusiveOrExpression ConditionalAndExpression
                    ConditionalOrExpression ConditionalExpression AssignmentExpression
                    VariableInitializer
                    NativeString NativeExpression
                    Literal
%type<YYExpression> LeftHandSide FieldAccess ArrayAccess 

%type<YYThis> Super

%type<YYMethodInvocationExpression> MethodInvocationHeader

    //%type<YYNativeCode> NativeExpressionBody NativeStringBody NativeUnicodeStringBody EmbeddedNativeStatementBody

%type<YYVariableDeclarator> VariableDeclarator VariableDeclaratorId FormalParameter
%type<YYVariableDeclaratorList> VariableDeclarators LocalVariableDeclaration LocalVariableDeclarationStatement

%type<YYStatement> Statement TryStatement EnclosedTryStatement ThrowStatement SynchronizedStatement 
                   EnclosedStatements EnclosedSynchronizedStatement
                   Block JavaBlock BlockStatements BlockStatements_opt BlockStatement NonBlockStatements NonBlockStatement
                   EmptyStatement
                   EnclosedStatement ReturnStatement

%type<YYStatement> EmbeddedNativeBlock EnclosingNativeBlock EmbeddedNativeStatements ExpressionStatement

%type<YYCatchClause> CatchClause EnclosedCatchClause
%type<YYStatement> Catches EnclosedCatches
%type<YYFinally> Finally EnclosedFinally

%type<YYAssignmentExpression> Assignment 
%type<BinaryOperator> AssignmentOperator

%type<YYExpressionList> Arguments ArgumentList DimExprs

%type<YYNode> Goal

%start Outer

%%

Outer             /* never reached */
    : Goal       {}
    | Goal error {}
    ;

Goal
    : NonBlockStatements { $$ = $1; yyclearin(); yyreturn(YYRET_STATEMENTS); }
    | EnclosedStatements { $$ = $1; yyclearin(); yyreturn(YYRET_ENCLOSED_STATEMENTS); }
    | Expression         { $$ = $1; yyclearin(); yyreturn(YYRET_EXPRESSION); }
    | /* empty */        { $$ = null; yyclearin(); yyreturn(YYRET_EPSILON); }
    ;


NonBlockStatements  /* embedded native not allowed in NonBlockStatement */
    : NonBlockStatement                    { $$ = new YYStatement(cxt, false).add($1); }
    | NonBlockStatements NonBlockStatement { $$ = $1.add($2); }
    ;

/* non-block statement may be everything but embedded native statement ( `...` ) */
NonBlockStatement
    : LocalVariableDeclarationStatement { $$ = $1; }
    | Statement
    ;

EnclosedStatements
    : EnclosedStatement                    { $$ = $1; }
    | NonBlockStatements EnclosedStatement { $$ = $1.add($2); }
    ;

EnclosedStatement
    : EnclosedSynchronizedStatement
    | EnclosedTryStatement
    ;

// 19.3: Lexical Structure

Literal
    : INTEGER_LITERAL   { $$ = new YYIntegerLiteral(cxt, yytext()); }
    | LONG_LITERAL      { $$ = new YYLongLiteral(cxt, yytext()); }
    | FLOAT_LITERAL     { $$ = new YYFloatLiteral(cxt, yytext()); }
    | DOUBLE_LITERAL    { $$ = new YYDoubleLiteral(cxt, yytext()); }
    | BOOLEAN_LITERAL   { $$ = new YYBooleanLiteral(cxt, yytext()); }
    | STRING_LITERAL    { $$ = new YYStringLiteral(cxt, $1); }
    | CHARACTER_LITERAL { $$ = new YYCharacterLiteral(cxt, $1); }
    | NULL_LITERAL      { $$ = new YYNullLiteral(cxt); }
    ;

// 19.4: Types, Values and Variables

Type
    : PrimitiveType
    | ReferenceType
    //    | error { $$ = new YYType(cxt, (YYName)null); }
    ;

PrimitiveType
    : BYTE  { $$ = new YYType(cxt, byte.class); }
    | SHORT { $$ = new YYType(cxt, short.class); }
    | INT   { $$ = new YYType(cxt, int.class); }
    | LONG  { $$ = new YYType(cxt, long.class); }
    | CHAR  { $$ = new YYType(cxt, char.class); }
    | FLOAT { $$ = new YYType(cxt, float.class); }
    | DOUBLE { $$ = new YYType(cxt, double.class); }
    | BOOLEAN { $$ = new YYType(cxt, boolean.class); }
    ;

ReferenceType
    : ClassOrInterfaceType
    | ArrayType
    ;

ClassOrInterfaceType
    : Name { $$ = $1.reclassifyAsType(); }
    ;

ClassType
    : ClassOrInterfaceType
    ;

// InterfaceType not required

ArrayType
    : PrimitiveType Dims { $$ = $1.addDims(cxt, $2.dims()); }
    | Name Dims          { $$ = $1.reclassifyAsType().addDims(cxt, $2.dims()); }
    ;

// 19.5: Names

Name
    : SimpleName          { $$ = new YYName(cxt).add($1); }
    | Name '.' SimpleName { $$ = $1.add($3); }
    ;

SimpleName
    : IDENTIFIER { $$ = new YYNameNode(cxt, $1); }
    ;

// 19.7: Productions Used Only in the LALR(1) Grammar

Modifiers
    : Modifier           { $$ = new YYModifierList(cxt).add($1); }
    | Modifiers Modifier { $$ = $1.add($2); }
    ;

Modifier
    : FINAL        { $$ = new YYModifier(cxt, Modifier.FINAL); }
    | TRANSIENT    { $$ = new YYModifier(cxt, Modifier.PUBLIC); }
    | VOLATILE     { $$ = new YYModifier(cxt, Modifier.VOLATILE); }
    ;

// Variable and Formal Parameter Declarations

VariableDeclarators
    : VariableDeclarator                         { $$ = new YYVariableDeclaratorList(cxt).add($1); }
    | VariableDeclarators ',' VariableDeclarator { $$ = $1.add($3); }
    ;

VariableDeclarator
    : VariableDeclaratorId
    | VariableDeclaratorId '=' VariableInitializer { $$ = $1.setInitializer($3).expand(cxt); }
    ;

VariableDeclaratorId
    : IDENTIFIER      { $$ = new YYVariableDeclarator(cxt, $1, false); }
    | IDENTIFIER Dims { $$ = new YYVariableDeclarator(cxt, $1, false).addDims($2.dims()); }
    ;

VariableInitializer
    : Expression
    | ArrayInitializer { notSupported(cxt, "array initializers"); }
    ;

FormalParameter
    : Modifiers Type VariableDeclaratorId /* 1.1 */ { $$ = $3.setModifiers($1).setType($2).expand(cxt); }
    |           Type VariableDeclaratorId           { $$ = $2.setType($1).expand(cxt); }
    ;

// 19.10: Arrays // not supported

ArrayInitializer
    : '{' VariableInitializers ',' '}'
    | '{' VariableInitializers     '}'
    | '{'                      ',' '}'
    | '{'                          '}'
    | '{' error '}'
    ;

VariableInitializers
    : VariableInitializer                          { notSupported(cxt, "array initializers"); }
    | VariableInitializers ',' VariableInitializer { notSupported(cxt, "array initializers"); }
    ;

// 19.11: Blocks and Statements

JavaBlock
    : '{'                      { pushScope(new YYStatement(cxt, false, true)); }
          BlockStatements_opt 
      '}'                      { $$ = ((YYStatement)popScope()).expand(cxt); }
    ;

BlockStatements_opt
    : /* empty */     { $$ = peekScope(); }
    | BlockStatements
//    | '{' error '}' {}
    ;

/**
 * This is native block within ` ` (e.g. `{ ... }`)
 */
EmbeddedNativeBlock
    : EnclosingNativeBlock '`' { $$ = $1.expand(cxt); }
    ;

/** 
 * If the native block is not followed by '`', it is Enclosing Native Block and it terminates 
 * parsing of this embedded Java (see Enclosed***Statement productions)
 */
EnclosingNativeBlock
    : '`'              { lexmode = Lexer.NATIVE_BLOCK; } 
          NATIVE_BLOCK { lexmode = Lexer.JAVA_TOKEN; $$ = new YYEnclosedNativeStatements(cxt, $3); }
    ;

Block
    : JavaBlock
    | EmbeddedNativeBlock
    ;

BlockStatements
    : BlockStatement                 { $$ = ((YYStatement)peekScope()).add($1); }
    | BlockStatements BlockStatement { $$ = $1.add($2); }
    ;

BlockStatement
    : NonBlockStatement
    | EmbeddedNativeStatements
    ;

/**
 * Native statements formally must appear within ` `, but sometimes parser incorporates the second 
 * back-quote sign (and perhaps some Java statements following it) into
 * NATIVE_STATEMENTS_WITH_JAVA_TAIL token where they denote embedded Java.
 */
EmbeddedNativeStatements
    : '`' NativeStatementsBegin NATIVE_STATEMENTS NativeCodeEnd '`' { $$ = new YYEnclosedNativeStatements(cxt, $3); }
    | '`' NativeStatementsBegin NATIVE_STATEMENTS_WITH_JAVA_TAIL NativeCodeEnd { $$ = new YYEnclosedNativeStatements(cxt, $3); }
    ;

NativeStatementsBegin : { lexmode = Lexer.NATIVE_STATEMENTS; };
NativeCodeEnd :         { lexmode = Lexer.JAVA_TOKEN; };

LocalVariableDeclarationStatement
    : LocalVariableDeclaration ';' { $$ = $1.expand(cxt); addVariables($1); }
    ;

LocalVariableDeclaration
    : Modifiers Type VariableDeclarators /* 1.1 */ { $$ = $3.setModifiers($1).setType($2)
                                                            .setDeclarationType(YYVariableDeclarator.LOCAL_VARIABLE); }
    |           Type VariableDeclarators           { $$ = $2.setType($1)
                                                            .setDeclarationType(YYVariableDeclarator.LOCAL_VARIABLE); }
    ;

Statement
    : JavaBlock
    | EmptyStatement
    | ExpressionStatement   { $$ = $1; }
    | SynchronizedStatement 
    | ThrowStatement
    | TryStatement
    | ReturnStatement
    ;

EmptyStatement
    : ';' { $$ = new YYStatement(cxt); }
    ;

ExpressionStatement
    : Expression ';' { $$ = new YYExpressionStatement(cxt, $1); }

ThrowStatement
    : THROW Expression ';' { $$ = new YYThrowStatement(cxt, $2); }
    ;

SynchronizedStatement
    : SYNCHRONIZED BracedExpression Block { $$ = new YYSynchronizedStatement(cxt, $2, $3); }
    ;

EnclosedSynchronizedStatement
    : SYNCHRONIZED BracedExpression EnclosingNativeBlock { $$ = new YYSynchronizedStatement(cxt, $2, $3); }
    ;

TryStatement
    : TRY Block Catches         { $$ = new YYTryStatement(cxt, $2).addCatches($3);                }
    | TRY Block Catches Finally { $$ = new YYTryStatement(cxt, $2).addCatches($3).addFinally($4); }
    | TRY Block         Finally { $$ = new YYTryStatement(cxt, $2)               .addFinally($3); }
    ;

EnclosedTryStatement
    : TRY Block EnclosedCatches                 { $$ = new YYTryStatement(cxt, $2).addCatches($3);                }
    | TRY Block Catches         EnclosedFinally { $$ = new YYTryStatement(cxt, $2).addCatches($3).addFinally($4); }
    | TRY Block                 EnclosedFinally { $$ = new YYTryStatement(cxt, $2)               .addFinally($3); }
    ;

Catches
    : CatchClause         { $$ = new YYStatement(cxt, false).add($1); }
    | Catches CatchClause { $$ = $1.add($2); }
    ;

CatchClause
    : CatchClauseHead Block { $$ = ((YYCatchClause)popScope()).setBody($2).expand(cxt); }
    ;

EnclosedCatches
    : EnclosedCatchClause         { $$ = new YYStatement(cxt, false).add($1); }
    | Catches EnclosedCatchClause { $$ = $1.add($2); }
    ;

EnclosedCatchClause
    : CatchClauseHead EnclosingNativeBlock { $$ = ((YYCatchClause)popScope()).setBody($2).expand(cxt); }
    ;

CatchClauseHead
    : CATCH '('                 { pushScope(new YYCatchClause(cxt)); } 
                FormalParameter { $4.setDeclarationType(YYVariableDeclarator.CATCH_PARAMETER);
                                  addVariable($4); ((YYCatchClause)peekScope()).setFormalParameter($4); }
            ')'
    ;

Finally
    : FINALLY Block { $$ = new YYFinally(cxt, $2); }
    ;

EnclosedFinally
    : FINALLY EnclosingNativeBlock { $$ = new YYFinally(cxt, $2); }
    ;

ReturnStatement
    : RETURN            ';' { $$ = new YYReturnStatement(cxt, null); }
    | RETURN Expression ';' { $$ = new YYReturnStatement(cxt, $2); }
    ;

// 19.12: Expressions

Primary
    : PrimaryNoNewArray
    | ArrayCreationExpression
    ;

BracedExpression
    : '(' Expression ')' { $$ = $2.expand(cxt); }
    //    | '(' error ')'
    ;

PrimaryNoNewArray
    : Literal                         { $$ = $1; }
    | THIS                            { $$ = new YYThis(cxt, YYThis.THIS); }
    | BracedExpression
    | ClassInstanceCreationExpression
    | FieldAccess                     { $$ = $1; }
    | MethodInvocation
    | ArrayAccess                     { $$ = $1; }
    | Name '.' THIS /* 1.1 */         { notSupported(cxt, "inner classes"); }
    | ClassLiteral /* 1.1 */          { notSupported(cxt, "class literal (obj.class)"); }
    | NativeExpression
    | NativeString
    ;

NativeExpression
    : NH_EXPRESSION '('                   { lexmode = Lexer.NATIVE_EXPRESSION; }
                        NATIVE_EXPRESSION { lexmode = Lexer.JAVA_TOKEN; }
                    ')'                   { $$ = new YYEnclosedNativeExpression(cxt, $4); }
    ;

NativeString
    : NH_STRING '('                               { lexmode = Lexer.NATIVE_STRING; }
                    NATIVE_STRING                 { lexmode = Lexer.JAVA_TOKEN; }
                ')'                               { $$ = new YYEnclosedNativeString(cxt, $4); }

    | NH_UNICODE_STRING '('                       { lexmode = Lexer.NATIVE_UNICODE_STRING; }
                            NATIVE_UNICODE_STRING { lexmode = Lexer.JAVA_TOKEN; }
                        ')'                       { $$ = new YYEnclosedNativeString(cxt, $4, true); }
    ;

ClassLiteral
    : PrimitiveType '.' CLASS { notSupported(cxt, "class literal (obj.class)"); }
    | Name '.' CLASS          { notSupported(cxt, "class literal (obj.class)"); }
    | ArrayType '.' CLASS     { notSupported(cxt, "class literal (obj.class)"); }
    | VOID '.' CLASS          { notSupported(cxt, "class literal (obj.class)"); }
    ;

ClassInstanceCreationExpression
    : NEW ClassType Arguments { $$ = new YYClassInstanceCreationExpression(cxt, $2, $3); }
    | Primary '.' NEW IDENTIFIER Arguments  /* 1.1 */ { notSupported(cxt, "inner classes"); }
    ;

ArgumentList
    : Expression                  { $$ = new YYExpressionList(cxt).add($1); }
    | ArgumentList ',' Expression { $$ = $1.add($3); }
    ;

Arguments
    : '(' ArgumentList ')' { $$ = $2.expand(cxt); }
    | '('              ')' { $$ = new YYExpressionList(cxt); }
	//    | Name '(' error ')' {}
	//    | Primary '.' IDENTIFIER '(' error ')'
	//    | SUPER '.' IDENTIFIER '(' error ')'
    ;

ArrayCreationExpression
    : NEW PrimitiveType DimExprs Dims                          { $$ = new YYArrayCreationExpression(cxt, $2, $3, $4.dims()); }
    | NEW PrimitiveType DimExprs                               { $$ = new YYArrayCreationExpression(cxt, $2, $3, 0); }
    | NEW PrimitiveType Dims ArrayInitializer /* 1.1 */        { notSupported(cxt, "array creation expression with initializer"); }
    | NEW ClassOrInterfaceType DimExprs Dims                   { $$ = new YYArrayCreationExpression(cxt, $2, $3, $4.dims()); }
    | NEW ClassOrInterfaceType DimExprs                        { $$ = new YYArrayCreationExpression(cxt, $2, $3, 0); }
    | NEW ClassOrInterfaceType Dims ArrayInitializer /* 1.1 */ { notSupported(cxt, "array creation expression with initializer"); }
    ;

DimExprs
    : DimExpr          { $$ = new YYExpressionList(cxt).add($1); }
    | DimExprs DimExpr { $$ = $1.add($2); }
    ;

DimExpr
    : '[' Expression ']' { $$ = $2.expand(cxt); }
    //    | '[' error ']'
    ;

Dims
    : '[' ']'      { $$ = new YYDims(cxt).addDim(cxt); }
    | Dims '[' ']' { $$ = $1.addDim(cxt); }
    ;

Super
    : SUPER { $$ = new YYThis(cxt, YYThis.SUPER); }
    ;

FieldAccess
    : Primary '.' IDENTIFIER { $$ = new YYFieldAccessExpression(cxt, $1, $3); }
    | Super '.' IDENTIFIER   { $$ = new YYFieldAccessExpression(cxt, $1, $3); }
    ;

MethodInvocation
    : MethodInvocationHeader Arguments { $$ = $1.addArguments($2).expand(cxt); }
    ;

MethodInvocationHeader
    : Name                   { $$ = $1.reclassifyAsMethodInvocation(cxt); }
    | Primary '.' IDENTIFIER { $$ = new YYMethodInvocationExpression(cxt, $1, $3); }
    | Super '.' IDENTIFIER   { $$ = new YYMethodInvocationExpression(cxt, $1, $3); }
    ;

ArrayAccess
    : Name DimExpr              { $$ = new YYArrayAccessExpression(cxt, $1.reclassifyAsExpression(cxt), $2); }
    | PrimaryNoNewArray DimExpr { $$ = new YYArrayAccessExpression(cxt, $1, $2); }
    ;

PostfixExpression
    : Primary
    | Name    { $$ = $1.reclassifyAsExpression(cxt); } //{ new YYNameExpression(cxt, $1); }
    | PostIncrementExpression
    | PostDecrementExpression
    ;

PostIncrementExpression
    : PostfixExpression PLUSPLUS { notSupported(cxt, "operator ++"); }
    ;

PostDecrementExpression
    : PostfixExpression MINUSMINUS { notSupported(cxt, "operator --"); }
    ;

UnaryExpression
    : PreIncrementExpression
    | PreDecrementExpression
    | '+' UnaryExpression          { $$ = $2; }
    | '-' UnaryExpression          { notSupported(cxt, "unary minus operator"); }
    | '&' UnaryExpression          { $$ = new YYPtrFetchExpression(cxt, $2, false); }
    | NH_ARRAY_PTR UnaryExpression { $$ = new YYPtrFetchExpression(cxt, $2, true); } /* #& */
    | UnaryExpressionNotPlusMinus
    ;

PreIncrementExpression
    : PLUSPLUS UnaryExpression { notSupported(cxt, "++ operator"); }
    ;

PreDecrementExpression
    : MINUSMINUS UnaryExpression { notSupported(cxt, "-- operator"); }
    ;

UnaryExpressionNotPlusMinus
    : PostfixExpression
    | '~' UnaryExpression { notSupported(cxt, "~ operator"); }
    | '!' UnaryExpression { notSupported(cxt, "! operator"); }
    | CastExpression
    ;

CastExpression
    : '(' PrimitiveType Dims ')' UnaryExpression     { $$ = new YYCastExpression(cxt, $2.addDims(cxt, $3.dims()), $5); }
    | '(' PrimitiveType      ')' UnaryExpression     { $$ = new YYCastExpression(cxt, $2, $4); }
    | '(' Expression ')' UnaryExpressionNotPlusMinus { $$ = new YYCastExpression(cxt, $2, $4); }
    | '(' Name Dims ')' UnaryExpressionNotPlusMinus  { $$ = new YYCastExpression(cxt, $2.reclassifyAsType().addDims(cxt, $3.dims()), $5); }

//    | '(' error ')' UnaryExpressionNotPlusMinus
    ;

MultiplicativeExpression
    : UnaryExpression
    | MultiplicativeExpression '*' UnaryExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Multiply(cxt), $3); }
    | MultiplicativeExpression '/' UnaryExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Divide(cxt), $3); }
    | MultiplicativeExpression '%' UnaryExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Remainder(cxt), $3); }
    ;

AdditiveExpression
    : MultiplicativeExpression
    | AdditiveExpression '+' MultiplicativeExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Plus(cxt), $3); }
    | AdditiveExpression '-' MultiplicativeExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Minus(cxt), $3); }
    ;

ShiftExpression
    : AdditiveExpression
    | ShiftExpression LSHIFT AdditiveExpression    { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.LShift(cxt), $3); }
    | ShiftExpression RSHIFT AdditiveExpression    { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.RShift(cxt), $3); }
    | ShiftExpression LOGRSHIFT AdditiveExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.LogRShift(cxt), $3); }
    ;

RelationalExpression
    : ShiftExpression
    | RelationalExpression '<' ShiftExpression      { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.LS, $1, $3); }
    | RelationalExpression '>' ShiftExpression      { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.GT, $1, $3); }
    | RelationalExpression LE ShiftExpression       { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.LE, $1, $3); }
    | RelationalExpression GE ShiftExpression       { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.GE, $1, $3); }
    | RelationalExpression INSTANCEOF ReferenceType { $$ = new YYInstanceOfExpression(cxt, $1, $3); }
    ;

EqualityExpression
    : RelationalExpression
    | EqualityExpression EQEQ RelationalExpression { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.EQ, $1, $3); }
    | EqualityExpression NE RelationalExpression   { $$ = new YYRelationalExpression(cxt, YYRelationalExpression.NE, $1, $3); }
    ;

AndExpression
    : EqualityExpression
    | AndExpression '&' EqualityExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.And(cxt), $3); }
    ;

ExclusiveOrExpression
    : AndExpression
    | ExclusiveOrExpression '^' AndExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.XOr(cxt), $3); }
    ;

InclusiveOrExpression
    : ExclusiveOrExpression
    | InclusiveOrExpression '|' ExclusiveOrExpression { $$ = new YYBinaryExpression(cxt, $1, new BinaryOperator.Or(cxt), $3); }
    ;

ConditionalAndExpression
    : InclusiveOrExpression
    | ConditionalAndExpression ANDAND InclusiveOrExpression { $$ = new YYConditionalExpression(cxt, YYConditionalExpression.AND, $1, $3); }
    ;

ConditionalOrExpression
    : ConditionalAndExpression
    | ConditionalOrExpression OROR ConditionalAndExpression { $$ = new YYConditionalExpression(cxt, YYConditionalExpression.OR, $1, $3); }
    ;

ConditionalExpression
    : ConditionalOrExpression
    | ConditionalOrExpression '?' Expression ':' ConditionalExpression { notSupported(cxt, "?: operator"); }
    ;

AssignmentExpression
    : ConditionalExpression
    | Assignment            { $$ = $1; }
    ;

Assignment
    : LeftHandSide AssignmentOperator AssignmentExpression { $$ = new YYAssignmentExpression(cxt, $1, $2, $3); }
    ;

LeftHandSide
    : Name { $$ = $1.reclassifyAsExpression(cxt); }
    | FieldAccess
    | ArrayAccess
    ;

AssignmentOperator
    : '='         { $$ = null; }
    | EQMUL       { $$ = new BinaryOperator.Multiply(cxt); }
    | EQDIV       { $$ = new BinaryOperator.Divide(cxt); }
    | EQMOD       { $$ = new BinaryOperator.Remainder(cxt); }
    | EQADD       { $$ = new BinaryOperator.Plus(cxt); }
    | EQSUB       { $$ = new BinaryOperator.Minus(cxt); }
    | EQLSHIFT    { $$ = new BinaryOperator.LShift(cxt); }
    | EQRSHIFT    { $$ = new BinaryOperator.RShift(cxt); }
    | EQLOGRSHIFT { $$ = new BinaryOperator.LogRShift(cxt); }
    | EQAND       { $$ = new BinaryOperator.And(cxt); }
    | EQXOR       { $$ = new BinaryOperator.XOr(cxt); }
    | EQOR        { $$ = new BinaryOperator.Or(cxt); }
    ;

Expression
    : AssignmentExpression
    ;

%%

    public static final int YYRET_EPSILON             = 0x0011;
    public static final int YYRET_EXPRESSION          = 0x0012;
    public static final int YYRET_STATEMENTS          = 0x0013;
    public static final int YYRET_ENCLOSED_STATEMENTS = 0x0014;

/* Override yyerror */
    public
	void
	yyverror(String msg) throws ParseException { yyerror(msg,true,true); }

public void parseError(String msg) throws ParseException {
    String desc;
    if (yychar == YYEOF) {
	desc = "unexpected end of file";
    } else {
	desc = "parse error: '" + yytext() + "'";
    }
    if (msg != null && msg != "parse error") desc += "; " + msg;
    Parser.reportError(tokencxt, desc);
}

/*

public static void compileError(IJavaContext cxt, String msg, boolean errthrow)
        throws CompileException {
    YYLocation lbeg = cxt.lbeg();
    InputBuffer ibuf = cxt.ibuf();
    String line = ibuf.getLine(lbeg);
    
    System.err.println("Compile error: " + msg);
    System.err.println("At: " + lbeg);
    System.err.println(line);
    for (int i=0; i<lbeg.charno; i++) {
	char c = line.charAt(i);
	if (Character.isWhitespace(c)) // e.g. \t
	    System.err.print("" + c);
	else
	    System.err.print(" ");
    }
    System.err.println("^");
    if(errthrow) throw new CompileException(msg);
}
*/

public static void notSupported(IJavaContext cxt, String what) throws CompileException {
    cxt.reportError("The " + what + " is not yet supported in this version of" +
        " Janet in embedded Java expressions.");
}

/* */


/* Parse context */

IMutableContext cxt = new IMutableContext() {
	public final YYLocation lbeg() { return EmbeddedParser.this.lbeg(); }
	public final YYLocation lend() { return EmbeddedParser.this.lend(); }
	public final InputBuffer ibuf() { return outer_cxt.ibuf(); }

	public final void reportError(String msg) throws CompileException { pl.edu.agh.icsr.janet.Parser.reportError(this, msg); }

	public final ClassManager getClassManager() { return outer_cxt.getClassManager(); }
	public final YYCompilationUnit getCompilationUnit() { return outer_cxt.getCompilationUnit(); }
	public final IScope getScope() { return outer_cxt.getScope(); }
	public VariableStack getVariables() { return outer_cxt.getVariables(); }
	public void pushScope(IScope unit) { outer_cxt.pushScope(unit); }
	public IScope popScope() { return outer_cxt.popScope(); }
	public void addVariable(YYVariableDeclarator var) throws CompileException { outer_cxt.addVariable(var); }
	public void addVariables(YYVariableDeclaratorList vars) throws CompileException { outer_cxt.addVariables(vars); }
    };

ILocationContext tokencxt = new ILocationContext() {
	public final YYLocation lbeg() { return yylex.tokenloc(); }
	public final YYLocation lend() { return cxt.lend(); }
	public final InputBuffer ibuf() { return cxt.ibuf(); }
	public final void reportError(String msg) throws CompileException {
	    throw new UnsupportedOperationException();
	}
    };

// redirection to cxt
void pushScope(IScope unit) { cxt.pushScope(unit); }
IScope popScope() { return cxt.popScope(); }
IScope peekScope() { return cxt.getScope(); }
void addVariable(YYVariableDeclarator var) throws CompileException { cxt.addVariable(var); }
void addVariables(YYVariableDeclaratorList vars) throws CompileException { cxt.addVariables(vars); }

// parse modes

//public final static int EXPRESSION = 401;
//public final static int STATEMENTS = 402;


int getInitialLexMode() { //int yymode) {
    return Lexer.JAVA_TOKEN;
}
