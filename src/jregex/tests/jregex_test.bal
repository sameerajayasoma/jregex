import ballerina/test;

const inputTextBallerina = "This is Ballerina, have you heard about Ballerina before? Ballerina is a Programming Language.";

@test:Config {
}
function testPatternMatch() {
    boolean matched = matches(regex = ".r", input = "br");
    test:assertEquals(matched, true);
}

@test:Config {
}
function testPatternCompile() {
    Pattern pattern = compile(regex = ".r");
    Matcher matcher = pattern.matcher(input = "br");
    boolean matched = matcher.matches();
    test:assertEquals(matched, true);
}

@test:Config {
}
function testMatcherGroupFind() {
    GroupMatch[] expectedMatches = [];
    GroupMatch[3] actualMatches = [
            {subMatch: "Ballerina", startIndex: 8, endIndex: 17},
            {subMatch: "Ballerina", startIndex: 40, endIndex: 49},
            {subMatch: "Ballerina", startIndex: 58, endIndex: 67}
        ];

    Pattern pattern = compile(regex = "Ballerina");
    Matcher matcher = pattern.matcher(input = inputTextBallerina);
    boolean found = false;
    while matcher.find() {
        expectedMatches.push(<GroupMatch>{
            subMatch: matcher.findGroup(),
            startIndex: matcher.startIndex(),
            endIndex: matcher.endIndex()
        });
        found = true;
    }

    test:assertEquals(actualMatches.length(), expectedMatches.length());
    test:assertEquals(actualMatches, expectedMatches);
}

// Test utils
type GroupMatch record {
    string subMatch;
    int startIndex;
    int endIndex;
};
