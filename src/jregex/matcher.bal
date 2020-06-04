import ballerina/java;

# An engine that performs match operations on a string by interpreting a Pattern.
public type Matcher object {
    // A reference to the Java Matcher object
    private handle jObjRef;

    function __init(handle jObjRef) {
        self.jObjRef = jObjRef;
    }

    # Attempts to match the entire region against the pattern.
    # 
    # If the match succeeds then more information can be obtained 
    # via the startIndex, endIndex, and findGroup methods.
    # 
    # + return - true if, and only if, the entire region sequence 
    #            matches this matcher's pattern
    public function matches() returns boolean {
        return matchesInMatcherClass(self.jObjRef);
    }

    # Attempts to find the next subsequence of the input sequence that matches 
    # the pattern.
    # 
    # This method starts at the beginning of this matcher's region, or, 
    # if a previous invocation of the method was successful and the matcher 
    # has not since been reset, at the first character not matched by the 
    # previous match.
    # 
    # If the startIndex is specified, then attempts to find the next subsequence 
    # of the input sequence that matches the pattern, starting at the 
    # specified index
    # 
    # If the match succeeds then more information can be obtained via the start, 
    # end, and group methods.
    # 
    # + startIndex - the index to start searching for a match
    # + return - true if, and only if, a subsequence of the input sequence 
    #            matches this matcher's pattern
    public function find(public int? startIndex = ()) returns boolean {  
        if startIndex is () {
            return findInMatcherClass(self.jObjRef);    
        } else {
            return findWithStartInMatcherClass(self.jObjRef, startIndex);
        }
    }

    # Returns the input subsequence matched by the previous match.
    # 
    # For a matcher m with input string s, the expressions 
    # m.findGroup() and s.substring(m.startIndex(), m.endIndex()) are equivalent.
    # 
    # Note that some patterns, for example a*, match the empty string. 
    # This method will return the empty string when the pattern successfully 
    # matches the empty string in the input.
    # 
    # + return - The (possibly empty) subsequence matched by the previous 
    #            match, in string form
    public function findGroup() returns string {
        var subSeqHandle = groupInMatcherClass(self.jObjRef);
        return getSubsequenceFromGroupResult(subSeqHandle);
    }

    # Returns the input subsequence captured by the given group during the 
    # previous match operation.
    # 
    # + index - The index of a capturing group in this matcher's pattern
    # + return - The (possibly empty) subsequence captured by the group during 
    #            the previous match, or null if the group failed to match part 
    #            of the input
    public function findGroupByIndex(int index) returns string {
        handle subSeqHandle = groupByIndexInMatcherClass(self.jObjRef, index);
        return getSubsequenceFromGroupResult(subSeqHandle);
    }

    # Returns the input subsequence captured by the given named-capturing group 
    # during the previous match operation.
    # 
    # + name - The name of a named-capturing group in this matcher's pattern
    # + return - The (possibly empty) subsequence captured by the named group 
    #            during the previous match, or null if the group failed to 
    #            match part of the input
    public function findGroupByName(string name) returns string {
        handle nameHandle = java:fromString(name);
        handle subSeqHandle = groupByNameInMatcherClass(self.jObjRef, nameHandle);
        return getSubsequenceFromGroupResult(subSeqHandle);
    }

    # Returns the start index of the previous match.
    # 
    # If the groupIndex is specified, then returns the start index of the 
    # subsequence captured by the given group during the previous match 
    # operation.
    # 
    # + groupIndex - The index of a capturing group in this matcher's pattern
    # + return - The index of the first character matched
    public function startIndex(public int? groupIndex = ()) returns int {
        if groupIndex is () {
            return startIndexInMatcherClass(self.jObjRef);
        } else {
            return startIndexByGroupInMatcherClass(self.jObjRef, groupIndex);
        }
    }

    # Returns the offset after the last character matched.
    # 
    # If the groupIndex is specified, returns the offset after the last 
    # character of the subsequence captured by the given group during the 
    # previous match operation.
    # 
    # + groupIndex - The index of a capturing group in this matcher's pattern
    # + return - The offset after the last character matched
    public function endIndex(public int? groupIndex = ()) returns int {
        if groupIndex is () {
            return endIndexInMatcherClass(self.jObjRef);
        } else {
            return endIndexByGroupInMatcherClass(self.jObjRef, groupIndex);
        }
    }
};


// ----------------------------------------
//  Functions with module-level visibility
// ----------------------------------------

function matchesInMatcherClass(handle matcherObj) returns boolean = @java:Method {
    name: "matches",
    class: "java.util.regex.Matcher"
} external;

function findInMatcherClass(handle matcherObj) returns boolean = @java:Method {
    name: "find",
    paramTypes: [],
    class: "java.util.regex.Matcher"
} external;

function findWithStartInMatcherClass(handle matcherObj, int startIndex) returns boolean = @java:Method {
    name: "find",
    paramTypes: ["int"],
    class: "java.util.regex.Matcher"
} external;

function groupInMatcherClass(handle matcherObj) returns handle = @java:Method {
    name: "group",
    paramTypes: [],
    class: "java.util.regex.Matcher"
} external;

function groupByIndexInMatcherClass(handle matcherObj, int index) returns handle = @java:Method {
    name: "group",
    paramTypes: ["int"],
    class: "java.util.regex.Matcher"
} external;

function groupByNameInMatcherClass(handle matcherObj, handle name) returns handle = @java:Method {
    name: "group",
    paramTypes: ["java.lang.String"],
    class: "java.util.regex.Matcher"
} external;

function startIndexInMatcherClass(handle matcherObj) returns int = @java:Method {
    name: "start",
    paramTypes: [],
    class: "java.util.regex.Matcher"
} external;

function startIndexByGroupInMatcherClass(handle matcherObj, int groupIndex) returns int = @java:Method {
    name: "start",
    paramTypes: ["int"],
    class: "java.util.regex.Matcher"
} external;

function endIndexInMatcherClass(handle matcherObj) returns int = @java:Method {
    name: "end",
    paramTypes: [],
    class: "java.util.regex.Matcher"
} external;

function endIndexByGroupInMatcherClass(handle matcherObj, int groupIndex) returns int = @java:Method {
    name: "end",
    paramTypes: ["int"],
    class: "java.util.regex.Matcher"
} external;

function getSubsequenceFromGroupResult(handle matcherGroupResult) returns string {
    // java:toString function returns `nil` if the input handle refers to a Java null. 
    var subSeq = java:toString(matcherGroupResult);
    if subSeq is () {
        panic error("Java Matcher.group() returned 'null'. This shouldn't have happened!");
    } else {
        return subSeq;
    }  
}
