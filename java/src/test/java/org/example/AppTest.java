package org.example;

import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;

public class AppTest
{
    @Nested
    @DisplayName("given foo is true")
    class FooIsTrueTest {
        @Test
        @DisplayName("it returns 'moo'")
        void returnsMoo() {
            assertThat(App.go(3), is("moo"));
        }
    }
    @Nested
    @DisplayName("given foo is false")
    class FooIsTrueTest {
        @Test
        @DisplayName("it returns 'roo'")
        void returnsMoo() {
            assertThat(App.go(3), is("roo"));
        }
    }
}