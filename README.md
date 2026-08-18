# api-testing-karate

![CI](https://github.com/AlliMeu/api-testing-karate/actions/workflows/ci.yml/badge.svg)

Karate BDD API tests against two public sandbox APIs - status codes, response
body assertions, and a CSV-driven data test.

## What's here

| Feature file | Target | Needs a token? |
|---|---|---|
| `jsonplaceholder-posts.feature` | [JSONPlaceholder](https://jsonplaceholder.typicode.com) | No - always runs |
| `gorest-users.feature` | [GoRest](https://gorest.co.in) | Yes - see below |

The GoRest scenarios (a full CRUD flow plus a `Scenario Outline` that creates
several users from `data/users.csv`) need a personal free access token. That
token is **not** committed anywhere in this repo - `karate-config.js` reads it
from an environment variable, and the test method that needs it is annotated
with `@EnabledIfEnvironmentVariable`, so it's automatically **skipped** (not
failed) when the token isn't set. That's why CI stays green without any
secret configured, and why cloning this repo fresh and running `mvn test`
works immediately without extra setup - one feature file just runs a smaller
scope until you add your own token.

## Running the tests

```bash
mvn test
```

To also run the GoRest scenarios:

```bash
export GOREST_TOKEN=your_free_token_here   # from gorest.co.in/my-account/access-tokens
mvn test
```

Requires JDK 17 - Karate's embedded GraalJS engine isn't yet compatible with
newer JDKs. If `mvn test` fails with a `GraalVM`/`Unsafe` error, point
`JAVA_HOME` at a JDK 17 install and retry.

## HTML report

Each run generates `target/karate-reports/karate-summary.html` with a
scenario-by-scenario breakdown - open it in a browser after running the tests.
