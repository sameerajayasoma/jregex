## Module overview

The `sams/jregx` module provides a set of utilities to work with regular expressions.  This API has a close resemblance to Java [Pattern](https://docs.oracle.com/javase/8/docs/api/java/util/regex/Pattern.html)/[Matcher](https://docs.oracle.com/javase/8/docs/api/java/util/regex/Matcher.html) regex API. This is a mirror of the Java API for the most part.  Here are a few sample usages.

```ballerina 
import sams/jregex;
import ballerina/io;

public function main() {
    jregex:Pattern p = jregex:compile(regex = ".r");
    jregex:Matcher m = p.matcher(input = "br");
    var b = m.matches();
    io:println(b);
}
```

```ballerina 
import sams/jregex;
import ballerina/io;

public function main() {
    var b = jregex:matches(regex = ".r", input = "br");
    io:println(b);
}
```

```ballerina 
import sams/jregex;
import ballerina/io;

public function main() {
    string input = "Jack and Jill went up the hill. To fetch a pail of water. " + 
            "Jack fell down and broke his crown, and Jill came tumbling after.";
    var p = jregex:compile(regex = "Jack");
    var m = p.matcher(input);
    while m.find() {
        var output = string `Group: ${m.findGroup()}, start: ${m.startIndex()}, end: ${m.endIndex()}`;
        io:println(output);
    }
}
```