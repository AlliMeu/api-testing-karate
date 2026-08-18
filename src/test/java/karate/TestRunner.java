package karate;

import com.intuit.karate.junit5.Karate;
import org.junit.jupiter.api.condition.EnabledIfEnvironmentVariable;

class TestRunner {

    /** Always runs - no credentials needed. */
    @Karate.Test
    Karate testJsonPlaceholder() {
        return Karate.run("jsonplaceholder-posts").relativeTo(getClass());
    }

    /**
     * Needs a free personal token from gorest.co.in/my-account/access-tokens,
     * exported as GOREST_TOKEN. Skipped (not failed) when it's absent, so a
     * fresh clone - or CI without the secret configured - stays green rather
     * than red for a reason that has nothing to do with the code.
     */
    @Karate.Test
    @EnabledIfEnvironmentVariable(named = "GOREST_TOKEN", matches = ".+")
    Karate testGorest() {
        return Karate.run("gorest-users").relativeTo(getClass());
    }
}
