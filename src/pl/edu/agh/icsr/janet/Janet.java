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

package pl.edu.agh.icsr.janet;

import java.io.*;
import java.util.*;
import pl.edu.agh.icsr.janet.yytree.YYCompilationUnit;

public class Janet {

    YYCompilationUnit tmpParseResult;
    PrintWriter ferr;
    Settings settings;

    private static final String generatedCodeLicense;

    // load the license for generated code
    static {
        try {
            Reader r = new InputStreamReader(new BufferedInputStream(
                Writer.class.getResourceAsStream("generated_code_license.txt")));
            StringBuffer buf = new StringBuffer(2048);
            int data;
            while ((data = r.read()) >= 0) {
                buf.append((char)data);
            }
            generatedCodeLicense = buf.toString();
        } catch (IOException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static String getGeneratedCodeLicense() {
        return generatedCodeLicense;
    }

    public static void main(String[] args) {

        Settings s = new Settings();
        Vector files = new Vector();
        int exitstatus = 0;

        try {
            for (int i=0; i<args.length; i++) {
                if (args[i].startsWith("-")) {
                    s.setParam(args[i]);
                } else {
                    files.add(args[i]);
                }
            }
            if (files.size() > 0) {
                exitstatus = new Janet(s).processFiles(files);
            } else {
                showUsageInfo();
            }
        } catch (JanetException e) {
            System.err.println(e.getMessage());
            exitstatus = 1;
        } finally {
            if (exitstatus > 0) System.exit(exitstatus);
        }
    }

    Janet(Settings settings) {
        this.settings = settings;
        ferr = new PrintWriter(System.err);
    }

    int processFiles(Collection files) {
        CompilationManager cm = new CompilationManager(this.settings);
        try {
            InputBuffer ibuf;
            Preprocessor jp;
            Lexer jl;
            Parser parser;

            for (Iterator i = files.iterator(); i.hasNext();) {
                ibuf = new InputBuffer((String)i.next(), 100, "ASCII");
                jp = new Preprocessor(ibuf);
                jl = new Lexer(jp, ferr, settings.dbg_level);
                parser = new Parser(jl, ferr);

                parser.setdebug(settings.dbg_level);
                parser.yyerrthrow = true;
                parser.yyparse(cm);
            }

            cm.resolve();

            if (settings.dump_classes) System.out.println(cm.dumpClasses());
            if (settings.dump_tree) System.out.println(cm.dumpTree());

//            System.out.print(cm);

            //cm.resolveTypes();
            //cm.resolveMethods();
            //cm.resolveClasses();
            //cm.resolveReferences();

            cm.translate(settings);
            System.out.flush();
            return 0;

        } catch(CompileException e) {
            ferr.println("No output generated");
            return 1;
        } catch(FileNotFoundException e) {
            ferr.println("File not found: " + e.getMessage());
            return 1;
        } catch(Exception e) {
            e.printStackTrace(ferr);
            return 1;
        } finally {
            ferr.flush();
        }
    }

    static void showUsageInfo() {
        System.out.println("Java Native Extensions (JANET), v1.0");
        System.out.println("Usage: janet [<options>] <input-files>");
        System.out.println("Recognized options:");
        System.out.println("   -debug[=dbglevel]   debug output; for translator debugging");
        System.out.println("   -dumpclasses        dumps parsed classes; for translator debugging");
        System.out.println("   -dumptree           dumps parsing trees");
        System.out.println("   -qnames             name output files with fully qualified class names");
        System.out.println("   -output=dir         output directory to write into");
        System.out.println("   -sourcecomments     include comments in output files");
        System.out.println("   -strict_access      strict access check for non-public members");
    }

    public static class JanetException extends Exception {
        JanetException(String s) { super(s); }
    }

    public static class Settings {
        String targetDirectory;
        boolean qnames = false;
        int dbg_level;
        boolean dump_classes;
        boolean dump_tree;
        boolean source_comments;
        boolean strict_access;

        Settings() {
            targetDirectory = null;
        }

        void setParam(String param) throws JanetException {
            String name, value = "";
            if (!param.startsWith("-")) {
                throw new RuntimeException();
            }
            int pos = param.indexOf("=");
            name = (pos < 0) ? param.substring(1) : param.substring(1, pos);
            value = (pos < 0) ? null : param.substring(pos+1);

            if (checkValue(name, "output", value, true)) {
                targetDirectory = value;
            } else if (checkValue(name, "qnames", value, false)) {
                qnames = true;
            } else if (name.equals("debug")) {
                dbg_level = (value == null ? 1 : parseInt(name, value));
            } else if (checkValue(name, "dumpclasses", value, false)) {
                dump_classes = true;
            } else if (checkValue(name, "dumptree", value, false)) {
                dump_tree = true;
            } else if (checkValue(name, "sourcecomments", value, false)) {
                source_comments = true;
            } else if (checkValue(name, "strict_access", value, false)) {
                strict_access = true;
            } else {
                Janet.showUsageInfo();
                throw new JanetException("Unrecognized option: " + name);
            }
        }

        private boolean checkValue(String name, String checkname, String value,
                boolean required) throws JanetException {
            if (name.equals(checkname)) {
                if (value == null && required) {
                    throw new JanetException("Missing value for parameter " +
                        name);
                }
                if (value != null && !required) {
                    throw new JanetException("Can't use a value for " +
                        "parameter " + name);
                }
                return true;
            }
            return false;
        }


        static int parseInt(String name, String value) throws JanetException {
            try {
                return Integer.parseInt(value);
            } catch (NumberFormatException e) {
                throw new JanetException("Invalid value for -" +
                    name + "= : \"" + value + "\" is not an integer");
            }

        }

        public String getTargetDirectory() { return targetDirectory; }
        public boolean getQnames() { return qnames; }
        public boolean sourceComments() { return source_comments; }
        public boolean strictAccess() { return strict_access; }
    }
}

