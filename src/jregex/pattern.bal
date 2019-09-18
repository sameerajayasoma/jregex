import ballerinax/java;

# A compiled representation of a regular expression.
# 
# A regular expression, specified as a string, must first be compiled into an 
# instance of this object. The resulting pattern can then be used to create a 
# Matcher object that can match arbitrary character sequences against the 
# regular expression. All of the state involved in performing a match resides 
# in the matcher, so many matchers can share the same pattern.
# 
# A typical invocation sequence is thus
# 
# ```ballerina
#   jregex:Pattern p = jregex:compile("a*b");
#   jregex:Matcher m = p.matcher("aaaaab");
#   var b = m.matches();
# ```
# 
# A matches function is defined by this module as a convenience for when a 
# regular expression is used just once. This function compiles an expression 
# and matches an input string against it in a single invocation. The statement
# 
# ```ballerina
#   var b = jregex:matches("a*b", "aaaaab");
# ```
# 
# is equivalent to the three statements above, though for repeated matches 
# it is less efficient since it does not allow the compiled pattern to be 
# reused.
# 
# Instances of this object are immutable and are safe for use by multiple 
# concurrent strands. Instances of the Matcher object are not safe for such use.
public type Pattern object {
    // A reference to the Java Pattern object
    private handle jObjRef;

    function __init(handle jObjRef) {
        self.jObjRef = jObjRef;
    }

    # Creates a matcher that will match the given input against this pattern.
    # 
    # + input - The string to be matched
    # + return - A new matcher for this pattern
    public function matcher(public string input) returns Matcher {
        handle inputHandle = java:fromString(input);
        handle matcherJObj = matcherInPatternClass(self.jObjRef, inputHandle);
        return new(matcherJObj);
    }
};

# Compiles the given regular expression into a pattern.
# 
# + regex - The expression to be compiled
# + return - The given regular expression compiled into a pattern
public function compile(public string regex) returns Pattern {
    handle regexHandle = java:fromString(regex);
    handle patternJObj = compileInPatternClass(regexHandle);
    return new(patternJObj);
}

# Compiles the given regular expression and attempts to match the given input against it.
# 
# + regex - The expression to be compiled
# + input - The character sequence to be matched
# + return - whether or not the regular expression matches on the input
public function matches(public string regex, public string input) returns boolean {
    handle regexHandle = java:fromString(regex);
    handle inputHandle = java:fromString(input);
    return matchesInPatternClass(regexHandle, inputHandle);
}


// ----------------------------------------
//  Functions with module-level visibility
// ----------------------------------------

function compileInPatternClass(handle regex) returns handle = @java:Method {
    name: "compile",
    paramTypes: ["java.lang.String"],
    class: "java.util.regex.Pattern"
} external;

function matcherInPatternClass(handle patternJObj, handle input) returns handle = @java:Method {
    name: "matcher",
    class: "java.util.regex.Pattern"
} external;

function matchesInPatternClass(handle regex, handle input) returns boolean = @java:Method {
    name: "matches",
    class: "java.util.regex.Pattern"
} external;
