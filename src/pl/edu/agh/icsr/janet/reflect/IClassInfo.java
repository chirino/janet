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
 * The Original Code is the Java Language Extensions (JANET) package,
 * http://www.icsr.agh.edu.pl/janet.
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

package pl.edu.agh.icsr.janet.reflect;
import pl.edu.agh.icsr.janet.*;
import java.util.*;

public interface IClassInfo {

    final static int CAST_CORRECT          = 1;
    final static int CAST_REQUIRES_RTCHECK = 2;
    final static int CAST_INCORRECT        = 3;

    IClassInfo getDeclaringClass() throws CompileException;
    IClassInfo getSuperclass() throws CompileException;
    boolean isInterface() throws CompileException;
    boolean isArray();
    boolean isPrimitive();
    boolean isReference();
    String getSimpleName();
    String getPackageName() throws CompileException;
    String getFullName(); // throws CompileException;
    int getModifiers();
    boolean isAccessibleTo(String pkg) throws CompileException;
    String getSignature();// throws CompileException;
    IClassInfo getComponentType() throws CompileException;
    IClassInfo getArrayType() throws CompileException;
    IClassInfo getArrayType(int dims) throws CompileException;
    Map getInterfaces() throws CompileException;
    Map getDeclaredFields() throws CompileException;
    SortedMap getAccessibleFields() throws CompileException;
    SortedMap getFields(String name) throws CompileException;
    SortedMap getDeclaredMethods() throws CompileException;
    SortedMap getAccessibleMethods() throws CompileException;
    SortedMap getMethods(String name) throws CompileException;
    SortedMap getMethods(String name, String jlssign) throws CompileException;
    Map getConstructors() throws CompileException;
//    boolean equals(IClassInfo cls) throws CompileException;
    // in terms of method invocation conversion (JLS 5.3)
    boolean isAssignableFrom(IClassInfo cls) throws CompileException;
    int isCastableTo(IClassInfo cls) throws CompileException;
    boolean isSubclassOf(IClassInfo cls) throws CompileException; // sub or this

    void setWorkingFlag(boolean working);
    boolean getWorkingFlag();

    String getJNIName(); // throws CompileException;
    String getJNIType();
}
