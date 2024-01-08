package org.example;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;
import static org.junit.jupiter.params.provider.Arguments.arguments;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.params.ParameterizedTest;
import org.junit.jupiter.params.provider.Arguments;
import org.junit.jupiter.params.provider.MethodSource;

import java.util.stream.Stream;

public class AppTest
{
    static Stream<Arguments> argumentProvider() {
        return Stream.of(
                arguments("egg", "add", true),
                arguments("foo", "bar", false),
                arguments("paper", "title", true)
                );
    }

    @ParameterizedTest(name = "given inputs ''{0}'' and ''{1}'', it returns ''{2}''")
    @MethodSource("argumentProvider")
    void testWithMethodSource(String s, String t, boolean expected) {
        assertThat(App.go(s, t), is(expected));
    }

}
