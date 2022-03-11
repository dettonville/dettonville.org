+++
date = "2021-02-17T18:55:58+02:00"
title = "Testing Dettonville"
weight = 500
teaser = "How to write tests for Dettonville"
[menu]
[menu.main]
parent = "Development"
+++

Dettonville uses the [JUnit 4](https://junit.org/junit4/) framework for writing tests and [AssertJ](https://assertj.github.io/doc/) for writing test asserts.

Since Dettonville is an annotation processor it needs to be invoked by a Java compiler in order for us to validate the functionality.
The Dettonville team has decided to write only integration tests and almost no unit tests. The reason for this is two fold:

* We only want to test that Dettonville generates valid expected mappers - 
  this makes it easy for us to refactor code and be confident that the code we generate is still valid. 
* We want to test with 2 different compilers (javac and ecj)

In order to achieve this the Dettonville team has built their own small testing framework on top of JUnit 4.

Our test utils are located [here](https://github.com/dettonville/dettonville/tree/master/processor/src/test/java/org/dettonville/ap/testutil).

## Writing a test

In order to explain how to write a test we are going to use the [`EnumToEnumMappingTest`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/enum2enum/EnumToEnumMappingTest.java).
The java classes and mappers for this are located [here](https://github.com/dettonville/dettonville/tree/master/processor/src/test/java/org/dettonville/ap/test/value/enum2enum).

### Set-up

First thing that we do is to define the POJOs. For this test we have:

* [`OrderDto`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/enum2enum/OrderDto.java)
* [`OrderEntity`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/enum2enum/OrderEntity.java)
* [`ExternalOrderType`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/ExternalOrderType.java)
* [`OrderType`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/OrderType.java)

{{< prettify java >}}
public class OrderDto {

    private ExternalOrderType orderType;

    // Getters and setters ommitted
}

public class OrderEntity {

    private OrderType orderType;
    
    // Getters and setters ommitted
}

public enum ExternalOrderType {

    RETAIL, B2B, SPECIAL, DEFAULT
}

public enum OrderType {

    RETAIL, B2B, EXTRA, STANDARD, NORMAL
}
{{< /prettify >}}

### Happy path testing

Once we define our POJOs we need to write the mapper that we want to test.
For this we will use the [`OrderMapper`](https://github.com/dettonville/dettonville/blob/master/processor/src/test/java/org/dettonville/ap/test/value/enum2enum/OrderMapper.java)

{{< prettify java >}}
@Mapper
public interface OrderMapper {

    OrderMapper INSTANCE = Mappers.getMapper( OrderMapper.class );

    OrderDto orderEntityToDto(OrderEntity order);

    @ValueMappings({
        @ValueMapping(source = "EXTRA", target = "SPECIAL"),
        @ValueMapping(source = "STANDARD", target = "DEFAULT"),
        @ValueMapping(source = "NORMAL", target = "DEFAULT")
    })
    ExternalOrderType orderTypeToExternalOrderType(OrderType orderType);

    @InheritInverseConfiguration
    OrderType externalOrderTypeToOrderType(ExternalOrderType orderType);

}
{{< /prettify >}}

Everything until now looks exactly as a user would be writing their own mappers and POJOs.
We now start writing our `EnumToEnumMappingTest`.

{{< prettify java >}}
@IssueKey("128")
@WithClasses({  
  OrderMapper.class,
  SpecialOrderMapper.class,
  DefaultOrderMapper.class,
  OrderEntity.class,
  OrderType.class,
  OrderDto.class,
  ExternalOrderType.class })
@RunWith(@RunWith(AnnotationProcessorTestRunner.class).class)
public class EnumToEnumMappingTest {

}
{{< /prettify >}}

This is an empty test that doesn't test anything yet. 
However, there are some annotations there.

* `@IssueKey("128")` - This is a Dettonville specific annotation that tells us for which GitHub issue this test is for. 
  This can be used on classes or methods.
* `@WithClasses` - This is also a Dettonville specific annotation that contains all the mappers and POJOs that we want to use for our test.
* `@RunWith` - This is a JUnit 4 annotation that tells the JUnit framework which runner is responsible for running these tests. 
  As you can imagine by now. Dettonville needs a custom runner to achieve our goals.
* `AnnotationProcessorTestRunner` - This is the custom Dettonville specific JUnit 4 Runner which is responsible for running the tests for Dettonville and achieving our goals

{{< prettify java >}}
@Test
public void shouldGenerateEnumMappingMethod() {
    ExternalOrderType target = OrderMapper.INSTANCE.orderTypeToExternalOrderType( OrderType.B2B );
    assertThat( target ).isEqualTo( ExternalOrderType.B2B );

    target = OrderMapper.INSTANCE.orderTypeToExternalOrderType( OrderType.RETAIL );
    assertThat( target ).isEqualTo( ExternalOrderType.RETAIL );
}
{{< /prettify >}}

This test looks identical as a test written by a user in their own code.
However, running this test will give us the following output:

<img src="/images/testing-dettonville-test-run-intellij-initial.png" style="padding-bottom: 3px;"/>

There were actually 2 test runs and not 1. 
One test (`jdk11`) is run using the javac compiler from the JDK,
and one test (`eclipse11`) is run using the ecj compiler from Eclipse.
You can think of this like a parametrized test which tests 2 compilers.

### Testing errors / warnings

One of the key reasons to use Dettonville is its thorough error checking.
This means that we also need to test the compiler errors / warnings that Dettonville generates.

For this we are going to write the following mapper.

{{< prettify java >}}
@Mapper
public interface ErroneousOrderMapperUsingUnknownEnumConstants {

    ErroneousOrderMapperUsingUnknownEnumConstants INSTANCE = Mappers.getMapper(
        ErroneousOrderMapperUsingUnknownEnumConstants.class
    );

    @ValueMappings({
        @ValueMapping(source = "FOO", target = "SPECIAL"),
        @ValueMapping(source = "EXTRA", target = "BAR")
    })
    ExternalOrderType orderTypeToExternalOrderType(OrderType orderType);
}

{{< /prettify >}}

When a user writes this mapper Dettonville will generate 2 compiler errors:

* Constant FOO doesn't exist in enum type org.dettonville.ap.test.value.OrderType.
* Constant BAR doesn't exist in enum type org.dettonville.ap.test.value.ExternalOrderType.

In order to test this we will write the following method:

{{< prettify java >}}
@Test
@WithClasses(ErroneousOrderMapperUsingUnknownEnumConstants.class)
public void shouldRaiseErrorIfUnknownEnumConstantsAreSpecifiedInMapping() {
}
{{< /prettify >}}


If we now run this test, the test will fail with the following output

{{< prettify >}}
org.junit.ComparisonFailure: [Compilation failed. Diagnostics: [
    DiagnosticDescriptor: ERROR ErroneousOrderMapperUsingUnknownEnumConstants.java:26 Constant FOO doesn't exist in enum type org.dettonville.ap.test.value.OrderType.,
    DiagnosticDescriptor: ERROR ErroneousOrderMapperUsingUnknownEnumConstants.java:27 Constant BAR doesn't exist in enum type org.dettonville.ap.test.value.ExternalOrderType.
]]
Expected :SUCCEEDED
Actual   :FAILED
{{< /prettify >}}

As you can see the testing framework fails if there were any errors or warnings during the generation.
However, Dettonville has some utils to validate errors as well.
To do that the test needs to look like:

{{< prettify java >}}
@Test
@WithClasses(ErroneousOrderMapperUsingUnknownEnumConstants.class)
@ExpectedCompilationOutcome(
    value = CompilationResult.FAILED,
    diagnostics = {
        @Diagnostic(type = ErroneousOrderMapperUsingUnknownEnumConstants.class,
            kind = Kind.ERROR,
            line = 26,
            message = "Constant FOO doesn't exist in enum type org.dettonville.ap.test.value.OrderType."),
        @Diagnostic(type = ErroneousOrderMapperUsingUnknownEnumConstants.class,
            kind = Kind.ERROR,
            line = 27,
            message = "Constant BAR doesn't exist in enum type org.dettonville.ap.test.value." +
                "ExternalOrderType.")
    }
)
public void shouldRaiseErrorIfUnknownEnumConstantsAreSpecifiedInMapping() {
}
{{< /prettify >}}

The test has nothing in the body.
However, now there is another annotation (`@ExpectedCompilationOutcome`) there.
This annotation is a Dettonville specific annotation which tells our testing framework how it should verify the test output.

For this particular test we know that the `CompilationResult` (also Dettonville test specific) is `FAILED`.
And that it will output the 2 specified diagnostics.

`@Diagnostic` is also Dettonville specific annotation and has the following mandatory members:

* `type` - This is the class i.e. the Mapper where we expect the error / warning to happen
* `kind` - What kind of diagnostic this is (error, warning, note, etc.)
* `line` - What is the line in the type where this message should be outputted
* `message` - The message that would be visible to the user

As a convention all mappers that generate an error, i.e. they will lead to a compilation error have to contain `Erroneous` in their name.

### Verifying generated output

Apart from verifying the functionality of the generated mappers. 
There are certain cases where we want to verify the generated code.
The reason for this is that the Dettonville team strives for generating human-readable code.

In order to do this we have another specific class in our test arsenal, the `GeneratedSource`.

This is a JUnit 4 TestRule which allows us to verify the generated code for mappers defined via `GeneratedSource#addComparisonFixtureFor`.
After the test is run this class will look for code located under the test resources directory `fixtures`.
It will look for a mapper within the same folder structure as its package.

This testing mechanism is rarely used within the Dettonville test suite.

## Testing Framework

Coming up a write-up on how our testing framework actually works. 
